import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      width: double.infinity,
      color: AppColors.surface,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                eyebrow: "About Me",
                title: "Who I Am",
                subtitle: "A little bit about me and my journey.",
              ),
              const SizedBox(height: 48),
              if (isMobile) _buildMobileLayout(context) else _buildDesktopLayout(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildAboutText()),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: _buildStatsGrid()),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildAboutText(),
        const SizedBox(height: 40),
        _buildStatsGrid(),
      ],
    );
  }

  Widget _buildAboutText() {
    final lines = PortfolioData.aboutText.split('\n\n');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...lines.map((line) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                line,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.8,
                ),
              ),
            )),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: ['🐦 Flutter', '🔥 Firebase', '⚡ Golang', '📱 iOS/Android']
              .map((t) => NeuBox(
                    borderRadius: 8,
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    child: Text(
                      t,
                      style: GoogleFonts.inter(
                          fontSize: 13, color: AppColors.textSecondary),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildStatsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: PortfolioData.stats
          .map((s) => _StatCard(item: s))
          .toList(),
    );
  }
}

class _StatCard extends StatefulWidget {
  final StatItem item;
  const _StatCard({required this.item});

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: NeuBox(
        isPressed: _hovered,
        borderRadius: 16,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _hovered ? widget.item.value : widget.item.value,
              style: GoogleFonts.spaceGrotesk(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: _hovered ? AppColors.primary : AppColors.textPrimary,
                height: 1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.item.label,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
