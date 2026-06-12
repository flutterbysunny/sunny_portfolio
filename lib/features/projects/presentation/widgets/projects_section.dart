import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/constants/app_data.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 24 : 80,
        vertical: 80,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(
            label: 'My Work',
            title: AppStrings.projectsHeading,
            subtitle: 'A selection of apps I\'ve built — tap to explore.',
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 60),

          // Featured projects — large cards
          ...AppData.projects
              .where((p) => p.isFeatured)
              .toList()
              .asMap()
              .entries
              .map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _FeaturedProjectCard(project: entry.value)
                  .animate()
                  .fadeIn(
                    delay: Duration(milliseconds: 200 + entry.key * 150),
                    duration: 600.ms,
                  )
                  .slideY(begin: 0.2, end: 0),
            );
          }),

          const SizedBox(height: 20),

          // Other projects — smaller grid
          LayoutBuilder(builder: (context, constraints) {
            final crossCount = constraints.maxWidth > 900 ? 3 : 1;
            final otherProjects =
                AppData.projects.where((p) => !p.isFeatured).toList();

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.2,
              ),
              itemCount: otherProjects.length,
              itemBuilder: (context, index) {
                return _SmallProjectCard(project: otherProjects[index])
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 600 + index * 100),
                      duration: 500.ms,
                    );
              },
            );
          }),
        ],
      ),
    );
  }
}

class _FeaturedProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _FeaturedProjectCard({required this.project});

  @override
  State<_FeaturedProjectCard> createState() => _FeaturedProjectCardState();
}

class _FeaturedProjectCardState extends State<_FeaturedProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        child: GlowCard(
          glowColor: p.accentColor,
          padding: const EdgeInsets.all(28),
          child: LayoutBuilder(builder: (context, constraints) {
            final isWide = constraints.maxWidth > 600;
            return isWide
                ? _wideLayout(context, tt, p)
                : _narrowLayout(context, tt, p);
          }),
        ),
      ),
    );
  }

  Widget _wideLayout(BuildContext context, TextTheme tt, ProjectModel p) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Emoji block
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: p.accentColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: p.accentColor.withOpacity(0.2)),
          ),
          child: Center(
            child: Text(p.emoji, style: const TextStyle(fontSize: 32)),
          ),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(p.title, style: tt.titleLarge),
                  const Spacer(),
                  _ProjectLinks(project: p),
                ],
              ),
              const SizedBox(height: 8),
              Text(p.description, style: tt.bodyMedium),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: p.techStack
                    .map((t) => TechTag(t, color: p.accentColor))
                    .toList(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _narrowLayout(BuildContext context, TextTheme tt, ProjectModel p) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(p.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 12),
            Expanded(child: Text(p.title, style: tt.titleLarge)),
            _ProjectLinks(project: p),
          ],
        ),
        const SizedBox(height: 12),
        Text(p.description, style: tt.bodyMedium),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              p.techStack.map((t) => TechTag(t, color: p.accentColor)).toList(),
        ),
      ],
    );
  }
}

class _SmallProjectCard extends StatefulWidget {
  final ProjectModel project;
  const _SmallProjectCard({required this.project});

  @override
  State<_SmallProjectCard> createState() => _SmallProjectCardState();
}

class _SmallProjectCardState extends State<_SmallProjectCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final p = widget.project;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.translationValues(0, _hovered ? -4 : 0, 0),
        child: GlowCard(
          glowColor: p.accentColor,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(p.emoji, style: const TextStyle(fontSize: 24)),
                  const Spacer(),
                  _ProjectLinks(project: p, iconSize: 16),
                ],
              ),
              const SizedBox(height: 12),
              Text(p.title, style: tt.titleMedium),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  p.description,
                  style: tt.bodyMedium?.copyWith(fontSize: 13),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 6,
                runSpacing: 6,
                children: p.techStack
                    .take(3)
                    .map((t) => TechTag(t, color: p.accentColor))
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectLinks extends StatelessWidget {
  final ProjectModel project;
  final double iconSize;

  const _ProjectLinks({required this.project, this.iconSize = 18});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (project.githubUrl != null)
          _LinkIcon(
            icon: FontAwesomeIcons.github,
            url: project.githubUrl!,
            tooltip: 'GitHub',
            size: iconSize,
          ),
        if (project.playStoreUrl != null)
          _LinkIcon(
            icon: FontAwesomeIcons.googlePlay,
            url: project.playStoreUrl!,
            tooltip: 'Play Store',
            size: iconSize,
          ),
        if (project.liveUrl != null)
          _LinkIcon(
            icon: Icons.open_in_new_rounded,
            url: project.liveUrl!,
            tooltip: 'Live Demo',
            size: iconSize,
          ),
      ],
    );
  }
}

class _LinkIcon extends StatelessWidget {
  final dynamic icon;
  final String url;
  final String tooltip;
  final double size;

  const _LinkIcon({
    required this.icon,
    required this.url,
    required this.tooltip,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: () async {
          final uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        },
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: icon is IconData
              ? Icon(icon as IconData,
                  size: size, color: AppColors.textSecondary)
              : FaIcon(icon as IconData,
                  size: size - 2, color: AppColors.textSecondary),
        ),
      ),
    );
  }
}
