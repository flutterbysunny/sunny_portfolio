import 'package:flutter/cupertino.dart';

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