import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_portfolio/features/home/presentation/pages/home_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
  ],
);
