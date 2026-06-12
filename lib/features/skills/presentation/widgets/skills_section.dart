import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/constants/app_data.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/shared/widgets/shared_widgets.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

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
            label: 'What I Know',
            title: AppStrings.skillsHeading,
            subtitle:
                'Technologies and tools I use to build production-ready apps.',
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.3, end: 0),

          const SizedBox(height: 60),

          // Skill category grid
          LayoutBuilder(
            builder: (context, constraints) {
              final crossCount = constraints.maxWidth > 900 ? 2 : 1;
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossCount,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  childAspectRatio: crossCount == 2 ? 1.6 : 2.0,
                ),
                itemCount: AppData.skillCategories.length,
                itemBuilder: (context, index) {
                  final category = AppData.skillCategories[index];
                  return _SkillCategoryCard(
                    category: category['category'] as String,
                    skills:
                        category['skills'] as List<Map<String, dynamic>>,
                  ).animate().fadeIn(
                        delay: Duration(milliseconds: 200 + index * 100),
                        duration: 600.ms,
                      );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SkillCategoryCard extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> skills;

  const _SkillCategoryCard({
    required this.category,
    required this.skills,
  });

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;

    return GlowCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(category, style: tt.titleLarge),
          const SizedBox(height: 20),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: skills.map((skill) {
                return _SkillBar(
                  name: skill['name'] as String,
                  level: skill['level'] as double,
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkillBar extends StatefulWidget {
  final String name;
  final double level;

  const _SkillBar({required this.name, required this.level});

  @override
  State<_SkillBar> createState() => _SkillBarState();
}

class _SkillBarState extends State<_SkillBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animation = Tween<double>(begin: 0, end: widget.level).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final percent = (widget.level * 100).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name, style: tt.bodyMedium),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, _) => Text(
                '${(_animation.value * 100).toInt()}%',
                style: tt.labelMedium?.copyWith(
                  color: AppColors.primaryLight,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, _) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: _animation.value,
                minHeight: 5,
                backgroundColor: AppColors.darkBorder,
                valueColor: AlwaysStoppedAnimation(
                  Color.lerp(
                    AppColors.primary,
                    AppColors.accent,
                    _animation.value,
                  )!,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
