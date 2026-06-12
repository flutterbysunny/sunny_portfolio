import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 768;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double maxWidth(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    if (w >= 1400) return 1280;
    if (w >= 1200) return 1100;
    return w;
  }

  static EdgeInsets sectionPadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.symmetric(horizontal: 20, vertical: 60);
    } else if (isTablet(context)) {
      return const EdgeInsets.symmetric(horizontal: 48, vertical: 80);
    }
    return const EdgeInsets.symmetric(horizontal: 80, vertical: 100);
  }

  static double fontSize(BuildContext context,
      {double mobile = 14, double tablet = 16, double desktop = 18}) {
    if (isMobile(context)) return mobile;
    if (isTablet(context)) return tablet;
    return desktop;
  }
}
