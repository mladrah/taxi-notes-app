import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final double? width;

  const CustomTextFormField({Key? key, required this.label, this.width})
      : super(key: key);

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
        SizedBox(
          width: width ?? double.infinity,
          child: TextFormField(
            decoration: InputDecoration(hintText: label),
          ),
        ),
      ],
    );
  }
}
