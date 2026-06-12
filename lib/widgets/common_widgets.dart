import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';

// ── Section Title ─────────────────────────────────────────────────────────────
class SectionTitle extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String? subtitle;

  const SectionTitle({
    super.key,
    required this.eyebrow,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        NeuBox(
          borderRadius: 20,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          child: Text(
            eyebrow.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
              letterSpacing: 2,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: GoogleFonts.spaceGrotesk(
            fontSize: isMobile ? 28 : 40,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: -1,
            height: 1.1,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 12),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: isMobile ? 15 : 17,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ),
        ],
      ],
    );
  }
}

// ── Skill Chip ────────────────────────────────────────────────────────────────
class SkillChip extends StatelessWidget {
  final String label;
  const SkillChip({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      borderRadius: 8,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 13,
          color: AppColors.primaryLight,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// ── Neumorphic Button (replaces GradientButton) ───────────────────────────────
class GradientButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool outlined;
  final IconData? icon;

  const GradientButton({
    super.key,
    required this.label,
    required this.onTap,
    this.outlined = false,
    this.icon,
  });

  @override
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isOutlined = widget.outlined;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _pressed = true),
      onExit: (_) => setState(() => _pressed = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapUp: (_) => setState(() => _pressed = false),
        child: NeuBox(
          isPressed: _pressed,
          borderRadius: 10,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  size: 18,
                  color: isOutlined ? AppColors.textPrimary : AppColors.primary,
                ),
                const SizedBox(width: 8),
              ],
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isOutlined ? AppColors.textPrimary : AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Animated Section Wrapper ─────────────────────────────────────────────────
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const FadeSlideIn({super.key, required this.child, this.delay = Duration.zero});

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _opacity = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

// ── Glowing Dot ───────────────────────────────────────────────────────────────
class GlowDot extends StatelessWidget {
  final Color color;
  final double size;

  const GlowDot({super.key, this.color = AppColors.primary, this.size = 8});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(color: color.withOpacity(0.6), blurRadius: 8, spreadRadius: 2),
        ],
      ),
    );
  }
}

// ── Section Divider ───────────────────────────────────────────────────────────
class SectionDivider extends StatelessWidget {
  const SectionDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      color: AppColors.border,
    );
  }
}

// ── Find Me On + Best App Stack Section ──────────────────────────────────────
class SocialAndStackSection extends StatelessWidget {
  const SocialAndStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final socialLinks = [
      _IconItem(icon: Icons.code_rounded, label: 'GitHub', url: ''),
      _IconItem(icon: Icons.alternate_email_rounded, label: 'Twitter', url: ''),
      _IconItem(icon: Icons.work_outline_rounded, label: 'LinkedIn', url: ''),
      _IconItem(icon: Icons.chat_bubble_outline_rounded, label: 'WhatsApp', url: ''),
    ];

    final stackItems = [
      const _IconItem(icon: null, svgLabel: 'F', label: 'Flutter', color: Color(0xFF54C5F8)),
      _IconItem(icon: null, svgLabel: '☕', label: 'Java', color: const Color(0xFFE76F00)),
      _IconItem(icon: null, svgLabel: '⚛', label: 'React', color: const Color(0xFF61DAFB)),
      _IconItem(icon: null, svgLabel: 'JS', label: 'Node.js', color: const Color(0xFF8CC84B)),
    ];

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 32),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildGroup(context, 'FIND ME ON', socialLinks),
                    const SizedBox(height: 32),
                    _buildGroup(context, 'BEST APP STACK', stackItems),
                  ],
                )
              : Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildGroup(context, 'FIND ME ON', socialLinks)),
                    const SizedBox(width: 60),
                    Expanded(child: _buildGroup(context, 'BEST APP STACK', stackItems)),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildGroup(BuildContext context, String title, List<_IconItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: items.map((item) => _NeuIconButton(item: item)).toList(),
        ),
      ],
    );
  }
}

class _IconItem {
  final IconData? icon;
  final String? svgLabel;
  final String label;
  final String url;
  final Color? color;

  const _IconItem({
    this.icon,
    this.svgLabel,
    required this.label,
    this.url = '',
    this.color,
  });
}

class _NeuIconButton extends StatefulWidget {
  final _IconItem item;
  const _NeuIconButton({super.key, required this.item});

  @override
  State<_NeuIconButton> createState() => _NeuIconButtonState();
}

class _NeuIconButtonState extends State<_NeuIconButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: NeuBox(
        isPressed: _hovered,
        borderRadius: 14,
        padding: const EdgeInsets.all(18),
        child: widget.item.icon != null
            ? Icon(
                widget.item.icon!,
                size: 26,
                color: _hovered
                    ? AppColors.primary
                    : AppColors.textSecondary,
              )
            : Text(
                widget.item.svgLabel ?? '',
                style: TextStyle(
                  fontSize: widget.item.svgLabel == 'F' ? 22 : 20,
                  fontWeight: FontWeight.w800,
                  color: _hovered
                      ? (widget.item.color ?? AppColors.primary)
                      : AppColors.textSecondary,
                ),
              ),
      ),
    );
  }
}
