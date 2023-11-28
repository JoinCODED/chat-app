import 'package:flutter/material.dart';

// use [BuildContextX] extension on build context to reduce code callback
// ex: context.screenHeight instead of MediaQuery.of(context).size.height
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Size get screenSize => MediaQuery.of(this).size;

  double get screenWidth => MediaQuery.of(this).size.width;

  double get screenHeight => MediaQuery.of(this).size.height;

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);

}
