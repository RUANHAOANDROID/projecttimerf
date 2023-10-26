import 'dart:math';

import 'package:flutter/material.dart';

class Styles {
  static const _textSizeLarge = 25.0;
  static const _textSizeDefault = 16.0;

  static final appTheme = ThemeData(
    hintColor: Colors.white,
  );

  static final List<Color> colors = List.generate(100, (index) {
    if (index < COLORS2.length) return COLORS2[index];
    //var baseColor = COLORS2;
    var baseColor = [
      Colors.cyanAccent,
      Colors.redAccent,
      Colors.yellow,
      Colors.green,
      Colors.redAccent,
      Colors.yellow,
      Colors.greenAccent
    ];
    var colorsIndex = index % baseColor.length;
    var r = (baseColor[colorsIndex].red + (Random().nextInt(256))) / 2;
    var g = (baseColor[colorsIndex].green + (Random().nextInt(256))) / 2;
    var b = (baseColor[colorsIndex].blue + (Random().nextInt(256))) / 2;
    return Color.fromRGBO(r.toInt(), g.toInt(), b.toInt(), 1);
  });

  static final LIBERTY_COLORS = [
    const Color.fromRGBO(207, 248, 246, 1),
    const Color.fromRGBO(148, 212, 212, 1),
    const Color.fromRGBO(136, 180, 187, 1),
    const Color.fromRGBO(118, 174, 175, 1),
    const Color.fromRGBO(42, 109, 130, 1)
  ];
  static final JOYFUL_COLORS = [
    const Color.fromRGBO(217, 80, 138, 1),
    const Color.fromRGBO(254, 149, 7, 1),
    const Color.fromRGBO(254, 247, 120, 1),
    const Color.fromRGBO(106, 167, 134, 1),
    const Color.fromRGBO(53, 194, 209, 1)
  ];

  static final PASTEL_COLORS = [
    const Color.fromRGBO(64, 89, 128, 1),
    const Color.fromRGBO(149, 165, 124, 1),
    const Color.fromRGBO(217, 184, 162, 1),
    const Color.fromRGBO(191, 134, 134, 1),
    const Color.fromRGBO(179, 48, 80, 1)
  ];
  static final COLORFUL_COLORS = {
    const Color.fromRGBO(193, 37, 82, 1),
    const Color.fromRGBO(255, 102, 0, 1),
    const Color.fromRGBO(245, 199, 0, 1),
    const Color.fromRGBO(106, 150, 31, 1),
    const Color.fromRGBO(179, 100, 53, 1)
  };
  static final VORDIPLOM_COLORS = {
    const Color.fromRGBO(192, 255, 140, 1),
    const Color.fromRGBO(255, 247, 140, 1),
    const Color.fromRGBO(255, 208, 140, 1),
    const Color.fromRGBO(140, 234, 255, 1),
    const Color.fromRGBO(255, 140, 157, 1)
  };
  static final MATERIAL_COLORS = {
    const Color(0x2ecc71),
    const Color(0xf1c40f),
    const Color(0xe74c3c),
    const Color(0x498db)
  };
  static final List<Color> COLORS2 = [
    ...COLORFUL_COLORS,
    ...VORDIPLOM_COLORS,
    ...JOYFUL_COLORS,
    ...PASTEL_COLORS,
  ];
}
