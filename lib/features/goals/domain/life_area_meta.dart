import 'package:flutter/material.dart';

class LifeAreaMeta {
  final String label;
  final String emoji;
  final Color color;

  const LifeAreaMeta({required this.label, required this.emoji, required this.color});
}

const lifeAreaMeta = {
  'health': LifeAreaMeta(label: 'Health', emoji: '💪', color: Color(0xFF4CAF82)),
  'work': LifeAreaMeta(label: 'Work', emoji: '💼', color: Color(0xFF64B5F6)),
  'finance': LifeAreaMeta(label: 'Finance', emoji: '💰', color: Color(0xFFC9A84C)),
  'relationships': LifeAreaMeta(label: 'Relationships', emoji: '❤️', color: Color(0xFFE57373)),
  'personal_growth': LifeAreaMeta(label: 'Personal Growth', emoji: '🌱', color: Color(0xFF7BC4A0)),
  'learning': LifeAreaMeta(label: 'Learning', emoji: '📚', color: Color(0xFFFFB74D)),
  'recreation': LifeAreaMeta(label: 'Recreation', emoji: '🎨', color: Color(0xFFBA68C8)),
};

LifeAreaMeta metaFor(String area) =>
    lifeAreaMeta[area] ?? const LifeAreaMeta(label: 'Other', emoji: '⭐', color: Color(0xFF8A9E92));
