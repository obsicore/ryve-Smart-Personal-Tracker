import 'package:postgres/postgres.dart';
import 'package:uuid/uuid.dart';

import 'package:hybrid_tracker/core/services/neon_connection.dart';
import 'package:hybrid_tracker/features/social/data/models/community_challenge_model.dart';
import 'package:hybrid_tracker/features/social/data/models/partner_model.dart';

const _uuid = Uuid();

String generateInviteCode() {
  const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  final rand = DateTime.now().microsecondsSinceEpoch;
  return List.generate(6, (i) => chars[(rand ~/ (i + 1)) % chars.length]).join();
}

/// All Social & Accountability data lives directly on Neon — it is
/// inherently multi-user, so there is no meaningful offline-first local
/// copy (see the user's decision recorded in this phase's planning).
class SocialRepository {
  SocialRepository(this._holder);

  final NeonConnectionHolder _holder;

  Future<String> createInvite(String userId) async {
    final conn = await _holder.get();
    final code = generateInviteCode();
    final id = _uuid.v4();
    await conn.execute(
      Sql.named('''
        INSERT INTO partners (id, user_id, partner_id, invite_code, status, created_at, updated_at)
        VALUES (@id, @userId, NULL, @code, 'pending', now(), now())
      '''),
      parameters: {'id': id, 'userId': userId, 'code': code},
    );
    return code;
  }

  /// Redeems an invite code: links the redeeming user to the inviter
  /// symmetrically (two rows so each side can query "my partners" by
  /// user_id) and marks both accepted.
  Future<void> redeemInvite(String userId, String code) async {
    final conn = await _holder.get();
    final result = await conn.execute(
      Sql.named('''
        SELECT id, user_id FROM partners WHERE invite_code = @code AND status = 'pending'
      '''),
      parameters: {'code': code.trim().toUpperCase()},
    );
    if (result.isEmpty) {
      throw Exception('Invite code not found or already used.');
    }
    final inviteRow = result.first.toColumnMap();
    final inviterId = inviteRow['user_id'] as String;
    if (inviterId == userId) {
      throw Exception('You cannot redeem your own invite code.');
    }
    await conn.execute(
      Sql.named('''
        UPDATE partners SET partner_id = @userId, status = 'accepted', updated_at = now()
        WHERE id = @inviteId
      '''),
      parameters: {'userId': userId, 'inviteId': inviteRow['id']},
    );
    await conn.execute(
      Sql.named('''
        INSERT INTO partners (id, user_id, partner_id, status, created_at, updated_at)
        VALUES (@id, @userId, @inviterId, 'accepted', now(), now())
      '''),
      parameters: {'id': _uuid.v4(), 'userId': userId, 'inviterId': inviterId},
    );
  }

  Future<List<PartnerModel>> myPartners(String userId) async {
    final conn = await _holder.get();
    final result = await conn.execute(
      Sql.named('''
        SELECT p.id, p.user_id, p.partner_id, p.status, p.created_at,
               u.display_name, u.id as partner_uid,
               COALESCE(s.current_streak, 0) as streak,
               (SELECT count(*) FROM habit_logs hl
                  JOIN habits h ON h.id = hl.habit_id
                  WHERE h.user_id = u.id AND hl.log_date::date = current_date) as habits_today,
               u.updated_at as last_active
        FROM partners p
        JOIN users u ON u.id = p.partner_id
        LEFT JOIN streaks s ON s.user_id = u.id AND s.entity_type = 'overall'
        WHERE p.user_id = @userId AND p.status = 'accepted' AND p.partner_id IS NOT NULL
        ORDER BY p.created_at DESC
      '''),
      parameters: {'userId': userId},
    );
    return result.map((row) {
      final m = row.toColumnMap();
      return PartnerModel(
        id: m['id'] as String,
        userId: m['user_id'] as String,
        partnerId: m['partner_uid'] as String,
        partnerDisplayName: (m['display_name'] as String?) ?? 'Ryver',
        status: m['status'] as String,
        partnerStreak: (m['streak'] as num).toInt(),
        partnerHabitsToday: (m['habits_today'] as num).toInt(),
        partnerLastActive: m['last_active'] as DateTime?,
        createdAt: m['created_at'] as DateTime,
      );
    }).toList();
  }

