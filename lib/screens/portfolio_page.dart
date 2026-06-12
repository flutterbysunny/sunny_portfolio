import 'package:flutter/material.dart';
import 'package:flutter_portfolio/screens/packages_section.dart';
import '../widgets/navbar.dart';
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

  // Keys for each section (same order as nav items: About, Skills, Experience, Projects, Contact)
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
    return Scaffold(
      body: Stack(
        children: [
          // Scrollable content
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                // Navbar spacer
                const SizedBox(height: 80),

                // Hero
                HeroSection(
                  onContactTap: () => _scrollToSection(4),
                  onProjectsTap: () => _scrollToSection(3),
                ),

                // About
                Container(key: _sectionKeys[0], child: const AboutSection()),

                // Skills
                Container(key: _sectionKeys[1], child: const SkillsSection()),

                Container(key: _sectionKeys[2], child: const PackagesSection()),


                // Experience
                Container(key: _sectionKeys[3], child: const ExperienceSection()),

                // Projects
                Container(key: _sectionKeys[4], child: const ProjectsSection()),

                // Contact
                Container(key: _sectionKeys[5], child: const ContactSection()),



                // Footer
                const FooterWidget(),
              ],
            ),
          ),

          // Fixed Navbar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: PortfolioNavBar(
              scrollController: _scrollController,
              sectionKeys: _sectionKeys,
            ),
          ),
        ],
      ),
    );
  }
}
