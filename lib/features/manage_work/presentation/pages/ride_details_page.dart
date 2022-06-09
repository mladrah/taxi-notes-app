import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:taxi_rahmati/core/presentation/widgets/custom_elevated_button.dart';

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
          IconButton(
            onPressed: () {
              _dispatchDeleteEvent(context);
            },
            icon: BlocBuilder<ManageWorkBloc, ManageWorkState>(
              builder: (context, state) {
                if (state is Loading) {
                  return const CircularProgressIndicator();
                } else {
                  return const Icon(
                    Icons.delete_forever_rounded,
                  );
                }
              },
            ),
          )
        ],
      ),
      body: buildBody(context),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _onEditButton(context),
        child: const Icon(Icons.edit),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: _RideField(
                    label: 'Anrede',
                    value: widget.ride.title == Title.herr ? 'Herr' : 'Frau',
                    borderRight: true,
                  ),
                ),
                Expanded(
                    flex: 4,
                    child: _RideField(
                      label: 'Name',
                      value: widget.ride.name,
                    )),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
            _RideField(
              label: 'Ort',
              value: widget.ride.destination,
              borderTop: false,
              borderLeft: false,
              borderRight: false,
            ),
            Row(
              children: [
                Expanded(
                  child: _RideField(
                    label: 'Datum (Start)',
                    value: _dateFormatter.format(widget.ride.start),
                    borderTop: false,
                    borderRight: true,
                  ),
                ),
                Expanded(
                  child: _RideField(
                    label: 'Zeit (Start)',
                    value: _timeFormatter.format(widget.ride.start),
                    borderTop: false,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: _RideField(
                    label: 'Datum (Ende)',
                    value: _dateFormatter.format(widget.ride.end),
                    borderTop: false,
                    borderRight: true,
                  ),
                ),
                Expanded(
                  child: _RideField(
                    label: 'Zeit (Ende)',
                    value: _timeFormatter.format(widget.ride.end),
                    borderTop: false,
                  ),
                ),
              ],
            ),
            _RideField(
                label: 'Preis',
                value: '${widget.ride.price.toString().replaceAll('.', ',')} €',
                borderTop: false),
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

class _RideField extends StatelessWidget {
  final String? label;
  final String value;
  final bool borderLeft;
  final bool borderTop;
  final bool borderRight;
  final bool borderBot;
  final double _borderWith = 1.5;

  const _RideField(
      {Key? key,
      this.label,
      required this.value,
      this.borderLeft = false,
      this.borderTop = true,
      this.borderRight = false,
      this.borderBot = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          left: BorderSide(
              width: _borderWith,
              color: borderLeft
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          top: BorderSide(
              width: _borderWith,
              color: borderTop
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          right: BorderSide(
              width: _borderWith,
              color: borderRight
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
          bottom: BorderSide(
              width: _borderWith,
              color: borderBot
                  ? Theme.of(context).primaryColor
                  : Colors.transparent),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label!,
            textAlign: TextAlign.left,
            style: const TextStyle(),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            value,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }
}
