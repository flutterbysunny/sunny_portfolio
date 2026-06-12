import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../utils/responsive.dart';
import '../models/portfolio_data.dart';

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
  bool _menuOpen = false;

  final List<String> _navItems = ['About', 'Skills', 'Packages', 'Experience', 'Projects', 'Contact'];

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
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
    setState(() => _menuOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
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
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLogo(),
              if (isMobile)
                _buildMobileMenuButton()
              else
                _buildDesktopNav(),
            ],
          ),
          if (isMobile && _menuOpen) _buildMobileMenu(),
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
        ..._navItems.asMap().entries.map((e) => _NavLink(
              label: e.value,
              onTap: () => _scrollToSection(e.key),
            )),
        const SizedBox(width: 16),
        _HireButton(onTap: () => _scrollToSection(4)),
      ],
    );
  }

  Widget _buildMobileMenuButton() {
    return NeuBox(
      borderRadius: 8,
      padding: const EdgeInsets.all(8),
      child: GestureDetector(
        onTap: () => setState(() => _menuOpen = !_menuOpen),
        child: Icon(
          _menuOpen ? Icons.close : Icons.menu,
          color: AppColors.textPrimary,
          size: 22,
        ),
      ),
    );
  }

  Widget _buildMobileMenu() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: NeuBox(
        borderRadius: 12,
        padding: const EdgeInsets.all(16),
        child: Column(
          children: _navItems.asMap().entries.map((e) {
            return GestureDetector(
              onTap: () => _scrollToSection(e.key),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: AppColors.border, width: 0.5)),
                ),
                child: Text(
                  e.value,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
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
