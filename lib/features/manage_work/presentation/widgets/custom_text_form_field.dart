import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;

  const CustomTextFormField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Name',
          style: TextStyle(),
        ),
        TextFormField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16)))),
      ],
    );
  }
}
