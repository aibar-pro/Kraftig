import 'package:flutter/material.dart';
import '../resources/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  const PrimaryButton({super.key, required this.text, required this.onPressed});
  
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(  
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.textHighEmphasis, 
        backgroundColor: AppColors.primaryButtonBackground,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppBorderRadius.medium)
          ),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

