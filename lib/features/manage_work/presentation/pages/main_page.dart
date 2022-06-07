import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/ride_tile.dart';

import '../widgets/add_ride_button.dart';
import '../widgets/hint_message.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Rahmati'),
      ),
      body: buildBody(context),
      floatingActionButton: const AddRideButton(),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: BlocBuilder<ManageWorkBloc, ManageWorkState>(
        builder: (context, state) {
          if (state is Loading) {
            return const CircularProgressIndicator();
          } else if (state is Empty) {
            return const HintMessage(message: 'Keine Arbeit!\n+ Klicken');
          } else if (state is Error) {
            return HintMessage(
                message: 'Fehler: ${state.message}!\nBitte versuche es erneut');
          } else if (state is Loaded) {
            return ListView.separated(
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(height: 16);
                },
                padding: const EdgeInsets.all(16),
                itemCount: state.allRides.length,
                itemBuilder: (BuildContext context, int index) {
                  return RideTile(
                    ride: state.allRides[index],
                  );
                });
          } else {
            return const HintMessage(message: 'Unbekannter Fehler!');
          }
        },
      ),
    );
  }
}
