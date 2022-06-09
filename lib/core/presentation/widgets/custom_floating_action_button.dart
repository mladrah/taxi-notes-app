import 'package:flutter/material.dart';
import 'package:taxi_rahmati/core/presentation/widgets/custom_box_shadow.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;

  const CustomFloatingActionButton({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      child: Container(
        height: double.infinity,
        width: double.infinity,
        child: child,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(100),
          ),
          boxShadow: CustomBoxShadow.boxShadow(context),
        ),
      ),
    );
  }
}
