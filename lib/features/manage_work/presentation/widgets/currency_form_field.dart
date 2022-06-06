import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CurrencyFormField extends StatelessWidget {
  String label;

  CurrencyFormField({Key? key, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Text(
        //   label,
        //   style: const TextStyle(fontWeight: FontWeight.bold),
        // ),
        // const SizedBox(
        //   height: 8,
        // ),
        TextFormField(
          decoration: InputDecoration(hintText: label),
          inputFormatters: [
            CurrencyTextInputFormatter(locale: 'eu', symbol: '€')
          ],
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
