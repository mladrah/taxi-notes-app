import 'package:flutter/material.dart';

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
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        child: child ??
            Text(
              label,
              style: const TextStyle(color: Colors.white),
            ),
      ),
    );
  }
}
