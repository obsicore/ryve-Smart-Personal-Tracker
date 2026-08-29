import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:hybrid_tracker/features/auth/data/models/app_user_model.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/splash_screen.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/login_screen.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/register_screen.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/onboarding_screen.dart';
import 'package:hybrid_tracker/features/dashboard/presentation/screens/home_screen.dart';
import 'package:hybrid_tracker/features/tasks/presentation/screens/task_list_screen.dart';
import 'package:hybrid_tracker/features/tasks/presentation/screens/task_detail_screen.dart';
import 'package:hybrid_tracker/features/habits/presentation/screens/habit_list_screen.dart';
import 'package:hybrid_tracker/features/habits/presentation/screens/habit_detail_screen.dart';
import 'package:hybrid_tracker/features/habits/presentation/screens/create_habit_screen.dart';
import 'package:hybrid_tracker/features/calendar/presentation/screens/calendar_screen.dart';
import 'package:hybrid_tracker/features/focus/presentation/screens/focus_screen.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/sleep_screen.dart';
import 'package:hybrid_tracker/features/sleep/presentation/screens/alarm_list_screen.dart';
import 'package:hybrid_tracker/features/profile/presentation/screens/profile_screen.dart';
import 'package:hybrid_tracker/features/wellness/presentation/screens/wellness_screen.dart';
import 'package:hybrid_tracker/features/wellness/presentation/screens/breathing_session_screen.dart';
import 'package:hybrid_tracker/features/goals/presentation/screens/goals_screen.dart';
import 'package:hybrid_tracker/features/goals/presentation/screens/goal_detail_screen.dart';
import 'package:hybrid_tracker/features/goals/presentation/screens/create_goal_screen.dart';
import 'package:hybrid_tracker/features/goals/presentation/screens/weekly_report_screen.dart';
import 'package:hybrid_tracker/features/journal/presentation/screens/journal_screen.dart';
import 'package:hybrid_tracker/features/journal/presentation/screens/write_entry_screen.dart';
import 'package:hybrid_tracker/features/ai/presentation/screens/ai_planner_screen.dart';
import 'package:hybrid_tracker/features/ai/presentation/screens/smart_reminder_setup_screen.dart';
import 'package:hybrid_tracker/features/gamification/presentation/screens/challenge_list_screen.dart';
import 'package:hybrid_tracker/features/social/presentation/screens/accountability_screen.dart';
import 'package:hybrid_tracker/features/social/presentation/screens/community_challenge_browser_screen.dart';
import 'package:hybrid_tracker/features/customization/presentation/screens/widget_config_screen.dart';
import 'package:hybrid_tracker/features/auth/presentation/screens/pin_lock_screen.dart';
import 'package:hybrid_tracker/features/customization/presentation/screens/appearance_screen.dart';
import 'package:hybrid_tracker/features/customization/presentation/screens/dashboard_customize_screen.dart';

part 'app_router.g.dart';

// ---------------------------------------------------------------------------
// Route name constants
// ---------------------------------------------------------------------------
abstract final class Routes {
  static const splash    = '/splash';
  static const login     = '/login';
  static const register  = '/register';
  static const onboarding = '/onboarding';
  static const home      = '/';
  static const tasks     = '/tasks';
  static const taskDetail = '/tasks/:id';
  static const habits    = '/habits';
  static const habitCreate = '/habits/create';
  static const habitDetail = '/habits/:id';
  static const focus     = '/focus';
  static const sleep     = '/sleep';
  static const alarms    = '/alarms';
  static const calendar  = '/calendar';
  static const profile   = '/profile';
  static const wellness  = '/wellness';
  static const breathing = '/wellness/breathing';
  static const goals     = '/goals';
  static const goalCreate = '/goals/create';
  static const goalDetail = '/goals/:id';
  static const weeklyReport = '/goals/weekly-report';
  static const journal   = '/journal';
  static const journalNew = '/journal/new';
  static const journalDetail = '/journal/:id';
  static const aiPlanner = '/ai-planner';
  static const smartReminders = '/smart-reminders';
  static const challenges = '/challenges';
  static const accountability = '/accountability';
  static const communityChallenges = '/community-challenges';
  static const widgetConfig = '/widgets';
  static const pinLock = '/pin-lock';
  static const appearance = '/appearance';
  static const dashboardCustomize = '/dashboard-customize';
}

// Routes that do NOT require authentication
const _publicRoutes = {
  Routes.splash,
  Routes.login,
  Routes.register,
  Routes.onboarding,
};

// ---------------------------------------------------------------------------
// Page transition helper — fade + subtle slide-up, 250 ms fastOutSlowIn
// ---------------------------------------------------------------------------
CustomTransitionPage<T> _fadeSlidePage<T>({
  required LocalKey pageKey,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.fastOutSlowIn,
      );
      return FadeTransition(
        opacity: curved,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.03),
            end: Offset.zero,
          ).animate(curved),
          child: child,
        ),
      );
    },
  );
}

