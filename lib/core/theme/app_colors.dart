import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary Colors
  static const Color primary = Color(0xFF6327E2);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF4C1D95);

  // Accent Colors (Secondary)
  static const Color accent = Color(0xFFAEF318);
  static const Color accentLight = Color(0xFFC5F74D);
  static const Color accentDark = Color(0xFF8BC612);

  // Status Colors (same in both themes)
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Status Badge Colors (same in both themes)
  static const Color statusDraft = Color(0xFF6B7280);
  static const Color statusSubmitted = Color(0xFF3B82F6);
  static const Color statusUnderReview = Color(0xFFF59E0B);
  static const Color statusApproved = Color(0xFF10B981);
  static const Color statusRejected = Color(0xFFEF4444);
  static const Color statusPublished = Color(0xFF8B5CF6);
}

/// Context-aware colors that adapt to light/dark mode.
/// Usage: `context.colors.background` instead of `AppColors.background`
class AdaptiveColors {
  final Brightness brightness;
  const AdaptiveColors(this.brightness);

  bool get _isDark => brightness == Brightness.dark;

  // Backgrounds
  Color get background => _isDark ? const Color(0xFF0F0F1A) : const Color(0xFFFFFFFF);
  Color get backgroundSecondary => _isDark ? const Color(0xFF1A1A2E) : const Color(0xFFF5F7FA);

  // Surfaces
  Color get surface => _isDark ? const Color(0xFF1E1E32) : const Color(0xFFFFFFFF);
  Color get surfaceVariant => _isDark ? const Color(0xFF2A2A42) : const Color(0xFFF0F4F8);

  // Text
  Color get textPrimary => _isDark ? const Color(0xFFF1F1F4) : const Color(0xFF1A1A2E);
  Color get textSecondary => _isDark ? const Color(0xFF9CA3AF) : const Color(0xFF6B7280);
  Color get textTertiary => _isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF);
  Color get textOnPrimary => const Color(0xFFFFFFFF);

  // Borders
  Color get border => _isDark ? const Color(0xFF2E2E48) : const Color(0xFFE5E7EB);
  Color get borderLight => _isDark ? const Color(0xFF252540) : const Color(0xFFF3F4F6);
  Color get borderDark => _isDark ? const Color(0xFF3A3A56) : const Color(0xFFD1D5DB);

  // Divider
  Color get divider => _isDark ? const Color(0xFF2E2E48) : const Color(0xFFE5E7EB);

  // Shadow
  Color get shadow => _isDark ? const Color(0x40000000) : const Color(0x1A000000);

  // Cards
  Color get card => _isDark ? const Color(0xFF1E1E32) : const Color(0xFFFFFFFF);
  Color get cardBorder => _isDark ? const Color(0xFF2E2E48) : const Color(0xFFE5E7EB);

  // Chips
  Color get chipSelected => AppColors.primary;
  Color get chipUnselected => _isDark ? const Color(0xFF2A2A42) : const Color(0xFFF5F7FA);
  Color get chipBorder => _isDark ? const Color(0xFF2E2E48) : const Color(0xFFE5E7EB);

  // Status light variants
  Color get successLight => _isDark ? const Color(0xFF064E3B) : const Color(0xFFD1FAE5);
  Color get warningLight => _isDark ? const Color(0xFF78350F) : const Color(0xFFFEF3C7);
  Color get errorLight => _isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2);
  Color get infoLight => _isDark ? const Color(0xFF1E3A5F) : const Color(0xFFDBEAFE);
}

extension AdaptiveColorsExtension on BuildContext {
  AdaptiveColors get colors => AdaptiveColors(Theme.of(this).brightness);
}
