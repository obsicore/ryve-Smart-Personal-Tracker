import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/presentation/widgets/pulse_mark_painter.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pathController;
  late final AnimationController _dotController;
  late final AnimationController _wordmarkController;
  late final AnimationController _taglineController;

  late final Animation<double> _pathAnim;
  late final Animation<double> _dotAnim;
  late final Animation<double> _wordmarkFade;
  late final Animation<Offset> _wordmarkSlide;
  late final Animation<double> _taglineFade;

  bool _navigated = false;

  @override
  void initState() {
    super.initState();

    _pathController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _dotController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _wordmarkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _taglineController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _pathAnim = CurvedAnimation(parent: _pathController, curve: Curves.easeOut);
    _dotAnim = CurvedAnimation(parent: _dotController, curve: Curves.elasticOut);
    _wordmarkFade = CurvedAnimation(parent: _wordmarkController, curve: Curves.easeOut);
    _wordmarkSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _wordmarkController, curve: Curves.easeOut));
    _taglineFade = CurvedAnimation(parent: _taglineController, curve: Curves.easeOut);

    _runSequence();
  }

  Future<void> _runSequence() async {
    await _pathController.forward();
    await Future.delayed(const Duration(milliseconds: 700));
    _dotController.forward();
    await Future.delayed(const Duration(milliseconds: 100));
    _wordmarkController.forward();
    await Future.delayed(const Duration(milliseconds: 200));
    _taglineController.forward();
    await Future.delayed(const Duration(milliseconds: 600));
    _navigate();
  }

  void _navigate() {
    if (_navigated || !mounted) return;
    _navigated = true;
    final authState = ref.read(authStateProvider);
    authState.when(
      data: (user) {
        if (mounted) {
          context.go(user != null ? '/' : '/login');
        }
      },
      loading: () { if (mounted) context.go('/login'); },
      error: (_, __) { if (mounted) context.go('/login'); },
    );
  }

  @override
  void dispose() {
    _pathController.dispose();
    _dotController.dispose();
    _wordmarkController.dispose();
    _taglineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1F17),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated pulse mark
            AnimatedBuilder(
              animation: Listenable.merge([_pathAnim, _dotAnim]),
              builder: (context, _) => SizedBox(
                width: 120,
                height: 120,
                child: CustomPaint(
                  painter: PulseMarkPainter(
                    progress: _pathAnim.value,
                    dotScale: _dotAnim.value,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Wordmark
            SlideTransition(
              position: _wordmarkSlide,
              child: FadeTransition(
                opacity: _wordmarkFade,
                child: RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'R',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF0EBE0),
                        ),
                      ),
                      TextSpan(
                        text: 'y',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFC9A84C),
                        ),
                      ),
                      TextSpan(
                        text: 've',
                        style: TextStyle(
                          fontFamily: 'Georgia',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFF0EBE0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),

            // Tagline
            FadeTransition(
              opacity: _taglineFade,
              child: const Text(
                'rhythm your life · thrive every day',
                style: TextStyle(
                  fontFamily: 'Georgia',
                  fontSize: 13,
                  color: Color(0xFF8A9E92),
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
