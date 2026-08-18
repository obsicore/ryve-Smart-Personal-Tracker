import 'package:flutter/material.dart';

class AppAnimations {
  static const instant    = Duration(milliseconds: 80);
  static const fast       = Duration(milliseconds: 150);
  static const base       = Duration(milliseconds: 250);
  static const moderate   = Duration(milliseconds: 350);
  static const slow       = Duration(milliseconds: 500);
  static const deliberate = Duration(milliseconds: 700);
  static const cinematic  = Duration(milliseconds: 1000);

  static const enter  = Curves.easeOut;
  static const exit   = Curves.easeIn;
  static const spring = Curves.elasticOut;
  static const smooth = Curves.easeInOut;
  static const sharp  = Curves.fastOutSlowIn;
  static const bounce = Curves.bounceOut;

  static const staggerItem  = Duration(milliseconds: 30);
  static const staggerGroup = Duration(milliseconds: 60);
}
