import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_theme.dart';
import '../models/portfolio_data.dart';
import '../utils/responsive.dart';
import '../widgets/common_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final crossCount = isMobile ? 1 : Responsive.isTablet(context) ? 2 : 3;

    return Container(
      width: double.infinity,
      color: AppColors.background,
      padding: Responsive.sectionPadding(context),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SectionTitle(
                eyebrow: "Projects",
                title: "Featured Work",
                subtitle:
                    "A selection of projects I've built — replace with your real projects!",
              ),
              const SizedBox(height: 48),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossCount,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: isMobile ? 1.4 : 1.1,
                ),
                itemCount: PortfolioData.projects.length,
                itemBuilder: (ctx, i) =>
                    _ProjectCard(project: PortfolioData.projects[i]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;
  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        transform: _hovered
            ? (Matrix4.identity()..translate(0.0, -4.0))
            : Matrix4.identity(),
        child: NeuBox(
          isPressed: _hovered,
          borderRadius: 20,
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 18),

              Row(
                children: [
                  Text(
                    widget.project.title,
                    style: GoogleFonts.spaceGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _hovered ? AppColors.primary : AppColors.textPrimary,
                    ),
                  ),
                  const Spacer(),
                  StoreLinkIcon(
                    imagePath: PortfolioData.playStoreBadge,
                    tooltip: "Play Store",
                    url: widget.project.playStoreUrl,
                  ),
                  const SizedBox(width: 10,),
                  StoreLinkIcon(
                    imagePath: PortfolioData.appStoreBadge,
                    tooltip: "App Store",
                    url: widget.project.appStoreUrl,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Expanded(
                child: Text(
                  widget.project.description,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.6,
                  ),
                  maxLines: 6,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: widget.project.tags
                    .take(4)
                    .map((t) => NeuBox(
                          borderRadius: 6,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Text(
                            t,
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              color: AppColors.primaryLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkIcon extends StatefulWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  const _LinkIcon(
      {required this.icon, required this.tooltip, required this.onTap});

  @override
  State<_LinkIcon> createState() => _LinkIconState();
}

class _LinkIconState extends State<_LinkIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: widget.onTap,
          child: NeuBox(
            isPressed: _hovered,
            borderRadius: 8,
            padding: const EdgeInsets.all(8),
            child: Icon(
              widget.icon,
              size: 16,
              color: _hovered
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

}
class StoreLinkIcon extends StatefulWidget {
  final String imagePath;
  final String tooltip;
  final String url;

  const StoreLinkIcon({
    required this.imagePath,
    required this.tooltip,
    required this.url,
  });

  @override
  State<StoreLinkIcon> createState() => _StoreLinkIconState();
}

class _StoreLinkIconState extends State<StoreLinkIcon> {
  bool _hovered = false;

  Future<void> _launch() async {
    final uri = Uri.parse(widget.url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.tooltip,
      child: MouseRegion(
        onEnter: (_) => setState(() => _hovered = true),
        onExit: (_) => setState(() => _hovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: _launch,
          child: NeuBox(
            isPressed: _hovered,
            borderRadius: 8,
            padding: const EdgeInsets.all(6),
            child: Image.asset(
              widget.imagePath,
              width: 18,
              height: 18,
              fit: BoxFit.contain,
              color: Colors.white,
              errorBuilder: (_, __, ___) => Icon(
                widget.tooltip == "Play Store" ? Icons.shop_outlined : Icons.apple,
                size: 16,
                color: _hovered ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}