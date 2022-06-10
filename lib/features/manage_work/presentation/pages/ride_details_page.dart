import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/ride_details_field.dart';

import '../../../../core/presentation/widgets/custom_floating_action_button.dart';
import '../../domain/entities/ride.dart';
import '../bloc/manage_work_bloc.dart';

// ignore: must_be_immutable
class RideDetailsPage extends StatefulWidget {
  late Ride ride;
  RideDetailsPage({Key? key, required this.ride}) : super(key: key);

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
  final DateFormat _dateFormatter = DateFormat('dd.MM.yyyy');
  final DateFormat _timeFormatter = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fahrt',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<ManageWorkBloc, ManageWorkState>(
            builder: (context, state) {
              late final VoidCallback? onPressed;
              if (state is Loading) {
                onPressed = null;
              } else {
                onPressed = () => _dispatchDeleteEvent(context);
              }
              return IconButton(
                onPressed: onPressed,
                tooltip: 'Löschen',
                icon: const Icon(
                  Icons.delete_forever_rounded,
                ),
              );
            },
          )
        ],
      ),
      body: buildBody(context),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _onEditButton(context),
        child: const Icon(Icons.edit),
        tooltip: 'Fahrt bearbeiten',
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return BlocListener<ManageWorkBloc, ManageWorkState>(
      listener: (context, state) {
        if (state is Deleted) {
          Navigator.of(context).pop();
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Center(
        child: BlocBuilder<ManageWorkBloc, ManageWorkState>(
          builder: (context, state) {
            return _buildForm();
          },
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        width: 500,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: RideDetailsField(
                    label: 'Anrede',
                    value: widget.ride.title == Title.herr ? 'Herr' : 'Frau',
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: RideDetailsField(
                    label: 'Name',
                    value: widget.ride.name,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RideDetailsField(
              label: 'Ort',
              value: widget.ride.destination,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RideDetailsField(
                    label: 'Start',
                    value: _dateFormatter.format(widget.ride.start),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RideDetailsField(
                    value: _timeFormatter.format(widget.ride.start),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RideDetailsField(
                    label: 'Ende',
                    value: _dateFormatter.format(widget.ride.end),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RideDetailsField(
                    value: _timeFormatter.format(widget.ride.end),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            RideDetailsField(
              label: 'Preis',
              value: '${widget.ride.price.toString().replaceAll('.', ',')} €',
            ),
          ],
        ),
      ),
    );
  }

  void _dispatchDeleteEvent(BuildContext context) {
    context
        .read<ManageWorkBloc>()
        .add(DeleteRideFromRepository(ride: widget.ride));
  }

  void _onEditButton(BuildContext context) async {
    final result = await Navigator.of(context)
        .pushNamed('/rideForm', arguments: {'ride': widget.ride});

    if (result != null) {
      setState(() {
        widget.ride = result as Ride;
      });
    }
  }
}
