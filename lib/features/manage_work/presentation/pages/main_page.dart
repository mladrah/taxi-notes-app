import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/pages/ride_form_page.dart';

import '../../../../constants.dart';
import '../../../../core/presentation/widgets/hint_message.dart';
import '../../domain/entities/ride.dart';
import '../../domain/entities/work_unit.dart';
import '../bloc/manage_work_bloc.dart';
import '../widgets/create_work_unit_button.dart';
import '../widgets/work_unit_tile.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  List<WorkUnit> workUnits = [];

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Taxi Notes',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          BlocBuilder<ManageWorkBloc, ManageWorkState>(
            builder: (context, state) {
              if (state is WorkUnitsLoaded) {
                workUnits = state.workUnits;
                if (workUnits.isNotEmpty) {
                  return IconButton(
                    onPressed: () => _onPrintButton(context),
                    icon: const Icon(Icons.print_rounded),
                    tooltip: 'Drucken',
                  );
                }
              }

              return const SizedBox.shrink();
            },
          )
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocConsumer<ManageWorkBloc, ManageWorkState>(
      listener: (context, state) {
        if (state is RideAdded ||
            state is RideDeleted ||
            state is RideUpdated ||
            state is WorkUnitDeleted) {
          context.read<ManageWorkBloc>().add(LoadWorkUnitsFromRepository());
        }
      },
      builder: (context, state) {
        if (state is Loading) {
          return const CircularProgressIndicator();
        } else if (state is WorkUnitsLoaded) {
          workUnits = state.workUnits;
          _addSuggestions(workUnits);
          return _buildGrid(context, workUnits);
        } else if (state is Error) {
          return HintMessage(
              message: '${state.message}!\nBitte versuche es erneut');
        }
        return HintMessage(message: 'Unbekannter Fehler: $state');
      },
    );
  }

  Widget _buildGrid(BuildContext context, List<WorkUnit> workUnits) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 120,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      clipBehavior: Clip.none,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      itemCount: workUnits.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) return const CreateWorkUnitButton();
        return WorkUnitTile(
          workUnit: workUnits[index - 1],
        );
      },
    );
  }

  void _addSuggestions(List<WorkUnit> workUnits) {
    for (WorkUnit workUnit in workUnits) {
      for (Ride ride in workUnit.rides) {
        SuggestionContainer.addDestinationSuggestion(ride.fromDestination);
        SuggestionContainer.addDestinationSuggestion(ride.toDestination);
        SuggestionContainer.addNameSuggestion(ride.name);
      }
    }
  }

  void _onPrintButton(BuildContext context) async {
    Navigator.of(context).pushNamed(Constants.ROUTING_RIDE_PRINT_PREVIEW_PAGE,
        arguments: {
          Constants.ARGS_RIDE_PRINT_PREVIEW_PAGE_WORKUNITS: workUnits
        });
  }
}
