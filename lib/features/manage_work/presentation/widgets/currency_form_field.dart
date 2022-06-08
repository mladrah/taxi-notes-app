import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CurrencyFormField extends StatelessWidget {
  final String label;
  final void Function(String) onChanged;
  final String initialValue;

  const CurrencyFormField({
    Key? key,
    required this.label,
    required this.onChanged,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          onChanged: onChanged,
          initialValue: initialValue.isEmpty ? '' : '$initialValue €',
          validator: (value) {
            return (value == null || value.isEmpty) ? '' : null;
          },
          decoration: InputDecoration(
            hintText: label,
          ),
          inputFormatters: [
            CurrencyTextInputFormatter(locale: 'eu', symbol: '€')
          ],
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
