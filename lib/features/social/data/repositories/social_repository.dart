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
    final code = generateInviteCode();
    final id = _uuid.v4();
    await _holder.namedQuery('''
        INSERT INTO partners (id, user_id, partner_id, invite_code, status, created_at, updated_at)
        VALUES (@id, @userId, NULL, @code, 'pending', now(), now())
      ''', {'id': id, 'userId': userId, 'code': code});
    return code;
  }

  /// Redeems an invite code: links the redeeming user to the inviter
  /// symmetrically (two rows so each side can query "my partners" by
  /// user_id) and marks both accepted.
  Future<void> redeemInvite(String userId, String code) async {
    final rows = await _holder.namedQuery('''
        SELECT id, user_id FROM partners WHERE invite_code = @code AND status = 'pending'
      ''', {'code': code.trim().toUpperCase()});
    if (rows.isEmpty) {
      throw Exception('Invite code not found or already used.');
    }
    final inviteRow = rows.first;
    final inviterId = inviteRow['user_id'] as String;
    if (inviterId == userId) {
      throw Exception('You cannot redeem your own invite code.');
    }
    await _holder.namedQuery('''
        UPDATE partners SET partner_id = @userId, status = 'accepted', updated_at = now()
        WHERE id = @inviteId
      ''', {'userId': userId, 'inviteId': inviteRow['id']});
    await _holder.namedQuery('''
        INSERT INTO partners (id, user_id, partner_id, status, created_at, updated_at)
        VALUES (@id, @userId, @inviterId, 'accepted', now(), now())
      ''', {'id': _uuid.v4(), 'userId': userId, 'inviterId': inviterId});
  }

  Future<List<PartnerModel>> myPartners(String userId) async {
    final rows = await _holder.namedQuery('''
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
      ''', {'userId': userId});
    return rows.map((row) {
      return PartnerModel(
        id: row['id'] as String,
        userId: row['user_id'] as String,
        partnerId: row['partner_uid'] as String,
        partnerDisplayName: (row['display_name'] as String?) ?? 'Ryver',
        status: row['status'] as String,
        partnerStreak: (row['streak'] as num).toInt(),
        partnerHabitsToday: (row['habits_today'] as num).toInt(),
        partnerLastActive: row['last_active'] as DateTime?,
        createdAt: row['created_at'] as DateTime,
      );
    }).toList();
  }

  Future<void> checkIn(String partnershipId, String userId, String fromDisplayName) async {
    await _holder.namedQuery('''
        INSERT INTO partner_check_ins (id, partnership_id, user_id, note, created_at)
        VALUES (@id, @pid, @uid, @note, now())
      ''', {
      'id': _uuid.v4(),
      'pid': partnershipId,
      'uid': userId,
      'note': '$fromDisplayName checked in',
    });
  }

  Future<List<PartnerCheckInModel>> recentCheckIns(String userId) async {
    final rows = await _holder.namedQuery('''
        SELECT ci.id, ci.partnership_id, ci.user_id, ci.note, ci.created_at, u.display_name
        FROM partner_check_ins ci
        JOIN partners p ON p.id = ci.partnership_id
        JOIN users u ON u.id = ci.user_id
        WHERE p.user_id = @userId OR p.partner_id = @userId
        ORDER BY ci.created_at DESC LIMIT 20
      ''', {'userId': userId});
    return rows.map((row) {
      return PartnerCheckInModel(
        id: row['id'] as String,
        partnershipId: row['partnership_id'] as String,
        userId: row['user_id'] as String,
        fromDisplayName: (row['display_name'] as String?) ?? 'Ryver',
        note: row['note'] as String?,
        createdAt: row['created_at'] as DateTime,
      );
    }).toList();
  }

  Future<List<CommunityChallengeModel>> browseCommunityChallenges(String userId) async {
    final rows = await _holder.namedQuery('''
        SELECT c.id, c.title, c.description, c.challenge_type, c.target_value,
               c.start_date, c.end_date, c.is_active,
               (SELECT count(*) FROM community_participants cp WHERE cp.challenge_id = c.id) as participant_count,
               (SELECT current_value FROM community_participants cp2
                  WHERE cp2.challenge_id = c.id AND cp2.user_id = @userId) as my_progress
        FROM community_challenges c
        WHERE c.is_active = true
        ORDER BY c.end_date ASC
      ''', {'userId': userId});
    return rows.map((row) {
      return CommunityChallengeModel(
        id: row['id'] as String,
        title: row['title'] as String,
        description: row['description'] as String,
        challengeType: row['challenge_type'] as String,
        targetValue: (row['target_value'] as num).toInt(),
        startDate: row['start_date'] as DateTime,
        endDate: row['end_date'] as DateTime,
        isActive: row['is_active'] as bool,
        participantCount: (row['participant_count'] as num).toInt(),
        hasJoined: row['my_progress'] != null,
        myProgress: row['my_progress'] == null ? 0 : (row['my_progress'] as num).toInt(),
      );
    }).toList();
  }

  Future<void> joinCommunityChallenge(String challengeId, String userId, String displayName) async {
    await _holder.namedQuery('''
        INSERT INTO community_participants (id, challenge_id, user_id, display_name, current_value, joined_at)
        VALUES (@id, @challengeId, @userId, @displayName, 0, now())
        ON CONFLICT DO NOTHING
      ''', {
      'id': _uuid.v4(),
      'challengeId': challengeId,
      'userId': userId,
      'displayName': displayName,
    });
  }

  Future<List<LeaderboardEntryModel>> leaderboard(String challengeId) async {
    final rows = await _holder.namedQuery('''
        SELECT user_id, display_name, current_value
        FROM community_participants WHERE challenge_id = @challengeId
        ORDER BY current_value DESC LIMIT 50
      ''', {'challengeId': challengeId});
    var rank = 0;
    return rows.map((row) {
      rank++;
      return LeaderboardEntryModel(
        userId: row['user_id'] as String,
        displayName: row['display_name'] as String,
        currentValue: (row['current_value'] as num).toInt(),
        rank: rank,
      );
    }).toList();
  }
}
