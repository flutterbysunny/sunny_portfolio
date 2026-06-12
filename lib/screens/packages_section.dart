import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

// ── Package Data ──────────────────────────────────────────────────────────────
class PackageItem {
  final String name;
  final String description;
  final String version;
  final String pubUrl;
  final String emoji;
  final Color accentColor;

  const PackageItem({
    required this.name,
    required this.description,
    required this.version,
    required this.pubUrl,
    required this.emoji,
    required this.accentColor,
  });
}

const packages = [
  PackageItem(
    name: 'sm_cli',
    description:
        'Flutter Clean Architecture CLI generator for scalable production apps — Riverpod, BLoC, GetX, Provider, routing, themes & feature-based structure.',
    version: '1.0.8',
    pubUrl: 'https://pub.dev/packages/sm_cli',
    emoji: '⚡',
    accentColor: Color(0xFF00D4FF),
  ),
  PackageItem(
    name: 'advanced_shimmer',
    description:
        'A highly customizable shimmer loading effect package for Flutter with support for multiple directions, colors, and animation curves.',
    version: '1.0.2',
    pubUrl: 'https://pub.dev/packages/advanced_shimmer',
    emoji: '✨',
    accentColor: Color(0xFFFFB347),
  ),
  PackageItem(
    name: 'bharatvalidator',
    description:
        'Comprehensive Indian data validator — Aadhaar, PAN, GST, IFSC, pincode, mobile, UPI and more. Built for Bharat 🇮🇳.',
    version: '1.0.2',
    pubUrl: 'https://pub.dev/packages/bharatvalidator',
    emoji: '🇮🇳',
    accentColor: Color(0xFFFF9933),
  ),
  PackageItem(
    name: 'flutter_ui_guard',
    description:
        'Route-level UI guard package for Flutter — protect screens with auth checks, role-based access, and redirect rules with zero boilerplate.',
    version: '0.0.3',
    pubUrl: 'https://pub.dev/packages/flutter_ui_guard',
    emoji: '🛡️',
    accentColor: Color(0xFF00E5A0),
  ),
  PackageItem(
    name: 'neo_glass',
    description:
        'Revolutionary glassmorphism package with 6 unique effects — Liquid Morphism, Holographic, Plasma, Crystal, Aurora, and Quantum blur.',
    version: '1.0.1+3',
    pubUrl: 'https://pub.dev/packages/neo_glass',
    emoji: '🔮',
    accentColor: Color(0xFF7B5EA7),
  ),
  PackageItem(
    name: 'nova_ui',
    description:
        'A modern Flutter UI kit with pre-built stunning components — buttons, cards, dialogs, inputs and animations ready for production apps.',
    version: '1.0.5',
    pubUrl: 'https://pub.dev/packages/nova_ui',
    emoji: '🎨',
    accentColor: Color(0xFFFF3366),
  ),
  PackageItem(
    name: 'smart_bottom_sheet',
    description:
        'Feature-rich bottom sheet with snap points, drag gestures, backdrop blur, custom headers and smooth spring animations.',
    version: '1.0.1',
    pubUrl: 'https://pub.dev/packages/smart_bottom_sheet',
    emoji: '📋',
    accentColor: Color(0xFF54C5F8),
  ),
  PackageItem(
    name: 'smart_otp_field_plus',
    description:
        'Beautiful OTP input field with SMS autofill, animations, custom styling, paste support and built-in validation for Flutter apps.',
    version: '1.0.1',
    pubUrl: 'https://pub.dev/packages/smart_otp_field_plus',
    emoji: '🔐',
    accentColor: Color(0xFFFF6B9D),
  ),
  PackageItem(
    name: 'smart_player_kit',
    description:
        'Full-featured audio & video player kit for Flutter — playlists, background play, lock-screen controls, waveform visualizer and more.',
    version: '1.0.2',
    pubUrl: 'https://pub.dev/packages/smart_player_kit',
    emoji: '🎵',
    accentColor: Color(0xFF8CC84B),
  ),
];

// ── Section Widget ────────────────────────────────────────────────────────────
class PackagesSection extends StatelessWidget {
  const PackagesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isTablet = Responsive.isTablet(context);
    final crossCount = isMobile ? 1 : isTablet ? 2 : 3;

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
                eyebrow: 'Open Source',
                title: 'My pub.dev Packages',
                subtitle:
                    'Flutter packages I\'ve published — open source, production-ready.',
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.6 : 1.2,
                ),
                itemCount: packages.length,
                itemBuilder: (_, i) => _PackageCard(pkg: packages[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Package Card ──────────────────────────────────────────────────────────────
class _PackageCard extends StatefulWidget {
  final PackageItem pkg;
  const _PackageCard({super.key, required this.pkg});

  @override
  State<_PackageCard> createState() => _PackageCardState();
}

class _PackageCardState extends State<_PackageCard> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.pkg.pubUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final pkg = widget.pkg;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _launch,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: _hovered
              ? (Matrix4.identity()..translate(0.0, -4.0))
              : Matrix4.identity(),
          child: NeuBox(
            isPressed: _hovered,
            borderRadius: 20,
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top row: emoji icon + pub.dev badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NeuBox(
                      borderRadius: 14,
                      padding: const EdgeInsets.all(10),
                      child: Text(pkg.emoji,
                          style: const TextStyle(fontSize: 22)),
                    ),
                    NeuBox(
                      isPressed: _hovered,
                      borderRadius: 20,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.open_in_new_rounded,
                              size: 11,
                              color: _hovered
                                  ? pkg.accentColor
                                  : AppColors.textMuted),
                          const SizedBox(width: 4),
                          Text(
                            'pub.dev',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: _hovered
                                  ? pkg.accentColor
                                  : AppColors.textMuted,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Package name
                Text(
                  pkg.name,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color:
                        _hovered ? pkg.accentColor : AppColors.textPrimary,
                    letterSpacing: -0.3,
                  ),
                ),

                const SizedBox(height: 8),

                // Description
                Expanded(
                  child: Text(
                    pkg.description,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      height: 1.6,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 14),

                // Bottom row: version chip
                Row(
                  children: [
                    NeuBox(
                      borderRadius: 6,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Text(
                        'v${pkg.version}',
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 10,
                          color: pkg.accentColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: _hovered
                          ? pkg.accentColor
                          : AppColors.textMuted,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
