import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  static const Color text1 = Color(0xFFFFFFFF);
  static Color text2 = Color(0xFFFFFFFF).withValues(alpha: 0.72);
  static Color text3 = Color(0xFFFFFFFF).withValues(alpha: 0.48);
  static Color text4 = Color(0xFFFFFFFF).withValues(alpha: 0.24);
  static Color text5 = Color(0xFFFFFFFF).withValues(alpha: 0.16);

  static const Color base1 = Color(0xFF101010);
  static const Color base2 = Color(0xFF151515);

  static Color surfaceWhite1 = Color(0xFFFFFFFF).withValues(alpha: 0.02);
  static Color surfaceWhite2 = Color(0xFFFFFFFF).withValues(alpha: 0.05);

  static Color surfaceBlack1 = Color(0xFF101010).withValues(alpha: 0.90);
  static Color surfaceBlack2 = Color(0xFF101010).withValues(alpha: 0.70);
  static Color surfaceBlack3 = Color(0xFF101010).withValues(alpha: 0.50);

  static const Color primaryAccent = Color(0xFF9196FF);
  static const Color secondaryAccent = Color(0xFF5961FF);
  static const Color positive = Color(0xFFFE5BDB);
  static const Color negative = Color(0xFFC22743);

  static Color border1 = Color(0xFFFFFFFF).withValues(alpha: 0.08);
  static Color border2 = Color(0xFFFFFFFF).withValues(alpha: 0.16);
  static Color border3 = Color(0xFFFFFFFF).withValues(alpha: 0.24);

  static const LinearGradient borderGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xFFFFFFFF), 
    Color(0xCCFFFFFF), 
    Color(0xFF101010), 
  ],
  stops: [
    0.0,
    0.45, 
    1.0,
  ],
);


  static RadialGradient boxGradient = RadialGradient(
      radius: 2.95,
      center: const Alignment(-1.0, -0.84), 
      stops: const [
        0.0,
        0.4987,
        1.0,
      ],
      colors: const [
        Color.fromRGBO(34, 34, 34, 0.4),
        Color.fromRGBO(153, 153, 153, 0.4),
        Color.fromRGBO(34, 34, 34, 0.4),
      ],
    );
}
