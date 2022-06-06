import 'package:flutter/material.dart';

import '../../../../core/presentation/widgets/custom_floating_action_button.dart';

class AddRideButton extends StatelessWidget {
  const AddRideButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomFloatingActionButton(
      child: const Icon(Icons.add, color: Colors.white),
      onPressed: () {
        Navigator.of(context).pushNamed('/rideForm');
      },
    );
  }
}
