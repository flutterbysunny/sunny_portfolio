import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_portfolio/core/constants/app_constants.dart';
import 'package:flutter_portfolio/core/theme/app_theme.dart';
import 'package:flutter_portfolio/core/theme/theme_provider.dart';

class PortfolioNavBar extends ConsumerStatefulWidget {
  final ScrollController scrollController;
  final List<GlobalKey> sectionKeys;

  const PortfolioNavBar({
    super.key,
    required this.scrollController,
    required this.sectionKeys,
  });

  @override
  ConsumerState<PortfolioNavBar> createState() => _PortfolioNavBarState();
}

class _PortfolioNavBarState extends ConsumerState<PortfolioNavBar> {
  int _activeIndex = 0;
  bool _isScrolled = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final scrolled = widget.scrollController.offset > 50;
    if (scrolled != _isScrolled) {
      setState(() => _isScrolled = scrolled);
    }
  }

  void _scrollToSection(int index) {
    final key = widget.sectionKeys[index];
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
    setState(() => _activeIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkBg : AppColors.lightBg)
            .withOpacity(_isScrolled ? 0.92 : 0),
        border: Border(
          bottom: BorderSide(
            color: _isScrolled
                ? (isDark ? AppColors.darkBorder : AppColors.lightBorder)
                : Colors.transparent,
            width: 1,
          ),
        ),
        boxShadow: _isScrolled
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRect(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 20 : 80,
            vertical: 16,
          ),
          child: Row(
            children: [
              // Logo
              _LogoWidget(),

              const Spacer(),

              if (!isMobile) ...[
                // Nav items
                ...AppConstants.navItems.asMap().entries.map(
                      (entry) => _NavItem(
                        label: entry.value,
                        isActive: _activeIndex == entry.key,
                        onTap: () => _scrollToSection(entry.key),
                      ),
                    ),
                const SizedBox(width: 16),
              ],

              // Theme toggle
              _ThemeToggle(),

              if (isMobile) ...[
                const SizedBox(width: 8),
                _MobileMenuButton(
                  onSectionTap: _scrollToSection,
                  activeIndex: _activeIndex,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.accent],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Center(
            child: Text('F', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 18)),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          AppConstants.name.split(' ').first,
          style: tt.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: widget.isActive
                ? AppColors.primary.withOpacity(0.12)
                : _hovered
                    ? AppColors.primary.withOpacity(0.06)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: widget.isActive
                      ? AppColors.primaryLight
                      : _hovered
                          ? AppColors.primaryLight
                          : AppColors.textSecondary,
                ),
          ),
        ),
      ),
    );
  }
}

class _ThemeToggle extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = ref.watch(themeProvider) == ThemeMode.dark;

    return IconButton(
      onPressed: () => ref.read(themeProvider.notifier).toggleTheme(),
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: Icon(
          isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
          key: ValueKey(isDark),
          color: AppColors.textSecondary,
          size: 20,
        ),
      ),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: AppColors.darkBorder),
        ),
      ),
    );
  }
}

class _MobileMenuButton extends StatelessWidget {
  final Function(int) onSectionTap;
  final int activeIndex;

  const _MobileMenuButton({
    required this.onSectionTap,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.darkSurface,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => _MobileMenu(
            onSectionTap: onSectionTap,
            activeIndex: activeIndex,
          ),
        );
      },
      icon: const Icon(Icons.menu_rounded, color: AppColors.textSecondary),
    );
  }
}

class _MobileMenu extends StatelessWidget {
  final Function(int) onSectionTap;
  final int activeIndex;

  const _MobileMenu({
    required this.onSectionTap,
    required this.activeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.darkBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 24),
          ...AppConstants.navItems.asMap().entries.map((entry) {
            return ListTile(
              title: Text(
                entry.value,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: activeIndex == entry.key
                          ? AppColors.primaryLight
                          : AppColors.textSecondary,
                    ),
              ),
              trailing: activeIndex == entry.key
                  ? const Icon(Icons.arrow_forward_ios_rounded,
                      size: 14, color: AppColors.primaryLight)
                  : null,
              onTap: () {
                Navigator.pop(context);
                onSectionTap(entry.key);
              },
            );
          }),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
