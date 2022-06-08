import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/custom_elevated_button.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/ride_details_field.dart';

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
  final DateFormat _timeFormatter = DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fahrt'),
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
                  child: RideDetailsField(
                    label: 'Anrede',
                    value: widget.ride.title == Title.herr ? 'Herr' : 'Frau',
                    borderRight: true,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: RideDetailsField(
                    label: 'Name',
                    value: widget.ride.name,
                  ),
                ),
              ],
            ),
            RideDetailsField(
              label: 'Ort',
              value: widget.ride.destination,
              borderTop: false,
              borderLeft: false,
              borderRight: false,
            ),
            Row(
              children: [
                Expanded(
                  child: RideDetailsField(
                    label: 'Datum (Start)',
                    value: _dateFormatter.format(widget.ride.start),
                    borderTop: false,
                    borderRight: true,
                  ),
                ),
                Expanded(
                  child: RideDetailsField(
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
                  child: RideDetailsField(
                    label: 'Datum (Ende)',
                    value: _dateFormatter.format(widget.ride.end),
                    borderTop: false,
                    borderRight: true,
                  ),
                ),
                Expanded(
                  child: RideDetailsField(
                    label: 'Zeit (Ende)',
                    value: _timeFormatter.format(widget.ride.end),
                    borderTop: false,
                  ),
                ),
              ],
            ),
            RideDetailsField(
                label: 'Preis',
                value: '${widget.ride.price.toString().replaceAll('.', ',')} €',
                borderTop: false),
            Padding(
              padding: EdgeInsets.fromLTRB(48.h, 32.h, 48.h, 32.h),
              child: CustomElevatedButton(
                  label: 'Ändern',
                  onPressed: () {
                    _onEditButton(context);
                  }),
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
