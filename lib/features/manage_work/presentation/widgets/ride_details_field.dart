import 'package:flutter/material.dart';

class RideDetailsField extends StatelessWidget {
  final String? label;
  final String value;

  const RideDetailsField({
    Key? key,
    this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 25,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: label == null
              ? const SizedBox.shrink()
              : FittedBox(
                  child: Text(
                    label!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
        ),
        Container(
          height: 50,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.175),
            borderRadius: BorderRadius.circular(100),
          ),
          child: FittedBox(
            child: Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
