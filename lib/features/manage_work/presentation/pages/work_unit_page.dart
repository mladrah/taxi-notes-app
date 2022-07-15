import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/constants.dart';

import '../../../../core/presentation/widgets/custom_floating_action_button.dart';
import '../../../../core/util/date_time_formatter.dart';
import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';
import '../bloc/manage_work_bloc.dart';
import '../widgets/delete_alert.dart';
import '../widgets/empty_list_hint_message.dart';
import '../widgets/ride_tile.dart';

// ignore: must_be_immutable
class WorkUnitPage extends StatefulWidget {
  WorkUnit? workUnit;

  WorkUnitPage({Key? key, required this.workUnit}) : super(key: key);

  @override
  State<WorkUnitPage> createState() => _WorkUnitPageState();
}

// ignore: must_be_immutable
class _WorkUnitPageState extends State<WorkUnitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
      floatingActionButton: CustomFloatingActionButton(
        onPressed: () => _onCreateButton(context),
        tooltip: 'Fahrt hinzufügen',
        child: const Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(
        widget.workUnit == null
            ? 'Neue Liste'
            : DateTimeFormatter.dayMonthInterval(
                widget.workUnit!.rides[0].start,
                widget
                    .workUnit!.rides[widget.workUnit!.rides.length - 1].start),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        widget.workUnit == null
            ? const SizedBox.shrink()
            : PopupMenuButton<int>(
                onSelected: (menuItem) => _handlePopMenuClick(menuItem),
                itemBuilder: (context) => [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: _PopMenuListTile(
                      icon: Icon(
                        Icons.print_rounded,
                      ),
                      text: Text('Drucken'),
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: _PopMenuListTile(
                      icon: Icon(
                        Icons.delete_forever_rounded,
                        color: Theme.of(context).errorColor,
                      ),
                      text: Text(
                        'Löschen',
                        style: TextStyle(
                            color: Theme.of(context).errorColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocListener<ManageWorkBloc, ManageWorkState>(
      listener: (context, state) {
        if (state is RideAdded) {
          widget.workUnit = state.workUnit;
        } else if (state is RideDeleted) {
          widget.workUnit = state.workUnit;
        } else if (state is RideUpdated) {
          widget.workUnit = state.workUnit;
        } else if (state is WorkUnitDeleted) {
          Navigator.pop(context);
        }
        setState(() {});
      },
      child: widget.workUnit == null
          ? const EmptyListHintMessage()
          : _buildList(widget.workUnit!.rides),
    );
  }

  Widget _buildList(List<Ride> rides) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 8);
      },
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 80),
      itemCount: rides.length,
      itemBuilder: (BuildContext context, int index) {
        return RideTile(
          ride: rides[index],
          workUnit: widget.workUnit!,
        );
      },
    );
  }

  void _handlePopMenuClick(int menuItemIndex) {
    switch (menuItemIndex) {
      case 0:
        _onPrintButton(context);
        break;
      case 1:
        _onDeleteButton(context);
        break;
    }
  }

  void _onCreateButton(BuildContext context) {
    Navigator.of(context)
        .pushNamed('/rideForm', arguments: {'workUnit': widget.workUnit});
  }

  void _onPrintButton(BuildContext context) async {
    Navigator.of(context)
        .pushNamed(Constants.ROUTING_RIDE_PRINT_PREVIEW_PAGE, arguments: {
      Constants.ARGS_RIDE_PRINT_PREVIEW_PAGE_WORKUNITS: <WorkUnit>[
        widget.workUnit!
      ]
    });
  }

  void _onDeleteButton(BuildContext context) async {
    DeleteAlert(
            context: context,
            onPressed: () => (context),
            title: 'Liste löschen?')
        .alert
        .show();
  }
}

class _PopMenuListTile extends StatelessWidget {
  const _PopMenuListTile({Key? key, required this.text, required this.icon})
      : super(key: key);

  final Text text;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 24,
      child: Row(children: [
        icon,
        const SizedBox(
          width: 8,
        ),
        text
      ]),
    );
  }
}
