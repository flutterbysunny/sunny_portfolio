import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

class HeroSection extends StatelessWidget {
  final VoidCallback onContactTap;
  final VoidCallback onProjectsTap;

  const HeroSection({
    super.key,
    required this.onContactTap,
    required this.onProjectsTap,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final size = MediaQuery.of(context).size;
    final double minH = isMobile ? size.height * 0.9 : size.height;

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: minH, minWidth: double.infinity),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          padding: Responsive.sectionPadding(context),
          child: isMobile ? _buildMobileLayout(context) : _buildDesktopLayout(context),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 6,
          child: FadeSlideIn(child: _buildTextContent(isDesktop: true)),
        ),
        const SizedBox(width: 60),
        Expanded(
          flex: 4,
          child: FadeSlideIn(
            delay: const Duration(milliseconds: 200),
            child: _buildAvatarCard(),
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FadeSlideIn(child: _buildAvatarCard(mobile: true)),
        const SizedBox(height: 32),
        FadeSlideIn(
          delay: const Duration(milliseconds: 150),
          child: _buildTextContent(isDesktop: false),
        ),
      ],
    );
  }

  Widget _buildTextContent({required bool isDesktop}) {
    final isMobile = !isDesktop;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Status badge
        NeuBox(
          borderRadius: 20,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GlowDot(color: const Color(0xFF10B981), size: 7),
              const SizedBox(width: 8),
              Text(
                "Available for work",
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF34D399),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "Hi, I'm\n",
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 20 : 22,
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: PortfolioData.name,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: isMobile ? 40 : 64,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  letterSpacing: -2,
                  height: 1.05,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            Text(
              "I'm a  ",
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 20 : 26,
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            DefaultTextStyle(
              style: GoogleFonts.spaceGrotesk(
                fontSize: isMobile ? 20 : 26,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
              child: AnimatedTextKit(
                animatedTexts: PortfolioData.roles
                    .map((r) => TyperAnimatedText(r,
                    speed: const Duration(milliseconds: 60)))
                    .toList(),
                repeatForever: true,
                pause: const Duration(milliseconds: 1500),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Text(
          PortfolioData.heroDescription,
          style: GoogleFonts.inter(
            fontSize: isMobile ? 15 : 17,
            color: AppColors.textSecondary,
            height: 1.7,
          ),
        ),

        const SizedBox(height: 36),

        Wrap(
          spacing: 14,
          runSpacing: 12,
          children: [
            GradientButton(
              label: "View Projects",
              onTap: onProjectsTap,
              icon: Icons.rocket_launch_outlined,
            ),
            GradientButton(
              label: "Contact Me",
              onTap: onContactTap,
              outlined: true,
              icon: Icons.mail_outline,
            ),
            GradientButton(
              label: "Download CV",
              onTap: _downloadCV,
              outlined: true,
              icon: Icons.download_outlined,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _downloadCV() async {
    final uri = Uri.parse(PortfolioData.resumeUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Widget _buildAvatarCard({bool mobile = false}) {
    final double size = mobile ? 160.0 : 240.0;

    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Avatar neumorphic circle with profile image
          NeuBox(
            borderRadius: size / 2,
            padding: EdgeInsets.zero,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(size / 2),
              child: PortfolioData.profileImage.isNotEmpty
                  ? Image.asset(
                PortfolioData.profileImage,
                width: size,
                height: size,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _buildFallbackAvatar(size),
              )
                  : _buildFallbackAvatar(size),
            ),
          ),
          // Floating tech badge
          Positioned(
            bottom: mobile ? 10 : 20,
            right: mobile ? 10 : 10,
            child: NeuBox(
              isPressed: false,
              borderRadius: 20,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("assets/images/flutter_logo.png",height: 15,),
                  const SizedBox(width: 6),
                  Text(
                    "Flutter",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar(double size) {
    return Container(
      width: size,
      height: size,
      color: AppColors.card,
      alignment: Alignment.center,
      child: Text(
        PortfolioData.name.isNotEmpty ? PortfolioData.name[0] : "Y",
        style: GoogleFonts.spaceGrotesk(
          fontSize: size * 0.4,
          fontWeight: FontWeight.w800,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

// ── Scroll Indicator ──────────────────────────────────────────────────────────
class _ScrollIndicator extends StatefulWidget {
  @override
  State<_ScrollIndicator> createState() => _ScrollIndicatorState();
}

class _ScrollIndicatorState extends State<_ScrollIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => Opacity(
        opacity: 0.4 + _animation.value * 0.4,
        child: Column(
          children: [
            Text(
              "SCROLL",
              style: GoogleFonts.inter(
                fontSize: 10,
                letterSpacing: 3,
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 8),
            const Icon(Icons.keyboard_arrow_down,
                color: AppColors.textMuted, size: 20),
          ],
        ),
      ),
    );
  }
}