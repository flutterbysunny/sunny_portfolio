import 'package:flutter/material.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';

class GradientText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<Color>? colors;

  const GradientText(
    this.text, {
    super.key,
    this.style,
    this.colors,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = LinearGradient(
      colors: colors ??
          const [
            AppColors.primaryLight,
            AppColors.accent,
          ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );

    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

// ── Glowing container card
class GlowCard extends StatelessWidget {
  final Widget child;
  final Color? glowColor;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;

  const GlowCard({
    super.key,
    required this.child,
    this.glowColor,
    this.padding,
    this.borderRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = glowColor ?? AppColors.primary;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
        color: isDark ? AppColors.darkCard : AppColors.lightCard,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(24),
          child: child,
        ),
      ),
    );
  }
}

// ── Section heading widget
class SectionHeading extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;

  const SectionHeading({
    super.key,
    required this.label,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.primary.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: tt.labelMedium?.copyWith(
              color: AppColors.primaryLight,
              letterSpacing: 2,
              fontSize: 11,
            ),
          ),
        ),
        const SizedBox(height: 16),
        GradientText(
          title,
          style: tt.displaySmall,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: tt.bodyLarge,
          ),
        ],
      ],
    );
  }
}

// ── Pill tag widget
class TechTag extends StatelessWidget {
  final String label;
  final Color? color;

  const TechTag(this.label, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? AppColors.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: c.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withOpacity(0.25), width: 1),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: c,
              fontSize: 11,
            ),
      ),
    );
  }
}
