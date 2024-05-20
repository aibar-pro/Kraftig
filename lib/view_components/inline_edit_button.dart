import 'package:flutter/material.dart';

import '../resources/constants.dart';

class InlineEditButton extends StatelessWidget {
  final VoidCallback onPressed;

  const InlineEditButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.topRight,
      padding: const EdgeInsets.only(
        left: AppPadding.small,
        bottom: AppPadding.small,
      ),
      icon: const Icon(Icons.edit, size: AppFontSizes.body,),
      onPressed: onPressed,
    );
  }

}