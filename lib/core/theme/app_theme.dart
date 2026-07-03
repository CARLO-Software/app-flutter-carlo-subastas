import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_typography.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme => _buildTheme(Brightness.light);
  static ThemeData get darkTheme => _buildTheme(Brightness.dark);

  static ThemeData _buildTheme(Brightness brightness) {
    final c = AdaptiveColors(brightness);
    final isDark = brightness == Brightness.dark;

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: AppColors.primary,
        onPrimary: c.textOnPrimary,
        primaryContainer: AppColors.primaryLight,
        secondary: AppColors.accent,
        onSecondary: c.textOnPrimary,
        secondaryContainer: AppColors.accentLight,
        surface: c.surface,
        onSurface: c.textPrimary,
        error: AppColors.error,
        onError: c.textOnPrimary,
        outline: c.border,
      ),
      scaffoldBackgroundColor: c.background,
      appBarTheme: AppBarTheme(
        backgroundColor: c.background,
        foregroundColor: c.textPrimary,
        elevation: 0,
        scrolledUnderElevation: 1,
        centerTitle: true,
        systemOverlayStyle: isDark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        titleTextStyle: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        iconTheme: IconThemeData(
          color: c.textPrimary,
          size: 24,
        ),
      ),
      cardTheme: CardThemeData(
        color: c.card,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          side: BorderSide(color: c.cardBorder),
        ),
        margin: EdgeInsets.zero,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: c.textOnPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          textStyle: AppTypography.button,
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTypography.button,
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.accent,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          textStyle: AppTypography.button,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: c.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: c.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: BorderSide(color: c.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: AppSpacing.borderRadiusMd,
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        hintStyle: AppTypography.bodyLarge.copyWith(
          color: c.textTertiary,
        ),
        labelStyle: AppTypography.bodyMedium.copyWith(
          color: c.textSecondary,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: c.chipUnselected,
        selectedColor: c.chipSelected,
        labelStyle: AppTypography.labelLarge,
        secondaryLabelStyle: AppTypography.labelLarge.copyWith(
          color: c.textOnPrimary,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: AppSpacing.borderRadiusSm,
          side: BorderSide(color: c.chipBorder),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: c.divider,
        thickness: 1,
        space: 1,
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: c.surfaceVariant,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: c.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: c.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
      textTheme: TextTheme(
        displayLarge: AppTypography.displayLarge.copyWith(color: c.textPrimary),
        displayMedium: AppTypography.displayMedium.copyWith(color: c.textPrimary),
        displaySmall: AppTypography.displaySmall.copyWith(color: c.textPrimary),
        headlineLarge: AppTypography.headlineLarge.copyWith(color: c.textPrimary),
        headlineMedium: AppTypography.headlineMedium.copyWith(color: c.textPrimary),
        headlineSmall: AppTypography.headlineSmall.copyWith(color: c.textPrimary),
        titleLarge: AppTypography.titleLarge.copyWith(color: c.textPrimary),
        titleMedium: AppTypography.titleMedium.copyWith(color: c.textPrimary),
        titleSmall: AppTypography.titleSmall.copyWith(color: c.textPrimary),
        labelLarge: AppTypography.labelLarge.copyWith(color: c.textPrimary),
        labelMedium: AppTypography.labelMedium.copyWith(color: c.textPrimary),
        labelSmall: AppTypography.labelSmall.copyWith(color: c.textSecondary),
        bodyLarge: AppTypography.bodyLarge.copyWith(color: c.textPrimary),
        bodyMedium: AppTypography.bodyMedium.copyWith(color: c.textPrimary),
        bodySmall: AppTypography.bodySmall.copyWith(color: c.textSecondary),
      ),
    );
  }
}
