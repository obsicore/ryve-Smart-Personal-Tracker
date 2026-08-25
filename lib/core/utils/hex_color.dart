import 'package:flutter/material.dart';

Color colorFromHex(String hex) => Color(int.parse(hex.replaceFirst('#', 'FF'), radix: 16));