// ---------------------------------------------------------------------------
// Router provider (code-gen via @riverpod)
// ---------------------------------------------------------------------------
@riverpod
GoRouter appRouter(Ref ref) {
  // Keep a listenable that notifies GoRouter whenever auth state changes so
  // the redirect callback re-runs automatically.
  final authNotifier = _AuthChangeNotifier(ref);

  return GoRouter(
    initialLocation: Routes.splash,
    refreshListenable: authNotifier,
    redirect: (BuildContext context, GoRouterState state) {
      final authState = ref.read(authStateProvider);
      final isLoggedIn = authState.valueOrNull != null;
      final isPublic = _publicRoutes.contains(state.matchedLocation);

      // Still loading — stay on splash
      if (authState.isLoading) {
        return state.matchedLocation == Routes.splash ? null : Routes.splash;
      }

      // Not logged in and trying to reach a protected route → login
      if (!isLoggedIn && !isPublic) {
        return Routes.login;
      }

      // Logged in but still on auth screens → home
      if (isLoggedIn &&
          (state.matchedLocation == Routes.login ||
              state.matchedLocation == Routes.register ||
              state.matchedLocation == Routes.splash)) {
        return Routes.home;
      }

      return null; // no redirect needed
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: Routes.login,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.onboarding,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: Routes.home,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        path: Routes.tasks,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const TaskListScreen(),
        ),
        routes: [
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return _fadeSlidePage(
                pageKey: state.pageKey,
                child: TaskDetailScreen(taskId: id),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.habits,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const HabitListScreen(),
        ),
        routes: [
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => _fadeSlidePage(
              pageKey: state.pageKey,
              child: const CreateHabitScreen(),
            ),
          ),
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return _fadeSlidePage(
                pageKey: state.pageKey,
                child: HabitDetailScreen(habitId: id),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.calendar,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const CalendarScreen(),
        ),
      ),
      GoRoute(
        path: Routes.focus,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const FocusScreen(),
        ),
      ),
      GoRoute(
        path: Routes.sleep,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const SleepScreen(),
        ),
      ),
      GoRoute(
        path: Routes.alarms,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const AlarmListScreen(),
        ),
      ),
      GoRoute(
        path: Routes.profile,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: Routes.wellness,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const WellnessScreen(),
        ),
        routes: [
          GoRoute(
            path: 'breathing',
            pageBuilder: (context, state) => _fadeSlidePage(
              pageKey: state.pageKey,
              child: const BreathingSessionScreen(),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.goals,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const GoalsScreen(),
        ),
        routes: [
          GoRoute(
            path: 'create',
            pageBuilder: (context, state) => _fadeSlidePage(
              pageKey: state.pageKey,
              child: const CreateGoalScreen(),
            ),
          ),
          GoRoute(
            path: 'weekly-report',
            pageBuilder: (context, state) => _fadeSlidePage(
              pageKey: state.pageKey,
              child: const WeeklyReportScreen(),
            ),
          ),
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return _fadeSlidePage(
                pageKey: state.pageKey,
                child: GoalDetailScreen(goalId: id),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.journal,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const JournalScreen(),
        ),
        routes: [
          GoRoute(
            path: 'new',
            pageBuilder: (context, state) => _fadeSlidePage(
              pageKey: state.pageKey,
              child: const WriteEntryScreen(),
            ),
          ),
          GoRoute(
            path: ':id',
            pageBuilder: (context, state) {
              final id = state.pathParameters['id']!;
              return _fadeSlidePage(
                pageKey: state.pageKey,
                child: WriteEntryScreen(entryId: id),
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: Routes.aiPlanner,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const AIPlannerScreen(),
        ),
      ),
      GoRoute(
        path: Routes.smartReminders,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const SmartReminderSetupScreen(),
        ),
      ),
      GoRoute(
        path: Routes.challenges,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const ChallengeListScreen(),
        ),
      ),
      GoRoute(
        path: Routes.accountability,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const AccountabilityScreen(),
        ),
      ),
      GoRoute(
        path: Routes.communityChallenges,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const CommunityChallengeBrowserScreen(),
        ),
      ),
      GoRoute(
        path: Routes.widgetConfig,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const WidgetConfigScreen(),
        ),
      ),
      GoRoute(
        path: Routes.pinLock,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const PinLockScreen(),
        ),
      ),
      GoRoute(
        path: Routes.appearance,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const AppearanceScreen(),
        ),
      ),
      GoRoute(
        path: Routes.dashboardCustomize,
        pageBuilder: (context, state) => _fadeSlidePage(
          pageKey: state.pageKey,
          child: const DashboardCustomizeScreen(),
        ),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Listenable that bridges Riverpod auth state → GoRouter refreshListenable
// ---------------------------------------------------------------------------
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen<AsyncValue<AppUser?>>(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}
