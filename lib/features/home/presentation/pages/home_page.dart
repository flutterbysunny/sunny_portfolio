import 'package:flutter/material.dart';
import 'package:flutter_portfolio/features/about/presentation/widgets/about_section.dart';
import 'package:flutter_portfolio/features/contact/presentation/widgets/contact_section.dart';
import 'package:flutter_portfolio/features/home/presentation/widgets/hero_section.dart';
import 'package:flutter_portfolio/features/projects/presentation/widgets/projects_section.dart';
import 'package:flutter_portfolio/features/skills/presentation/widgets/skills_section.dart';
import 'package:flutter_portfolio/shared/widgets/navbar.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();

  // Keys for scroll-to-section navigation
  final _heroKey = GlobalKey();
  final _aboutKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _contactKey = GlobalKey();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background subtle grid pattern
          Positioned.fill(
            child: CustomPaint(painter: _GridPainter()),
          ),

          // Main scroll view
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Transparent spacer for navbar
              const SliverToBoxAdapter(
                child: SizedBox(height: 72),
              ),

              SliverToBoxAdapter(
                child: SizedBox(
                  key: _heroKey,
                  child: const HeroSection(),
                ),
              ),

              // Section divider
              const SliverToBoxAdapter(child: _SectionDivider()),

              SliverToBoxAdapter(
                child: SizedBox(
                  key: _aboutKey,
                  child: const AboutSection(),
                ),
              ),

              const SliverToBoxAdapter(child: _SectionDivider()),

              SliverToBoxAdapter(
                child: SizedBox(
                  key: _skillsKey,
                  child: const SkillsSection(),
                ),
              ),

              const SliverToBoxAdapter(child: _SectionDivider()),

              SliverToBoxAdapter(
                child: SizedBox(
                  key: _projectsKey,
                  child: const ProjectsSection(),
                ),
              ),

              const SliverToBoxAdapter(child: _SectionDivider()),

              SliverToBoxAdapter(
                child: SizedBox(
                  key: _contactKey,
                  child: const ContactSection(),
                ),
              ),

              // Footer
              const SliverToBoxAdapter(child: _Footer()),
            ],
          ),

          // Sticky navbar overlaid on top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              scrollController: _scrollController,
              sectionKeys: [
                _heroKey,
                _aboutKey,
                _skillsKey,
                _projectsKey,
                _contactKey,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.symmetric(horizontal: 80),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.transparent,
            AppColors.darkBorder,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 80),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '© 2025 Built with Flutter & ❤️',
            style: tt.bodyMedium?.copyWith(fontSize: 13),
          ),
          Text(
            'Made in Ahmedabad, India 🇮🇳',
            style: tt.bodyMedium?.copyWith(fontSize: 13),
          ),
        ],
      ),
    );
  }
}

// Subtle dot-grid background painter
class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.darkBorder.withOpacity(0.4)
      ..strokeWidth = 1;

    const spacing = 32.0;
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 0.8, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
