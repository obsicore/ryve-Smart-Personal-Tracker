import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/presentation/widgets/pulse_mark_painter.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).signInWithEmail(
          _emailController.text,
          _passwordController.text,
        );
    if (!mounted) return;
    final authState = ref.read(authNotifierProvider);
    authState.whenOrNull(
      data: (user) {
        if (user != null) context.go('/');
      },
      error: (e, _) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceFirst('Exception: ', ''))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bgColor = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final textColor = isDark ? AppColors.darkOnBackground : AppColors.lightOnBackground;
    final mutedColor = isDark ? AppColors.darkOnSurfaceMuted : AppColors.lightOnSurfaceMuted;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x3l),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 80),

                // Logo lockup
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: CustomPaint(
                          painter: PulseMarkPainter(
                            progress: 1.0,
                            dotScale: 1.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'R',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                            const TextSpan(
                              text: 'y',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFC9A84C),
                              ),
                            ),
                            TextSpan(
                              text: 've',
                              style: TextStyle(
                                fontFamily: 'Georgia',
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x4l),

                // Welcome headline
                Text(
                  'Welcome back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ).animate().fadeIn(duration: 280.ms, delay: 60.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  'Sign in to continue your rhythm',
                  style: TextStyle(fontSize: 14, color: mutedColor),
                ).animate().fadeIn(duration: 280.ms, delay: 80.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                // Email field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Email is required.';
                    final emailRx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                    if (!emailRx.hasMatch(v.trim())) return 'Enter a valid email.';
                    return null;
                  },
                ).animate().fadeIn(duration: 280.ms, delay: 100.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.md),

                // Password field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Password is required.';
                    return null;
                  },
                ).animate().fadeIn(duration: 280.ms, delay: 120.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                // Sign In button
                RyveButton(
                  label: 'Sign In',
                  onPressed: isLoading ? null : _submit,
                  isLoading: isLoading,
                ).animate().fadeIn(duration: 280.ms, delay: 140.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                // Register link
                Center(
                  child: TextButton(
                    onPressed: () => context.go('/register'),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14, color: mutedColor),
                        children: [
                          const TextSpan(text: "Don't have an account? "),
                          TextSpan(
                            text: 'Register',
                            style: TextStyle(
                              color: isDark
                                  ? AppColors.darkPrimary
                                  : AppColors.lightAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 280.ms, delay: 180.ms),

                const SizedBox(height: AppSpacing.x3l),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
