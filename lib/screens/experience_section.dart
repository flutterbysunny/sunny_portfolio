import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
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
                eyebrow: "Experience",
                title: "Work History",
                subtitle: "My professional journey so far.",
              ),
              const SizedBox(height: 48),
              ...PortfolioData.experience.asMap().entries.map(
                    (e) => _TimelineItem(
                      item: e.value,
                      isLast: e.key == PortfolioData.experience.length - 1,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TimelineItem extends StatefulWidget {
  final ExperienceItem item;
  final bool isLast;

  const _TimelineItem({required this.item, required this.isLast});

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline line + dot
          SizedBox(
            width: 40,
            child: Column(
              children: [
                // Neumorphic dot
                NeuBox(
                  isPressed: _hovered,
                  borderRadius: 8,
                  padding: const EdgeInsets.all(4),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _hovered ? AppColors.primary : AppColors.textSecondary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                if (!widget.isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.only(top: 4),
                      color: AppColors.border,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 20),

          // Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: MouseRegion(
                onEnter: (_) => setState(() => _hovered = true),
                onExit: (_) => setState(() => _hovered = false),
                child: NeuBox(
                  isPressed: _hovered,
                  borderRadius: 16,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isMobile)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildRole(),
                            const SizedBox(height: 4),
                            _buildDuration(),
                          ],
                        )
                      else
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: _buildRole()),
                            _buildDuration(),
                          ],
                        ),

                      const SizedBox(height: 8),

                      Text(
                        widget.item.company,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        widget.item.description,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: AppColors.textSecondary,
                          height: 1.7,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: widget.item.technologies
                            .map((t) => SkillChip(label: t))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRole() {
    return Text(
      widget.item.role,
      style: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildDuration() {
    return NeuBox(
      borderRadius: 6,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Text(
        widget.item.duration,
        style: GoogleFonts.inter(
          fontSize: 12,
          color: AppColors.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
