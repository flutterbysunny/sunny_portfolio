import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark Theme
  static const darkBg = Color(0xFF0A0A0F);
  static const darkSurface = Color(0xFF13131A);
  static const darkCard = Color(0xFF1C1C27);
  static const darkBorder = Color(0xFF2A2A3D);

  // Light Theme
  static const lightBg = Color(0xFFF5F5FA);
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightCard = Color(0xFFF0F0F8);
  static const lightBorder = Color(0xFFE0E0EE);

  // Accent — Electric violet with cyan spark
  static const primary = Color(0xFF7B5EA7);
  static const primaryLight = Color(0xFF9B7EC8);
  static const accent = Color(0xFF00D4FF);
  static const accentGlow = Color(0x3300D4FF);
  static const success = Color(0xFF00E5A0);
  static const warning = Color(0xFFFFB347);

  // Text
  static const textPrimary = Color(0xFFEEEEFF);
  static const textSecondary = Color(0xFF9999BB);
  static const textMuted = Color(0xFF55556A);
  static const textDark = Color(0xFF1A1A2E);
}

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.darkBg,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.darkSurface,
      onPrimary: Colors.white,
      onSecondary: AppColors.darkBg,
    ),
    textTheme: _buildTextTheme(isDark: true),
    cardTheme: CardThemeData(
      color: AppColors.darkCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.darkBorder, width: 1),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.darkBorder),
    extensions: const [AppColorExtension.dark],
  );

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColors.lightBg,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.lightSurface,
      onPrimary: Colors.white,
      onSecondary: AppColors.darkBg,
    ),
    textTheme: _buildTextTheme(isDark: false),
    cardTheme: CardThemeData(
      color: AppColors.lightCard,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.lightBorder, width: 1),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.lightBorder),
    extensions: const [AppColorExtension.light],
  );

  static TextTheme _buildTextTheme({required bool isDark}) {
    final baseColor = isDark ? AppColors.textPrimary : AppColors.textDark;
    final secondaryColor =
        isDark ? AppColors.textSecondary : const Color(0xFF555577);

    return TextTheme(
      displayLarge: GoogleFonts.spaceGrotesk(
        fontSize: 72,
        fontWeight: FontWeight.w700,
        letterSpacing: -2,
        color: baseColor,
        height: 1.0,
      ),
      displayMedium: GoogleFonts.spaceGrotesk(
        fontSize: 48,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        color: baseColor,
        height: 1.1,
      ),
      displaySmall: GoogleFonts.spaceGrotesk(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        letterSpacing: -1,
        color: baseColor,
        height: 1.2,
      ),
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: baseColor,
        letterSpacing: -0.5,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: baseColor,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: baseColor,
      ),
      bodyLarge: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.7,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
        height: 1.6,
      ),
      labelLarge: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
        color: baseColor,
      ),
      labelMedium: GoogleFonts.jetBrainsMono(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.5,
        color: secondaryColor,
      ),
    );
  }
}

// Custom theme extension for extra colors
class AppColorExtension extends ThemeExtension<AppColorExtension> {
  final Color accentGlow;
  final Color success;
  final Color cardBorder;
  final Color textMuted;

  const AppColorExtension({
    required this.accentGlow,
    required this.success,
    required this.cardBorder,
    required this.textMuted,
  });

  static const dark = AppColorExtension(
    accentGlow: AppColors.accentGlow,
    success: AppColors.success,
    cardBorder: AppColors.darkBorder,
    textMuted: AppColors.textMuted,
  );

  static const light = AppColorExtension(
    accentGlow: Color(0x337B5EA7),
    success: Color(0xFF00B07A),
    cardBorder: AppColors.lightBorder,
    textMuted: Color(0xFF9999AA),
  );

  @override
  AppColorExtension copyWith({
    Color? accentGlow,
    Color? success,
    Color? cardBorder,
    Color? textMuted,
  }) {
    return AppColorExtension(
      accentGlow: accentGlow ?? this.accentGlow,
      success: success ?? this.success,
      cardBorder: cardBorder ?? this.cardBorder,
      textMuted: textMuted ?? this.textMuted,
    );
  }

  @override
  AppColorExtension lerp(ThemeExtension<AppColorExtension>? other, double t) {
    if (other is! AppColorExtension) return this;
    return AppColorExtension(
      accentGlow: Color.lerp(accentGlow, other.accentGlow, t)!,
      success: Color.lerp(success, other.success, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
    );
  }
}
