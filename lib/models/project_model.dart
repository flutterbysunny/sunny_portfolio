import 'dart:ui';

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
