import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      constraints: BoxConstraints(minHeight: size.height * 0.92),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: isMobile ? 100 : 0,
      ),
      child: isMobile
          ? _buildMobileLayout(context, tt)
          : _buildDesktopLayout(context, tt),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, TextTheme tt) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: _buildTextContent(context, tt),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: _buildHeroVisual(context),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, TextTheme tt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildHeroVisual(context, size: 200),
        const SizedBox(height: 40),
        _buildTextContent(context, tt),
      ],
    );
  }

  Widget _buildTextContent(BuildContext context, TextTheme tt) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Status badge
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          decoration: BoxDecoration(
            color: AppColors.success.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.success.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.success,
                  shape: BoxShape.circle,
                ),
              )
                  .animate(onPlay: (c) => c.repeat())
                  .scaleXY(
                    begin: 0.8,
                    end: 1.2,
                    duration: 1.2.seconds,
                    curve: Curves.easeInOut,
                  )
                  .then()
                  .scaleXY(
                    begin: 1.2,
                    end: 0.8,
                    duration: 1.2.seconds,
                    curve: Curves.easeInOut,
                  ),
              const SizedBox(width: 8),
              Text(
                'Available for freelance work',
                style: tt.labelMedium?.copyWith(
                  color: AppColors.success,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 28),

        // Name
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi, I'm\n",
                style: tt.displayMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                  height: 1.2,
                ),
              ),
              TextSpan(
                text: AppConstants.name,
                style: tt.displayLarge,
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 700.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 16),

        // Title with gradient
        GradientText(
          AppConstants.title,
          style: tt.headlineLarge?.copyWith(fontWeight: FontWeight.w500),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 600.ms)
            .slideY(begin: 0.3, end: 0),

        const SizedBox(height: 20),

        // Tagline
        Text(
          AppConstants.tagline,
          style: tt.bodyLarge,
        )
            .animate()
            .fadeIn(delay: 700.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 40),

        // Stats row
        _buildStats(context, tt)
            .animate()
            .fadeIn(delay: 800.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 40),

        // CTA Buttons
        _buildCTAButtons(context, tt)
            .animate()
            .fadeIn(delay: 900.ms, duration: 600.ms)
            .slideY(begin: 0.2, end: 0),

        const SizedBox(height: 32),

        // Social links
        _buildSocialLinks(context)
            .animate()
            .fadeIn(delay: 1000.ms, duration: 600.ms),
      ],
    );
  }

  Widget _buildStats(BuildContext context, TextTheme tt) {
    return Row(
      children: [
        _StatItem(
          value: AppConstants.yearsOfExperience,
          label: 'Years\nExperience',
        ),
        _buildDivider(),
        _StatItem(
          value: AppConstants.appsBuilt,
          label: 'Apps\nBuilt',
        ),
        _buildDivider(),
        _StatItem(
          value: AppConstants.happyClients,
          label: 'Happy\nClients',
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Container(
      width: 1,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.darkBorder,
    );
  }

  Widget _buildCTAButtons(BuildContext context, TextTheme tt) {
    return Wrap(
      spacing: 16,
      runSpacing: 12,
      children: [
        // Primary CTA
        ElevatedButton.icon(
          onPressed: () => _launchUrl(AppConstants.resumeUrl),
          icon: const Icon(Icons.download_rounded, size: 18),
          label: const Text('Download Resume'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: tt.labelLarge,
          ),
        ),

        // Secondary CTA
        OutlinedButton.icon(
          onPressed: () => _launchUrl(AppConstants.githubUrl),
          icon: const FaIcon(FontAwesomeIcons.github, size: 16),
          label: const Text('View GitHub'),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.textPrimary,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            side: const BorderSide(color: AppColors.darkBorder, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: tt.labelLarge,
          ),
        ),
      ],
    );
  }

  Widget _buildSocialLinks(BuildContext context) {
    final socials = [
      (FontAwesomeIcons.github, AppConstants.githubUrl, 'GitHub'),
      (FontAwesomeIcons.linkedin, AppConstants.linkedinUrl, 'LinkedIn'),
      (FontAwesomeIcons.twitter, AppConstants.twitterUrl, 'Twitter'),
      (Icons.email_outlined, 'mailto:${AppConstants.email}', 'Email'),
    ];

    return Row(
      children: socials.map((s) {
        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Tooltip(
            message: s.$3,
            child: IconButton(
              onPressed: () => _launchUrl(s.$2),
              icon: s.$1 is IconData
                  ? Icon(s.$1 as IconData,
                      size: 18, color: AppColors.textSecondary)
                  : FaIcon(s.$1 as IconData,
                      size: 16, color: AppColors.textSecondary),
              style: IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                  side: const BorderSide(color: AppColors.darkBorder),
                ),
                padding: const EdgeInsets.all(10),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildHeroVisual(BuildContext context, {double? size}) {
    final s = size ?? 380.0;
    return Center(
      child: SizedBox(
        width: s,
        height: s,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Glowing rings
            _GlowingRing(size: s, opacity: 0.08),
            _GlowingRing(size: s * 0.78, opacity: 0.12),
            _GlowingRing(size: s * 0.56, opacity: 0.18),

            // Avatar / Profile placeholder
            Container(
              width: s * 0.5,
              height: s * 0.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [AppColors.primary, AppColors.accent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.4),
                    blurRadius: 40,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Center(
                child: Text('👨‍💻', style: TextStyle(fontSize: 72)),
              ),
            )
                .animate(onPlay: (c) => c.repeat(reverse: true))
                .scaleXY(
                  begin: 0.97,
                  end: 1.03,
                  duration: 3.seconds,
                  curve: Curves.easeInOut,
                ),

            // Floating tech badges
            ..._buildFloatingBadges(s),
          ],
        ),
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 800.ms).scaleXY(
          begin: 0.8,
          end: 1,
          delay: 300.ms,
          duration: 800.ms,
          curve: Curves.easeOutBack,
        );
  }

  List<Widget> _buildFloatingBadges(double s) {
    final badges = [
      (Offset(-s * 0.48, -s * 0.08), '🎯', 'Flutter'),
      (Offset(s * 0.35, -s * 0.32), '🔥', 'Firebase'),
      (Offset(s * 0.4, s * 0.2), '⚡', 'Riverpod'),
      (Offset(-s * 0.35, s * 0.3), '📱', 'Mobile'),
    ];

    return badges.asMap().entries.map((entry) {
      final i = entry.key;
      final badge = entry.value;
      return Positioned(
        left: s / 2 + badge.$1.dx,
        top: s / 2 + badge.$1.dy,
        child: _FloatingBadge(emoji: badge.$2, label: badge.$3)
            .animate(
              onPlay: (c) => c.repeat(reverse: true),
            )
            .moveY(
              begin: 0,
              end: -8,
              duration: Duration(milliseconds: 2000 + (i * 500)),
              curve: Curves.easeInOut,
            ),
      );
    }).toList();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GradientText(
          value,
          style: tt.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(label, style: tt.bodyMedium?.copyWith(height: 1.3)),
      ],
    );
  }
}

class _GlowingRing extends StatelessWidget {
  final double size;
  final double opacity;

  const _GlowingRing({required this.size, required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.primary.withOpacity(opacity),
          width: 1,
        ),
      ),
    );
  }
}

class _FloatingBadge extends StatelessWidget {
  final String emoji;
  final String label;

  const _FloatingBadge({required this.emoji, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.darkCard,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
          ),
        ],
      ),
    );
  }
}
