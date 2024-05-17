import 'package:flutter/material.dart';

import '../resources/constants.dart';

class TextLink extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const TextLink({super.key, required this.text, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return TextButton(  
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w500,
          decoration: TextDecoration.underline,
          color: AppColors.accentButtonBackground,
        ),
      ),
    );
  }
}