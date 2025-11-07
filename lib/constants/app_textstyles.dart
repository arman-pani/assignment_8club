import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  
  static TextStyle h1 = GoogleFonts.spaceGrotesk(
    fontSize: 28,
    height: 36 / 28,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.03 * 28,
  );

  static TextStyle h2 = GoogleFonts.spaceGrotesk(
    fontSize: 24,
    height: 30 / 24,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.02 * 24,
  );

  static TextStyle h3 = GoogleFonts.spaceGrotesk(
    fontSize: 20,
    height: 26 / 20,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.01 * 20,
  );

  static TextStyle b1 = GoogleFonts.spaceGrotesk(
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle b2 = GoogleFonts.spaceGrotesk(
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );

  static TextStyle s1 = GoogleFonts.spaceGrotesk(
    fontSize: 12,
    height: 16 / 12,
    fontWeight: FontWeight.w200,
    letterSpacing: 0,
  );

  static TextStyle s2 = GoogleFonts.spaceGrotesk(
    fontSize: 10,
    height: 12 / 10,
    fontWeight: FontWeight.w200,
    letterSpacing: 0,
  );
}
