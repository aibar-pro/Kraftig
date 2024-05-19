import 'package:flutter/material.dart';
import 'package:animated_weight_picker/animated_weight_picker.dart';

import '../resources/constants.dart';

class WeightPickerWrapper extends StatefulWidget {
  final double initialValue;
  final double min;
  final double max;
  final ValueChanged<double> onChange;

  const WeightPickerWrapper({
    super.key,
    required this.initialValue,
    required this.min,
    required this.max,
    required this.onChange,
  });

  @override
  _WeightPickerWrapperState createState() => _WeightPickerWrapperState();
}

class _WeightPickerWrapperState extends State<WeightPickerWrapper> {
  String selectedValue = '';

  @override
  void initState() {
    selectedValue = widget.initialValue.toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedWeightPicker(
      min: widget.min,
      max: widget.max,
      dialColor: AppColors.textMediumEmphasis,
      selectedValueColor: AppColors.textHighEmphasis,
      suffixTextColor: AppColors.textMediumEmphasis,
      onChange: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onChange(double.parse(selectedValue));
      },
    );
  }
}
