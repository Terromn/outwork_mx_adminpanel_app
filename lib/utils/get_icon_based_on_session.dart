import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../assets/app_color_palette.dart';

class GetIconBasedOnSession {
  static FaIcon getIcon(String classType, double iconSize, Color? color) {
    if (classType == "Calistenia") {
      return FaIcon(
        FontAwesomeIcons.bolt,
        color: TeAppColorPalette.black,
        size: iconSize,
      );
    } else if (classType == "HIIT") {
      return FaIcon(FontAwesomeIcons.stopwatch,
          color: color, size: iconSize);
    } else if (classType == "Kettle Flow") {
      return FaIcon(FontAwesomeIcons.wind,
          color: color, size: iconSize);
    } else if (classType == "Yoga") {
      return FaIcon(FontAwesomeIcons.streetView,
          color: color, size: iconSize);
    } else {
      return FaIcon(FontAwesomeIcons.question,
          color: color, size: iconSize);
    }
  }
}
