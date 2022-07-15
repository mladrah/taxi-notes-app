import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/core/util/date_time_formatter.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/ride_details_field.dart';

import '../../../../core/presentation/widgets/custom_floating_action_button.dart';
import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';
import '../bloc/manage_work_bloc.dart';
import '../widgets/delete_alert.dart';

// ignore: must_be_immutable
class RideDetailsPage extends StatefulWidget {
  late WorkUnit workUnit;
  late Ride ride;
  RideDetailsPage({Key? key, required this.workUnit, required this.ride})
      : super(key: key);

  @override
  State<RideDetailsPage> createState() => _RideDetailsPageState();
}

class _RideDetailsPageState extends State<RideDetailsPage> {
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
                onPressed = () => DeleteAlert(
                        context: context,
                        onPressed: () => _dispatchDeleteEvent(context),
                        title: 'Fahrt löschen?')
                    .alert
                    .show();
              }
              return IconButton(
                onPressed: onPressed,
                tooltip: 'Löschen',
                icon: Icon(
                  Icons.delete_forever_rounded,
                  color: Theme.of(context).errorColor,
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
        if (state is RideDeleted || state is WorkUnitDeleted) {
          Navigator.pop(context);
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Center(
        child: BlocBuilder<ManageWorkBloc, ManageWorkState>(
          builder: (context, state) {
            if (state is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
                    label: 'Datum',
                    value: DateTimeFormatter.dayMonthYear(widget.ride.start),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RideDetailsField(
                    label: 'Zeit',
                    value: DateTimeFormatter.hourMinute(widget.ride.start),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RideDetailsField(
                    label: 'Von',
                    value: widget.ride.fromDestination,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: RideDetailsField(
                    label: 'Nach',
                    value: widget.ride.toDestination,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
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
            // const SizedBox(height: 8),
            // Row(
            //   children: [
            //     Expanded(
            //       child: RideDetailsField(
            //         label: 'Ende',
            //         value: _dateFormatter.format(widget.ride.end),
            //       ),
            //     ),
            //     const SizedBox(width: 8),
            //     Expanded(
            //       child: RideDetailsField(
            //         value: _timeFormatter.format(widget.ride.end),
            //       ),
            //     ),
            //   ],
            // ),
            // const SizedBox(height: 8),
            // RideDetailsField(
            //   label: 'Preis',
            //   value: '${widget.ride.price.toString().replaceAll('.', ',')} €',
            // ),
          ],
        ),
      ),
    );
  }

  void _dispatchDeleteEvent(BuildContext context) {
    context.read<ManageWorkBloc>().add(
        DeleteRideFromRepository(workUnit: widget.workUnit, ride: widget.ride));
  }

  void _onEditButton(BuildContext context) async {
    final result = await Navigator.of(context).pushNamed('/rideForm',
        arguments: {'ride': widget.ride, 'workUnit': widget.workUnit});

    if (result != null) {
      final WorkUnit workUnit = result as WorkUnit;
      for (Ride r in workUnit.rides) {
        if (r.id.compareTo(widget.ride.id) == 0) {
          widget.ride = r;
          break;
        }
      }
      setState(() {});
    }
  }
}
