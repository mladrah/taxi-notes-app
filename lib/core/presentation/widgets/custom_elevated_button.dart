import 'package:flutter/material.dart';
import 'package:taxi_rahmati/core/presentation/widgets/custom_box_shadow.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String label;
  final Widget? child;

  const CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.transparent,
        boxShadow: CustomBoxShadow.boxShadow(context),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        child: child ??
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
    );
  }
}
