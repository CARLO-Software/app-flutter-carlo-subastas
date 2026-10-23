import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_spacing.dart';
import '../../../core/theme/app_typography.dart';
import '../../../shared/widgets/app_text_field.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Juan Pérez');
  final _emailController = TextEditingController(text: 'juan@email.com');
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return null;
    if (value.length < 8) return 'Mínimo 8 caracteres';
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (_newPasswordController.text.isEmpty) return null;
    if (value != _newPasswordController.text) return 'Las contraseñas no coinciden';
    return null;
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // ponytail: simulate API call, replace with real endpoint
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!mounted) return;
    setState(() => _isLoading = false);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil actualizado')),
    );
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    return Scaffold(
      backgroundColor: c.background,
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: SingleChildScrollView(
        padding: AppSpacing.screenPadding,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSpacing.vGapMd,
              Text(
                'Datos personales',
                style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                controller: _nameController,
                label: 'Nombre completo',
                prefixIcon: const Icon(Icons.person_outline, size: 20),
                textCapitalization: TextCapitalization.words,
              ),
              AppSpacing.vGapMd,
              AppTextField(
                controller: _emailController,
                label: 'Correo electrónico',
                prefixIcon: const Icon(Icons.email_outlined, size: 20),
                keyboardType: TextInputType.emailAddress,
              ),
              AppSpacing.vGapXl,
              Text(
                'Cambiar contraseña',
                style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
              ),
              AppSpacing.vGapSm,
              Text(
                'Déjalo vacío si no deseas cambiar tu contraseña',
                style: AppTypography.bodySmall.copyWith(color: c.textTertiary),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                controller: _currentPasswordController,
                label: 'Contraseña actual',
                hint: '••••••••',
                obscureText: _obscureCurrent,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureCurrent ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: c.textTertiary,
                  ),
                  onPressed: () => setState(() => _obscureCurrent = !_obscureCurrent),
                ),
              ),
              AppSpacing.vGapMd,
              AppTextField(
                controller: _newPasswordController,
                label: 'Nueva contraseña',
                hint: '••••••••',
                obscureText: _obscureNew,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureNew ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: c.textTertiary,
                  ),
                  onPressed: () => setState(() => _obscureNew = !_obscureNew),
                ),
                validator: _validatePassword,
              ),
              AppSpacing.vGapMd,
              AppTextField(
                controller: _confirmPasswordController,
                label: 'Confirmar nueva contraseña',
                hint: '••••••••',
                obscureText: _obscureConfirm,
                prefixIcon: const Icon(Icons.lock_outline, size: 20),
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscureConfirm ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                    size: 20,
                    color: c.textTertiary,
                  ),
                  onPressed: () => setState(() => _obscureConfirm = !_obscureConfirm),
                ),
                validator: _validateConfirmPassword,
              ),
              AppSpacing.vGapXl,
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
                        )
                      : Text('Guardar cambios', style: AppTypography.button.copyWith(color: Colors.white)),
                ),
              ),
              AppSpacing.vGapXl,
            ],
          ),
        ),
      ),
    );
  }
}
