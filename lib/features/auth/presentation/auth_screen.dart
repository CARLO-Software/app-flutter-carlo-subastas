import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/providers/theme_provider.dart';
import '../../../shared/widgets/app_text_field.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> with TickerProviderStateMixin {
  bool _isLogin = true;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  // Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Animations
  late AnimationController _entryController;
  late AnimationController _switchController;

  late Animation<double> _logoFade;
  late Animation<double> _logoScale;
  late Animation<Offset> _cardSlide;
  late Animation<double> _cardFade;

  // Staggered field animations
  final List<Animation<Offset>> _fieldSlides = [];
  final List<Animation<double>> _fieldFades = [];

  @override
  void initState() {
    super.initState();

    // Entry animation
    _entryController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut),
      ),
    );

    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.4, curve: Curves.elasticOut),
      ),
    );

    _cardSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.25, 0.6, curve: Curves.easeOutCubic),
      ),
    );

    _cardFade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.25, 0.6, curve: Curves.easeOut),
      ),
    );

    // Staggered fields (4 max for register)
    for (int i = 0; i < 4; i++) {
      final start = 0.4 + (i * 0.1);
      final end = (start + 0.2).clamp(0.0, 1.0);

      _fieldSlides.add(
        Tween<Offset>(
          begin: const Offset(0.15, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _entryController,
            curve: Interval(start, end, curve: Curves.easeOutCubic),
          ),
        ),
      );

      _fieldFades.add(
        Tween<double>(begin: 0, end: 1).animate(
          CurvedAnimation(
            parent: _entryController,
            curve: Interval(start, end, curve: Curves.easeOut),
          ),
        ),
      );
    }

    // Switch animation (login <-> register)
    _switchController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _entryController.forward();
  }

  @override
  void dispose() {
    _entryController.dispose();
    _switchController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _toggleMode() {
    setState(() => _isLogin = !_isLogin);
    _switchController.forward(from: 0);
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    // ponytail: simulate auth call, replace with real API
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;
    setState(() => _isLoading = false);
    context.go(AppRoutes.loading);
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.primaryDark,
      body: SafeArea(
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: bottomInset),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom -
                          bottomInset,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppSpacing.vGapXl,
                        _buildLogo(),
                        AppSpacing.vGapXl,
                        _buildFormCard(),
                        AppSpacing.vGapXl,
                      ],
                    ),
                  ),
                ),
              ),
              // Theme toggle button
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: _buildThemeToggle(),
              ),
            ],
          ),
        ),
    );
  }

  Widget _buildThemeToggle() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return IconButton(
      onPressed: () {
        ref.read(themeModeProvider.notifier).state =
            isDark ? ThemeMode.light : ThemeMode.dark;
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) => RotationTransition(
          turns: Tween(begin: 0.75, end: 1.0).animate(animation),
          child: FadeTransition(opacity: animation, child: child),
        ),
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey(isDark),
          color: Colors.white.withValues(alpha: 0.9),
          size: 24,
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return FadeTransition(
      opacity: _logoFade,
      child: ScaleTransition(
        scale: _logoScale,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: AppSpacing.borderRadiusXl,
              ),
              child: ClipRRect(
                borderRadius: AppSpacing.borderRadiusXl,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            AppSpacing.vGapMd,
            Text(
              'Carlo Subastas',
              style: AppTypography.headlineLarge.copyWith(
                color: context.colors.textOnPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormCard() {
    return SlideTransition(
      position: _cardSlide,
      child: FadeTransition(
        opacity: _cardFade,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.surface,
            borderRadius: AppSpacing.borderRadiusXl,
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTabToggle(),
                  AppSpacing.vGapLg,
                  _buildFields(),
                  AppSpacing.vGapLg,
                  _buildSubmitButton(),
                  if (_isLogin) ...[
                    AppSpacing.vGapMd,
                    _buildForgotPassword(),
                  ],
                  AppSpacing.vGapMd,
                  _buildDivider(),
                  AppSpacing.vGapMd,
                  _buildSocialButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabToggle() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: context.colors.surfaceVariant,
        borderRadius: AppSpacing.borderRadiusFull,
      ),
      child: Stack(
        children: [
          // Animated indicator
          AnimatedAlign(
            alignment: _isLogin
                ? Alignment.centerLeft
                : Alignment.centerRight,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                height: 44,
                margin: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: AppSpacing.borderRadiusFull,
                ),
              ),
            ),
          ),
          // Labels
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (!_isLogin) _toggleMode();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTypography.labelLarge.copyWith(
                        color: _isLogin
                            ? Colors.white
                            : context.colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      child: const Text('Iniciar Sesión'),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (_isLogin) _toggleMode();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Center(
                    child: AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: AppTypography.labelLarge.copyWith(
                        color: !_isLogin
                            ? Colors.white
                            : context.colors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                      child: const Text('Registrarse'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFields() {
    return AnimatedSize(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeInOutCubic,
      alignment: Alignment.topCenter,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0.05, 0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: _isLogin ? _buildLoginFields() : _buildRegisterFields(),
      ),
    );
  }

  Widget _buildLoginFields() {
    return Column(
      key: const ValueKey('login'),
      children: [
        _animatedField(
          0,
          AppTextField(
            controller: _emailController,
            label: 'Correo electrónico',
            hint: 'tu@email.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
        ),
        AppSpacing.vGapMd,
        _animatedField(
          1,
          AppTextField(
            controller: _passwordController,
            label: 'Contraseña',
            hint: '••••••••',
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: context.colors.textTertiary,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
            onEditingComplete: _submit,
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterFields() {
    return Column(
      key: const ValueKey('register'),
      children: [
        _animatedField(
          0,
          AppTextField(
            controller: _nameController,
            label: 'Nombre completo',
            hint: 'Juan Pérez',
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.person_outline, size: 20),
          ),
        ),
        AppSpacing.vGapMd,
        _animatedField(
          1,
          AppTextField(
            controller: _emailController,
            label: 'Correo electrónico',
            hint: 'tu@email.com',
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
          ),
        ),
        AppSpacing.vGapMd,
        _animatedField(
          2,
          AppTextField(
            controller: _passwordController,
            label: 'Contraseña',
            hint: '••••••••',
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: context.colors.textTertiary,
              ),
              onPressed: () =>
                  setState(() => _obscurePassword = !_obscurePassword),
            ),
          ),
        ),
        AppSpacing.vGapMd,
        _animatedField(
          3,
          AppTextField(
            controller: _confirmPasswordController,
            label: 'Confirmar contraseña',
            hint: '••••••••',
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            prefixIcon: const Icon(Icons.lock_outline, size: 20),
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 20,
                color: context.colors.textTertiary,
              ),
              onPressed: () => setState(
                  () => _obscureConfirmPassword = !_obscureConfirmPassword),
            ),
            onEditingComplete: _submit,
          ),
        ),
      ],
    );
  }

  Widget _animatedField(int index, Widget child) {
    if (index >= _fieldSlides.length) return child;

    return SlideTransition(
      position: _fieldSlides[index],
      child: FadeTransition(
        opacity: _fieldFades[index],
        child: child,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: AppSpacing.borderRadiusMd,
          color: _isLoading ? AppColors.primaryLight : AppColors.primary,
        ),
        child: ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: AppSpacing.borderRadiusMd,
            ),
          ),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: _isLoading
                ? SizedBox(
                    key: const ValueKey('loading'),
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(context.colors.textOnPrimary),
                    ),
                  )
                : Text(
                    _isLogin ? 'Iniciar Sesión' : 'Crear Cuenta',
                    key: ValueKey(_isLogin ? 'login_btn' : 'register_btn'),
                    style: AppTypography.button.copyWith(
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // ponytail: add forgot password flow when needed
        },
        child: Text(
          '¿Olvidaste tu contraseña?',
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: context.colors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text(
            'o continúa con',
            style: AppTypography.caption,
          ),
        ),
        Expanded(child: Divider(color: context.colors.border)),
      ],
    );
  }

  Widget _buildSocialButtons() {
    return Row(
      children: [
        Expanded(
          child: _SocialButton(
            icon: Icons.g_mobiledata_rounded,
            label: 'Google',
            onTap: () {
              // ponytail: add Google sign-in when needed
            },
          ),
        ),
        AppSpacing.hGapMd,
        Expanded(
          child: _SocialButton(
            icon: Icons.apple_rounded,
            label: 'Apple',
            onTap: () {
              // ponytail: add Apple sign-in when needed
            },
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceVariant,
      borderRadius: AppSpacing.borderRadiusMd,
      child: InkWell(
        onTap: onTap,
        borderRadius: AppSpacing.borderRadiusMd,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            borderRadius: AppSpacing.borderRadiusMd,
            border: Border.all(color: context.colors.border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 24, color: context.colors.textPrimary),
              AppSpacing.hGapSm,
              Text(
                label,
                style: AppTypography.labelLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
