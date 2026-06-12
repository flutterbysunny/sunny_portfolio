import 'package:flutter/material.dart';

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// PROJECT MODEL
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class ProjectModel {
  final String title;
  final String description;
  final List<String> techStack;
  final String? githubUrl;
  final String? playStoreUrl;
  final String? appStoreUrl;
  final String? liveUrl;
  final Color accentColor;
  final String emoji;
  final bool isFeatured;

  const ProjectModel({
    required this.title,
    required this.description,
    required this.techStack,
    this.githubUrl,
    this.playStoreUrl,
    this.appStoreUrl,
    this.liveUrl,
    required this.accentColor,
    required this.emoji,
    this.isFeatured = false,
  });
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SKILL MODEL
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class SkillModel {
  final String name;
  final double proficiency; // 0.0 - 1.0
  final String category;
  final IconData icon;
  final Color color;

  const SkillModel({
    required this.name,
    required this.proficiency,
    required this.category,
    required this.icon,
    required this.color,
  });
}

// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
// SAMPLE DATA — Replace with your real projects!
// ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
class AppData {
  static const List<ProjectModel> projects = [
    ProjectModel(
      title: 'E-Commerce App',
      description:
          'Full-featured shopping app with product catalog, cart, Razorpay payment integration, order tracking, and real-time Firebase backend.',
      techStack: ['Flutter', 'Firebase', 'Riverpod', 'Razorpay'],
      githubUrl: 'https://github.com/yourusername/ecommerce-app',
      playStoreUrl: 'https://play.google.com',
      accentColor: Color(0xFF00D4FF),
      emoji: '🛒',
      isFeatured: true,
    ),
    ProjectModel(
      title: 'Chat App',
      description:
          'Real-time messaging with group chats, media sharing, read receipts, push notifications, and end-to-end encryption.',
      techStack: ['Flutter', 'Firebase', 'BLoC', 'FCM'],
      githubUrl: 'https://github.com/yourusername/chat-app',
      accentColor: Color(0xFF7B5EA7),
      emoji: '💬',
      isFeatured: true,
    ),
    ProjectModel(
      title: 'Finance Tracker',
      description:
          'Personal budget tracker with beautiful charts, expense categories, monthly reports, and CSV export functionality.',
      techStack: ['Flutter', 'SQLite', 'fl_chart', 'Provider'],
      githubUrl: 'https://github.com/yourusername/finance-tracker',
      playStoreUrl: 'https://play.google.com',
      accentColor: Color(0xFF00E5A0),
      emoji: '📊',
      isFeatured: true,
    ),
    ProjectModel(
      title: 'Delivery Tracker',
      description:
          'Food delivery app with live GPS tracking, Google Maps integration, driver/customer views, and real-time order updates.',
      techStack: ['Flutter', 'Google Maps', 'Firebase', 'Riverpod'],
      githubUrl: 'https://github.com/yourusername/delivery-app',
      accentColor: Color(0xFFFFB347),
      emoji: '🗺️',
      isFeatured: false,
    ),
    ProjectModel(
      title: 'AI Chat Assistant',
      description:
          'ChatGPT-powered Flutter app with voice input, image analysis, conversation history, and beautiful streaming responses.',
      techStack: ['Flutter', 'OpenAI API', 'Riverpod', 'Speech-to-Text'],
      githubUrl: 'https://github.com/yourusername/ai-assistant',
      accentColor: Color(0xFFFF6B9D),
      emoji: '🤖',
      isFeatured: false,
    ),
    ProjectModel(
      title: 'Portfolio App',
      description:
          'This very app! A responsive Flutter portfolio running on Android, iOS, and Web with smooth animations and dark/light mode.',
      techStack: ['Flutter Web', 'flutter_animate', 'go_router', 'Riverpod'],
      githubUrl: 'https://github.com/yourusername/portfolio',
      liveUrl: 'https://yourportfolio.web.app',
      accentColor: Color(0xFF9B7EC8),
      emoji: '✨',
      isFeatured: false,
    ),
  ];

  static const List<Map<String, dynamic>> skillCategories = [
    {
      'category': 'Flutter & Dart',
      'skills': [
        {'name': 'Flutter', 'level': 0.95},
        {'name': 'Dart', 'level': 0.92},
        {'name': 'Flutter Web', 'level': 0.85},
        {'name': 'Flutter Desktop', 'level': 0.75},
      ],
    },
    {
      'category': 'State Management',
      'skills': [
        {'name': 'Riverpod', 'level': 0.90},
        {'name': 'BLoC / Cubit', 'level': 0.88},
        {'name': 'Provider', 'level': 0.85},
        {'name': 'GetX', 'level': 0.80},
      ],
    },
    {
      'category': 'Backend & APIs',
      'skills': [
        {'name': 'Firebase', 'level': 0.90},
        {'name': 'REST APIs', 'level': 0.88},
        {'name': 'GraphQL', 'level': 0.72},
        {'name': 'Supabase', 'level': 0.78},
      ],
    },
    {
      'category': 'Tools & Practices',
      'skills': [
        {'name': 'Git & GitHub', 'level': 0.92},
        {'name': 'Clean Architecture', 'level': 0.85},
        {'name': 'Unit & Widget Tests', 'level': 0.80},
        {'name': 'CI/CD', 'level': 0.75},
      ],
    },
  ];
}
