import 'package:flutter/material.dart' hide Title;
import 'package:intl/intl.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/custom_elevated_button.dart';

import '../../domain/entities/ride.dart';

class RideDetailsPage extends StatelessWidget {
  final Ride ride;
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('hh:mm');

  RideDetailsPage({Key? key, required this.ride}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrt'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete_forever_rounded,
              color: Theme.of(context).errorColor,
            ),
          )
        ],
      ),
      body: buildBody(context),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RideField(value: ride.title == Title.herr ? 'Herr' : 'Frau'),
            const SizedBox(
              height: 16,
            ),
            _RideField(label: 'Name', value: ride.name),
            const SizedBox(
              height: 16,
            ),
            _RideField(label: 'Ort', value: ride.destination),
            const SizedBox(
              height: 16,
            ),
            _RideField(
                label: 'Start',
                value:
                    '${_dateFormatter.format(ride.start)}\n${_timeFormatter.format(ride.start)}'),
            const SizedBox(
              height: 16,
            ),
            _RideField(
                label: 'Ende',
                value:
                    '${_dateFormatter.format(ride.end)}\n${_timeFormatter.format(ride.end)}'),
            const SizedBox(
              height: 16,
            ),
            _RideField(label: 'Preis', value: '${ride.price.toString()}€'),
            const SizedBox(
              height: 16,
            ),
            CustomElevatedButton(label: 'Ändern', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}

class _RideField extends StatelessWidget {
  final String? label;
  final String value;

  const _RideField({Key? key, this.label, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        label != null
            ? Text(
                label!,
                style: const TextStyle(
                  fontSize: 20,
                ),
              )
            : const SizedBox.shrink(),
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ],
    );
  }
}
