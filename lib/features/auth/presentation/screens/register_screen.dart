import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hybrid_tracker/core/theme/app_colors.dart';
import 'package:hybrid_tracker/core/theme/app_spacing.dart';
import 'package:hybrid_tracker/features/auth/domain/providers/auth_providers.dart';
import 'package:hybrid_tracker/features/auth/presentation/widgets/pulse_mark_painter.dart';
import 'package:hybrid_tracker/shared/widgets/ryve_button.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    await ref.read(authNotifierProvider.notifier).register(
          _emailController.text,
          _passwordController.text,
          _nameController.text,
        );
    if (!mounted) return;
    final authState = ref.read(authNotifierProvider);
    authState.whenOrNull(
      data: (user) {
        if (user != null) context.go('/onboarding');
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
                const SizedBox(height: 60),

                // Logo
                Center(
                  child: SizedBox(
                    width: 64,
                    height: 64,
                    child: CustomPaint(
                      painter: PulseMarkPainter(
                        progress: 1.0,
                        dotScale: 1.0,
                      ),
                    ),
                  ),
                ).animate().fadeIn(duration: 280.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                Text(
                  'Create your account',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ).animate().fadeIn(duration: 280.ms, delay: 60.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.xs),

                Text(
                  'Start your journey with Ryve',
                  style: TextStyle(fontSize: 14, color: mutedColor),
                ).animate().fadeIn(duration: 280.ms, delay: 80.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                // Display name
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    labelText: 'Display Name',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return 'Name is required.';
                    if (v.trim().length < 2) return 'Name must be at least 2 characters.';
                    return null;
                  },
                ).animate().fadeIn(duration: 280.ms, delay: 100.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.md),

                // Email
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
                ).animate().fadeIn(duration: 280.ms, delay: 120.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.md),

                // Password
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.next,
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
                    if (v.length < 6) return 'Password must be at least 6 characters.';
                    return null;
                  },
                ).animate().fadeIn(duration: 280.ms, delay: 140.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.md),

                // Confirm password
                TextFormField(
                  controller: _confirmController,
                  obscureText: _obscureConfirm,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return 'Please confirm your password.';
                    if (v != _passwordController.text) return 'Passwords do not match.';
                    return null;
                  },
                ).animate().fadeIn(duration: 280.ms, delay: 160.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.x3l),

                RyveButton(
                  label: 'Create Account',
                  onPressed: isLoading ? null : _submit,
                  isLoading: isLoading,
                ).animate().fadeIn(duration: 280.ms, delay: 180.ms).slideY(begin: 0.2, end: 0),

                const SizedBox(height: AppSpacing.md),

                Center(
                  child: TextButton(
                    onPressed: () => context.go('/login'),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(fontSize: 14, color: mutedColor),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Sign In',
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
                ).animate().fadeIn(duration: 280.ms, delay: 200.ms),

                const SizedBox(height: AppSpacing.x3l),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
