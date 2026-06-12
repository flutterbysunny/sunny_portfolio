import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  // Dark background - neumorphism ke liye
  static const Color background = Color(0xFF1E1E2A);
  static const Color surface = Color(0xFF252535);
  static const Color card = Color(0xFF252535);
  static const Color cardHover = Color(0xFF2D2D42);

  // Neumorphism shadows
  static const Color neuDark = Color(0xFF15151F);   // dark shadow
  static const Color neuLight = Color(0xFF353550);  // light shadow

  // Primary - solid color (no gradient)
  static const Color primary = Color(0xFFFF3366);       // hot pink/red accent
  static const Color primaryLight = Color(0xFFFF5580);

  // Accent - kept for glow dots only
  static const Color accent = Color(0xFF00D4FF);

  // Text
  static const Color textPrimary = Color(0xFFF0F0FF);
  static const Color textSecondary = Color(0xFF9090AA);
  static const Color textMuted = Color(0xFF55556A);

  // Border
  static const Color border = Color(0xFF2E2E45);
  static const Color borderLight = Color(0xFF3A3A55);

  // Skill chip
  static const Color chipBg = Color(0xFF1E1B4B);
  static const Color chipBorder = Color(0xFF4338CA);

  // Kept for backward compat — but now solid, not gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFFF3366), Color(0xFFFF3366)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFF252535), Color(0xFF252535)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ── Neumorphism Helper ────────────────────────────────────────────────────────
class NeuBox extends StatelessWidget {
  final Widget child;
  final bool isPressed;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  final double? width;
  final double? height;
  final Color? color;

  const NeuBox({
    super.key,
    required this.child,
    this.isPressed = false,
    this.borderRadius = 16,
    this.padding,
    this.width,
    this.height,
    this.color,

  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? AppColors.card,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: isPressed
            ? [
          const BoxShadow(
            color: AppColors.neuDark,
            offset: Offset(-4, -4),
            blurRadius: 8,
          ),
          const BoxShadow(
            color: AppColors.neuLight,
            offset: Offset(4, 4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: AppColors.primary.withOpacity(0.15),
            blurRadius: 20,
            spreadRadius: -4,
          ),
        ]
            : [
          const BoxShadow(
            color: AppColors.neuDark,
            offset: Offset(-6, -6),
            blurRadius: 12,
          ),
          const BoxShadow(
            color: AppColors.neuLight,
            offset: Offset(6, 6),
            blurRadius: 12,
          ),
        ],
      ),
      child: child,
    );
  }
}

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.primary,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.accent,
        surface: AppColors.surface,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).copyWith(
        displayLarge: GoogleFonts.spaceGrotesk(
          fontSize: 64,
          fontWeight: FontWeight.w800,
          color: AppColors.textPrimary,
          letterSpacing: -2,
        ),
        displayMedium: GoogleFonts.spaceGrotesk(
          fontSize: 48,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -1.5,
        ),
        displaySmall: GoogleFonts.spaceGrotesk(
          fontSize: 36,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: -1,
        ),
        headlineMedium: GoogleFonts.spaceGrotesk(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        headlineSmall: GoogleFonts.spaceGrotesk(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        titleLarge: GoogleFonts.inter(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          color: AppColors.textSecondary,
          height: 1.7,
        ),
        bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.textSecondary,
          height: 1.6,
        ),
        labelLarge: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
