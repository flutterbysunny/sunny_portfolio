import 'package:flutter/material.dart';
import 'package:flutter_portfolio/screens/packages_section.dart';
import '../widgets/navbar.dart';
import '../utils/responsive.dart';
import 'hero_section.dart';
import 'about_section.dart';
import 'skills_section.dart';
import 'experience_section.dart';
import 'projects_section.dart';
import 'contact_section.dart';

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();

  // Keys order: About(0), Skills(1), Packages(2), Experience(3), Projects(4), Contact(5)
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(int index) {
    final key = _sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 700),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Navbar spacer
                SizedBox(height: isMobile ? 20 : 80),

                // Hero
                HeroSection(
                  onContactTap: () => _scrollToSection(5),
                  onProjectsTap: () => _scrollToSection(4),
                ),

                // About
                Container(key: _sectionKeys[0], child: const AboutSection()),

                // Skills
                Container(key: _sectionKeys[1], child: const SkillsSection()),

                // Packages
                Container(key: _sectionKeys[2], child: const PackagesSection()),

                // Experience
                Container(key: _sectionKeys[3], child: const ExperienceSection()),

                // Projects
                Container(key: _sectionKeys[4], child: const ProjectsSection()),

                // Contact
                Container(key: _sectionKeys[5], child: const ContactSection()),

                // Footer
                const FooterWidget(),

                // Extra space so content isn't hidden behind bottom nav
                if (isMobile) const SizedBox(height: 90),
              ],
            ),
          ),

          // Top Navbar — web / desktop / tablet only
          if (!isMobile)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: PortfolioNavBar(
                scrollController: _scrollController,
                sectionKeys: _sectionKeys,
              ),
            ),

          // Bottom App Bar — mobile only
          if (isMobile)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: PortfolioBottomNavBar(
                sectionKeys: _sectionKeys,
                scrollController: _scrollController,
              ),
            ),
        ],
      ),
    );
  }
}