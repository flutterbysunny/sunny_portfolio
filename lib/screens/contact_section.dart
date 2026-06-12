import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../core/constants/app_constants.dart';
import '../models/portfolio_data.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

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
            children: [
              // ── Section Header ─────────────────────────────────────────
              Column(
                children: [
                  Text(
                    "CONTACT",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Lets Connect",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: isMobile ? 32 : 48,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -1,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 48),

              // ── Content ──────────────────────────────────────────────────
              if (isMobile)
                Column(
                  children: [
                    const _ProfileCard(),
                    const SizedBox(height: 24),
                    const _ContactFormCard(),
                  ],
                )
              else
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      Expanded(flex: 4, child: _ProfileCard()),
                      SizedBox(width: 24),
                      Expanded(flex: 6, child: _ContactFormCard()),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Left: Profile Card ────────────────────────────────────────────────────────
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();

  @override
  Widget build(BuildContext context) {
    return NeuBox(
      borderRadius: 24,
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: AspectRatio(
              aspectRatio: 1.60,
              child: PortfolioData.contactImage.isNotEmpty
                  ? Image.asset(
                PortfolioData.contactImage,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => _imageFallback(),
              )
                  : _imageFallback(),
            ),
          ),

          const SizedBox(height: 20),

          Text(
            PortfolioData.name,
            style: GoogleFonts.spaceGrotesk(
              fontSize: 26,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            "Expert ${PortfolioData.tagline}",
            style: GoogleFonts.inter(
              fontSize: 15,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),

          const SizedBox(height: 14),

          Text(
            PortfolioData.contactDescription,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 16),

          // Phone
          const _InfoLine(label: "Phone:", value: PortfolioData.phone),
          const SizedBox(height: 6),
          // Email
          const _InfoLine(label: "Email:", value: PortfolioData.email),

          const SizedBox(height: 24),

          Text(
            "FIND ME ON",
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppColors.textSecondary,
              letterSpacing: 2,
            ),
          ),

          const SizedBox(height: 14),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _SocialIcon(
                imagePath: 'assets/images/github.png',
                onTap: () => _launchUrl(PortfolioData.github),
              ),
              _SocialIcon(
                imagePath: 'assets/images/twitter_logo.png',
                onTap: () => _launchUrl(PortfolioData.twitter),
              ),
              _SocialIcon(
                imagePath: 'assets/images/linkedin.png',
                onTap: () => _launchUrl(AppConstants.linkedinUrl),
              ),
              _SocialIcon(
                imagePath: 'assets/images/whatsapp.png',
                onTap: () => _launchUrl(PortfolioData.whatsapp),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _imageFallback() {
    return Container(
      color: AppColors.card,
      alignment: Alignment.center,
      child: const Icon(Icons.image_outlined, size: 48, color: AppColors.textMuted),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;
  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "$label  ",
            style: GoogleFonts.inter(
              fontSize: 13.5,
              color: AppColors.textSecondary,
            ),
          ),
          TextSpan(
            text: value,
            style: GoogleFonts.inter(
              fontSize: 13.5,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final String imagePath; // path to image asset (e.g. assets/icons/github.png)
  final VoidCallback onTap;
  final Color? color; // optional tint for SVG/PNG icons that support color filter

  const _SocialIcon({
    required this.imagePath,
    required this.onTap,
    this.color,
  });

  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: NeuBox(
          isPressed: _hovered,
          borderRadius: 12,
          padding: const EdgeInsets.all(14),
          child: Image.asset(
            widget.imagePath,
            width: 20,
            height: 20,
            color: _hovered
                ? AppColors.primary
                : (widget.color ?? AppColors.textSecondary),
          ),
        ),
      ),
    );
  }
}

// ── Right: Contact Form Card ──────────────────────────────────────────────────
class _ContactFormCard extends StatefulWidget {
  const _ContactFormCard();

  @override
  State<_ContactFormCard> createState() => _ContactFormCardState();
}

class _ContactFormCardState extends State<_ContactFormCard> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _subjectController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final name = _nameController.text;
    final subject = _subjectController.text.isEmpty
        ? "Portfolio Contact"
        : _subjectController.text;
    final message = _messageController.text;
    final phone = _phoneController.text;
    final email = _emailController.text;

    final body = Uri.encodeComponent(
      "Name: $name\nPhone: $phone\nEmail: $email\n\n$message",
    );

    final uri = Uri.parse(
      'mailto:${PortfolioData.email}?subject=${Uri.encodeComponent(subject)}&body=$body',
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return NeuBox(
      borderRadius: 24,
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _FormField(label: "YOUR NAME", controller: _nameController),
                const SizedBox(height: 24),
                _FormField(label: "PHONE NUMBER", controller: _phoneController),
              ],
            )
          else
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _FormField(label: "YOUR NAME", controller: _nameController),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _FormField(label: "PHONE NUMBER", controller: _phoneController),
                ),
              ],
            ),

          const SizedBox(height: 24),

          _FormField(label: "EMAIL", controller: _emailController),

          const SizedBox(height: 24),

          _FormField(label: "SUBJECT", controller: _subjectController),

          const SizedBox(height: 24),

          _FormField(
            label: "MESSAGE",
            controller: _messageController,
            maxLines: 6,
          ),

          const SizedBox(height: 28),

          // Send button
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: _sendMessage,
              child: NeuBox(
                borderRadius: 12,
                padding: const EdgeInsets.symmetric(vertical: 18),
                child: Center(
                  child: Text(
                    "SEND MESSAGE",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                      letterSpacing: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Inset/Pressed Form Field (matches screenshot's recessed inputs) ───────────
class _FormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const _FormField({
    required this.label,
    required this.controller,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: AppColors.textSecondary,
            letterSpacing: 2,
          ),
        ),
        const SizedBox(height: 10),
        NeuBox(
          isPressed: true, // recessed/inset look like the screenshot
          color: AppColors.background,
          borderRadius: 10,
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: maxLines > 1 ? 14 : 14,
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: AppColors.textPrimary,
            ),
            cursorColor: AppColors.primary,
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              contentPadding: EdgeInsets.zero,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────
class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 40),
      child: Column(
        children: [
          const SectionDivider(),
          const SizedBox(height: 20),
          Text(
            "Built with Flutter 💙 by ${PortfolioData.name}",
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "© ${DateTime.now().year} All rights reserved",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}