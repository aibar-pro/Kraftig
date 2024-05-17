
import 'package:flutter/material.dart';

// Colors
class AppColors {
  static const Color primaryButtonBackground = Color(0xFFffe357);
  static const Color accentButtonBackground = Color(0xFF774980);
  static const Color backgroundGradientStart = Color(0xFF35FFE2);
  static const Color backgroundGradientEnd = Color(0xFFdffffb);
  static const Color error = Color(0xFFB00020);
  static const Color textHighEmphasis = Color(0xFF373331);
  static const Color textMediumEmphasis = Color(0x99373331);
  static const Color textLowEmphasis = Color(0x66373331);
}

class AppViewBackgrounds {
  static const BoxDecoration mainViewBackground = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        AppColors.backgroundGradientStart,
        AppColors.backgroundGradientEnd,
      ],
    ),
  );
}

// Font styles
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: 32, 
    fontWeight: FontWeight.bold,
  );
  static const TextStyle headline = TextStyle(
    fontSize: 24, 
    fontWeight: FontWeight.w600,
  );
}

// Padding values
class AppPadding {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 24.0;
  static const double extraLarge = 32.0;
}

// Border radius values
class AppBorderRadius {
  static const double small = 4.0;
  static const double medium = 8.0;
  static const double large = 16.0;
}