  Future<void> checkIn(String partnershipId, String userId, String fromDisplayName) async {
    final conn = await _holder.get();
    await conn.execute(
      Sql.named('''
        INSERT INTO partner_check_ins (id, partnership_id, user_id, note, created_at)
        VALUES (@id, @pid, @uid, @note, now())
      '''),
      parameters: {
        'id': _uuid.v4(),
        'pid': partnershipId,
        'uid': userId,
        'note': '$fromDisplayName checked in',
      },
    );
  }

  Future<List<PartnerCheckInModel>> recentCheckIns(String userId) async {
    final conn = await _holder.get();
    final result = await conn.execute(
      Sql.named('''
        SELECT ci.id, ci.partnership_id, ci.user_id, ci.note, ci.created_at, u.display_name
        FROM partner_check_ins ci
        JOIN partners p ON p.id = ci.partnership_id
        JOIN users u ON u.id = ci.user_id
        WHERE p.user_id = @userId OR p.partner_id = @userId
        ORDER BY ci.created_at DESC LIMIT 20
      '''),
      parameters: {'userId': userId},
    );
    return result.map((row) {
      final m = row.toColumnMap();
      return PartnerCheckInModel(
        id: m['id'] as String,
        partnershipId: m['partnership_id'] as String,
        userId: m['user_id'] as String,
        fromDisplayName: (m['display_name'] as String?) ?? 'Ryver',
        note: m['note'] as String?,
        createdAt: m['created_at'] as DateTime,
      );
    }).toList();
  }

  Future<List<CommunityChallengeModel>> browseCommunityChallenges(String userId) async {
    final conn = await _holder.get();
    final result = await conn.execute(
      Sql.named('''
        SELECT c.id, c.title, c.description, c.challenge_type, c.target_value,
               c.start_date, c.end_date, c.is_active,
               (SELECT count(*) FROM community_participants cp WHERE cp.challenge_id = c.id) as participant_count,
               (SELECT current_value FROM community_participants cp2
                  WHERE cp2.challenge_id = c.id AND cp2.user_id = @userId) as my_progress
        FROM community_challenges c
        WHERE c.is_active = true
        ORDER BY c.end_date ASC
      '''),
      parameters: {'userId': userId},
    );
    return result.map((row) {
      final m = row.toColumnMap();
      return CommunityChallengeModel(
        id: m['id'] as String,
        title: m['title'] as String,
        description: m['description'] as String,
        challengeType: m['challenge_type'] as String,
        targetValue: (m['target_value'] as num).toInt(),
        startDate: m['start_date'] as DateTime,
        endDate: m['end_date'] as DateTime,
        isActive: m['is_active'] as bool,
        participantCount: (m['participant_count'] as num).toInt(),
        hasJoined: m['my_progress'] != null,
        myProgress: m['my_progress'] == null ? 0 : (m['my_progress'] as num).toInt(),
      );
    }).toList();
  }

  Future<void> joinCommunityChallenge(String challengeId, String userId, String displayName) async {
    final conn = await _holder.get();
    await conn.execute(
      Sql.named('''
        INSERT INTO community_participants (id, challenge_id, user_id, display_name, current_value, joined_at)
        VALUES (@id, @challengeId, @userId, @displayName, 0, now())
        ON CONFLICT DO NOTHING
      '''),
      parameters: {
        'id': _uuid.v4(),
        'challengeId': challengeId,
        'userId': userId,
        'displayName': displayName,
      },
    );
  }

  Future<List<LeaderboardEntryModel>> leaderboard(String challengeId) async {
    final conn = await _holder.get();
    final result = await conn.execute(
      Sql.named('''
        SELECT user_id, display_name, current_value
        FROM community_participants WHERE challenge_id = @challengeId
        ORDER BY current_value DESC LIMIT 50
      '''),
      parameters: {'challengeId': challengeId},
    );
    var rank = 0;
    return result.map((row) {
      rank++;
      final m = row.toColumnMap();
      return LeaderboardEntryModel(
        userId: m['user_id'] as String,
        displayName: m['display_name'] as String,
        currentValue: (m['current_value'] as num).toInt(),
        rank: rank,
      );
    }).toList();
  }
}
