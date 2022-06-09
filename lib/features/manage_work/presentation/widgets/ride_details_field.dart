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
    return Container(
        // color: Colors.grey.withOpacity(0.15),
        // padding: const EdgeInsets.all(16),
        // child: Column(
        //   crossAxisAlignment: CrossAxisAlignment.start,
        //   children: [
        //     Text(
        //       label!,
        //       textAlign: TextAlign.left,
        //     ),
        //     Text(
        //       value,
        //       textAlign: TextAlign.left,
        //       style: TextStyle(
        //         fontWeight: FontWeight.bold,
        //       ),
        //     ),
        //   ],
        // ),
        );
  }
}
