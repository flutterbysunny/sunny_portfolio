import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../models/portfolio_data.dart';

// Shared nav config — order must match _sectionKeys in portfolio_page.dart
// 0: About, 1: Skills, 2: Packages, 3: Experience, 4: Projects, 5: Contact
class NavConfig {
  static const List<String> labels = [
    'About', 'Skills', 'Packages', 'Experience', 'Projects', 'Contact'
  ];

  static const List<String> icons = [
    "assets/images/about.png",
    "assets/images/skill.png",
    "assets/images/packages.png",
    "assets/images/experience.png",
    "assets/images/projects.png",
    "assets/images/contact.png",
  ];
}

// ── Top Navbar (Web / Desktop / Tablet) ────────────────────────────────────────
class PortfolioNavBar extends StatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  State<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends State<PortfolioNavBar> {
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    if (!mounted) return;
    setState(() => _scrolled = widget.scrollController.offset > 60);
  }

  void _scrollToSection(int index) {
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(ctx,
          duration: const Duration(milliseconds: 700),
          curve: Curves.easeInOutCubic);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: 40,
        vertical: _scrolled ? 14 : 20,
      ),
      decoration: BoxDecoration(
        color: _scrolled
            ? AppColors.background.withOpacity(0.95)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: _scrolled ? AppColors.border : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLogo(),
          _buildDesktopNav(),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        NeuBox(
          width: 40,
          borderRadius: 50,
          padding: const EdgeInsets.all(5),
          child: Center(
            child: Text(
              PortfolioData.name.isNotEmpty ? PortfolioData.name[0] : "Y",
              style: GoogleFonts.spaceGrotesk(
                color: AppColors.primary,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          PortfolioData.name.split(" ").first,
          style: GoogleFonts.spaceGrotesk(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
            fontSize: 18,
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopNav() {
    return Row(
      children: [
        ...NavConfig.labels.asMap().entries.map((e) => _NavLink(
          label: e.value,
          onTap: () => _scrollToSection(e.key),
        )),
        const SizedBox(width: 16),
        _HireButton(onTap: () => _scrollToSection(5)),
      ],
    );
  }
}

class _NavLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _NavLink({required this.label, required this.onTap});

  @override
  State<_NavLink> createState() => _NavLinkState();
}

class _NavLinkState extends State<_NavLink> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: _hovered ? AppColors.primary : AppColors.textSecondary,
            ),
            child: Text(widget.label),
          ),
        ),
      ),
    );
  }
}

class _HireButton extends StatefulWidget {
  final VoidCallback onTap;
  const _HireButton({required this.onTap});

  @override
  State<_HireButton> createState() => _HireButtonState();
}

class _HireButtonState extends State<_HireButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _pressed = true),
      onExit: (_) => setState(() => _pressed = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: NeuBox(
          isPressed: _pressed,
          borderRadius: 8,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
          child: Text(
            "Hire Me",
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}

// ── Bottom Navigation Bar (Mobile) ─────────────────────────────────────────────
class PortfolioBottomNavBar extends StatefulWidget {
  final List<GlobalKey> sectionKeys;
  final ScrollController scrollController;

  const PortfolioBottomNavBar({
    super.key,
    required this.sectionKeys,
    required this.scrollController,
  });

  @override
  State<PortfolioBottomNavBar> createState() => _PortfolioBottomNavBarState();
}

class _PortfolioBottomNavBarState extends State<PortfolioBottomNavBar> {
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  // Highlight the nav item for the section currently in view
  void _onScroll() {
    if (!mounted) return;

    int newIndex = _activeIndex;

    for (int i = 0; i < widget.sectionKeys.length; i++) {
      final ctx = widget.sectionKeys[i].currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null) continue;

      final position = box.localToGlobal(Offset.zero).dy;
      // Section considered "active" once its top crosses ~35% of screen height
      if (position <= MediaQuery.of(context).size.height * 0.35) {
        newIndex = i;
      }
    }

    if (newIndex != _activeIndex) {
      setState(() => _activeIndex = newIndex);
    }
  }

  void _onTap(int index) {
    setState(() => _activeIndex = index);
    final ctx = widget.sectionKeys[index].currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
        alignment: 0.05,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: NeuBox(
          borderRadius: 24,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(NavConfig.labels.length, (i) {
              final isActive = i == _activeIndex;
              return Expanded(
                child: _BottomNavItem(
                  imagePath: NavConfig.icons[i],
                  label: NavConfig.labels[i],
                  isActive: isActive,
                  onTap: () => _onTap(i),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  final String imagePath;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.imagePath,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        margin: const EdgeInsets.symmetric(horizontal: 3),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? AppColors.primary.withOpacity(0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imagePath,
              width: 20,
              height: 20,
              color: isActive
                  ? AppColors.primary
                  : AppColors.textSecondary,
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              child: Text(label),
            ),
          ],
        ),
      ),
    );
  }
}