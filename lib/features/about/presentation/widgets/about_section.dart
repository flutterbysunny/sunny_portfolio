import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            label: 'Who I Am',
            title: AppStrings.aboutHeading,
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .slideY(begin: 0.3, end: 0),

          const SizedBox(height: 60),

          isMobile
              ? _buildMobileLayout(context, tt)
              : _buildDesktopLayout(context, tt),
        ],
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, TextTheme tt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 5, child: _buildTextBlock(context, tt)),
        const SizedBox(width: 60),
        Expanded(flex: 5, child: _buildHighlightsGrid(context, tt)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, TextTheme tt) {
    return Column(
      children: [
        _buildTextBlock(context, tt),
        const SizedBox(height: 40),
        _buildHighlightsGrid(context, tt),
      ],
    );
  }

  Widget _buildTextBlock(BuildContext context, TextTheme tt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppStrings.aboutBody, style: tt.bodyLarge)
            .animate()
            .fadeIn(delay: 300.ms, duration: 600.ms),

        const SizedBox(height: 24),

        Text(
          'When I\'m not coding, I contribute to open-source Flutter packages, '
          'write technical articles, and explore the latest in mobile tech.',
          style: tt.bodyLarge,
        ).animate().fadeIn(delay: 400.ms, duration: 600.ms),

        const SizedBox(height: 32),

        // What I offer list
        ..._offers
            .asMap()
            .entries
            .map((entry) => _OfferItem(text: entry.value)
                .animate()
                .fadeIn(
                  delay: Duration(milliseconds: 500 + entry.key * 100),
                  duration: 500.ms,
                )
                .slideX(begin: -0.2, end: 0)),
      ],
    );
  }

  Widget _buildHighlightsGrid(BuildContext context, TextTheme tt) {
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      children: _highlights
          .asMap()
          .entries
          .map(
            (entry) => SizedBox(
              width: 160,
              child: _HighlightCard(
                emoji: entry.value.$1,
                title: entry.value.$2,
                value: entry.value.$3,
              )
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 400 + entry.key * 100),
                    duration: 500.ms,
                  )
                  .scaleXY(begin: 0.8, end: 1),
            ),
          )
          .toList(),
    );
  }

  static const _offers = [
    'Clean Architecture & scalable codebase',
    'Pixel-perfect UI matching Figma designs',
    'Firebase, REST API & GraphQL integration',
    'App Store & Play Store deployment',
    'Performance optimization & testing',
  ];

  static const _highlights = [
    ('📱', 'Platforms', 'iOS · Android · Web'),
    ('⚡', 'Performance', '60fps smooth UI'),
    ('🏗️', 'Architecture', 'Clean + SOLID'),
    ('🧪', 'Testing', 'Unit · Widget · E2E'),
    ('🌍', 'Languages', 'Dart · Kotlin · Swift basics'),
    ('🔄', 'CI/CD', 'GitHub Actions · Fastlane'),
  ];
}

class _OfferItem extends StatelessWidget {
  final String text;
  const _OfferItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: AppColors.accent,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class _HighlightCard extends StatelessWidget {
  final String emoji;
  final String title;
  final String value;

  const _HighlightCard({
    required this.emoji,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GlowCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 10),
          Text(title,
              style: tt.labelMedium?.copyWith(color: AppColors.textMuted)),
          const SizedBox(height: 4),
          Text(value,
              style: tt.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              )),
        ],
      ),
    );
  }
}
