import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/widgets/ride_tile.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../domain/entities/ride.dart';
import '../widgets/add_ride_button.dart';
import '../widgets/hint_message.dart';

class MainPage extends StatelessWidget {
  late List<Ride> rides;

  MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taxi Rahmati'),
        actions: [
          IconButton(
              onPressed: () {
                _onPrintButton(context);
              },
              icon: const Icon(Icons.print_rounded))
        ],
      ),
      body: buildBody(context),
      floatingActionButton: const AddRideButton(),
    );
  }

  Widget buildBody(BuildContext context) {
    return Center(
      child: BlocConsumer<ManageWorkBloc, ManageWorkState>(
        listener: (context, state) {
          if (state is Created || state is Deleted || state is Updated) {
            context.read<ManageWorkBloc>().add(LoadRidesFromRepository());
          }
        },
        builder: (context, state) {
          return BlocBuilder<ManageWorkBloc, ManageWorkState>(
            builder: (context, state) {
              if (state is Loading) {
                return const CircularProgressIndicator();
              } else if (state is Loaded) {
                return state.rides.isEmpty
                    ? const HintMessage(message: 'Keine Arbeit!\n+ Klicken')
                    : _buildList(state.rides);
              } else if (state is Error) {
                return HintMessage(
                    message: '${state.message}!\nBitte versuche es erneut');
              } else {
                return HintMessage(message: 'Unbekannter Fehler: ');
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildList(List<Ride> rides) {
    this.rides = rides;

    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) {
        return const SizedBox(height: 16);
      },
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
      itemCount: rides.length,
      itemBuilder: (BuildContext context, int index) {
        return RideTile(
          ride: rides[index],
        );
      },
    );
  }

  void _onPrintButton(BuildContext context) async {
    // final doc = pw.Document();
    // doc.addPage(pw.Page(
    //     pageFormat: PdfPageFormat.a4,
    //     build: (pw.Context context) {
    //       return pw.Container(color: PdfColor.fromHex('FCA311'));
    //     }));

    // await Printing.layoutPdf(
    //     onLayout: (PdfPageFormat format) async => doc.save());
    Navigator.of(context)
        .pushNamed('/ridesPrintPreview', arguments: {'rides': rides});
  }
}
