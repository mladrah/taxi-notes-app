import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';

import '../../../../injection_container.dart';
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
      floatingActionButton: buildFloatingActionBUtton(context),
    );
  }

  BlocProvider<ManageWorkBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) {
        return sl<ManageWorkBloc>();
      },
      child: Center(
        child: BlocBuilder<ManageWorkBloc, ManageWorkState>(
          builder: (context, state) {
            if (state is Empty) {
              return const HintMessage(message: 'Keine Arbeit!\n+ Klicken');
            } else {
              return const HintMessage(message: 'Kein gültiger Zustand!');
            }
          },
        ),
      ),
    );
  }

  FloatingActionButton buildFloatingActionBUtton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Theme.of(context).primaryColor,
      child: const Icon(Icons.add, color: Colors.white),
    );
  }
}
