import 'package:flutter/material.dart';

class RadioButton<T> extends StatelessWidget {
  final String label;
  final T value;
  final T groupValue;
  final void Function(T?) onChanged;

  const RadioButton(
      {Key? key,
      required this.label,
      required this.value,
      required this.groupValue,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Radio<T>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
