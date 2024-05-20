
import 'package:flutter/material.dart';

// Colors
class AppColors {
  static const Color primaryButtonBackground = Color(0xFFffe357);
  static const Color secondaryButtonBackground = Color(0xFFf5f5f5);
  static const Color accentButtonBackground = Color(0xFF774980);
  static const Color backgroundGradientStart = Color(0xFF35FFE2);
  static const Color backgroundGradientEnd = Color(0xFFdffffb);
  static const Color error = Color(0xFFB00020);
  static const Color textHighEmphasis = Color(0xFF373331);
  static const Color textMediumEmphasis = Color(0x99373331);
  static const Color textLowEmphasis = Color(0x66373331);
  static const Color cardBackground = Color(0xAAf6e9e9);
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

// Font sizes
class AppFontSizes {
  static const double title = 32.0;
  static const double headline= 24.0;
  static const double subheadline= 18.0;
  static const double body = 14.0;
  static const double hint = 12.0;
}

// Font styles
class AppTextStyles {
  static const TextStyle title = TextStyle(
    fontSize: AppFontSizes.title, 
    fontWeight: FontWeight.bold,
    color: AppColors.textHighEmphasis,
  );
  static const TextStyle headline = TextStyle(
    fontSize: AppFontSizes.headline, 
    fontWeight: FontWeight.w600,
    color: AppColors.textHighEmphasis,
  );
  static const TextStyle subheadline = TextStyle(
    fontSize: AppFontSizes.subheadline, 
    fontWeight: FontWeight.w500,
    color: AppColors.textHighEmphasis,
  );
  static const TextStyle body = TextStyle(
    fontSize: AppFontSizes.body, 
    color: AppColors.textHighEmphasis
  );
  static const TextStyle hintText = TextStyle(
    fontSize: AppFontSizes.hint, 
    color: AppColors.textMediumEmphasis
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