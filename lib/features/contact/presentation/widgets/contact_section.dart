import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
            label: 'Get in Touch',
            title: AppStrings.contactHeading,
            subtitle: AppStrings.contactSubtitle,
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
        Expanded(flex: 5, child: _buildContactCard(context, tt)),
        const SizedBox(width: 40),
        Expanded(flex: 5, child: _buildQuickLinks(context, tt)),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context, TextTheme tt) {
    return Column(
      children: [
        _buildContactCard(context, tt),
        const SizedBox(height: 24),
        _buildQuickLinks(context, tt),
      ],
    );
  }

  Widget _buildContactCard(BuildContext context, TextTheme tt) {
    return GlowCard(
      glowColor: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Send me a message', style: tt.headlineMedium),
          const SizedBox(height: 8),
          Text(
            'I typically respond within 24 hours.',
            style: tt.bodyMedium,
          ),
          const SizedBox(height: 28),

          // Email button — main CTA
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _launchUrl(
                'mailto:${AppConstants.email}?subject=Project Inquiry',
              ),
              icon: const Icon(Icons.email_outlined),
              label: Text(AppConstants.email),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                textStyle: tt.labelLarge,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Location row
          Row(
            children: [
              const Icon(Icons.location_on_outlined,
                  size: 16, color: AppColors.textSecondary),
              const SizedBox(width: 8),
              Text(AppConstants.location, style: tt.bodyMedium),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: 300.ms, duration: 600.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildQuickLinks(BuildContext context, TextTheme tt) {
    final links = [
      (FontAwesomeIcons.github, 'GitHub', AppConstants.githubUrl,
          'Check out my open-source work', AppColors.textPrimary),
      (FontAwesomeIcons.linkedin, 'LinkedIn', AppConstants.linkedinUrl,
          'Connect with me professionally', const Color(0xFF0A66C2)),
      (FontAwesomeIcons.twitter, 'Twitter', AppConstants.twitterUrl,
          'Follow my Flutter tips & updates', const Color(0xFF1DA1F2)),
    ];

    return Column(
      children: links
          .asMap()
          .entries
          .map(
            (entry) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _SocialLinkCard(
                icon: entry.value.$1,
                platform: entry.value.$2,
                url: entry.value.$3,
                description: entry.value.$4,
                color: entry.value.$5,
              ).animate().fadeIn(
                    delay: Duration(milliseconds: 400 + entry.key * 100),
                    duration: 500.ms,
                  ),
            ),
          )
          .toList(),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _SocialLinkCard extends StatefulWidget {
  final dynamic icon;
  final String platform;
  final String url;
  final String description;
  final Color color;

  const _SocialLinkCard({
    required this.icon,
    required this.platform,
    required this.url,
    required this.description,
    required this.color,
  });

  @override
  State<_SocialLinkCard> createState() => _SocialLinkCardState();
}

class _SocialLinkCardState extends State<_SocialLinkCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: () async {
          final uri = Uri.parse(widget.url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(
            _hovered ? 6 : 0,
            0,
            0,
          ),
          child: GlowCard(
            glowColor: widget.color,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: widget.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: FaIcon(widget.icon, size: 18, color: widget.color),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.platform, style: tt.titleMedium),
                      Text(widget.description,
                          style: tt.bodyMedium?.copyWith(fontSize: 12)),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_rounded,
                  size: 16,
                  color: _hovered ? widget.color : AppColors.textMuted,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
