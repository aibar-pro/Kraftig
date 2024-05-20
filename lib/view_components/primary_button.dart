import 'package:flutter/material.dart';
import '../resources/constants.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;

  const PrimaryButton({super.key, required this.text, this.icon, required this.onPressed});
  
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
      child: 
      Row(
        children: [
          if (icon != null) Icon(icon, size: AppFontSizes.body,),
          if (icon != null) const SizedBox(width: AppPadding.small,),
          Text(text, style: AppTextStyles.body,),
        ],
      ),
    );
  }
}

