import 'package:flutter/animation.dart';

abstract final class AppMotion {
  static const Duration pageTransition = Duration(milliseconds: 300);
  static const Curve standardCurve = Curves.easeInOut;
}
