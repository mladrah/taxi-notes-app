import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import '../../domain/entities/ride.dart';
import '../widgets/currency_form_field.dart';
import '../widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/date_time_form_field.dart';
import '../widgets/radio_button.dart';

class RideFormPage extends StatefulWidget {
  const RideFormPage({Key? key}) : super(key: key);

  @override
  State<RideFormPage> createState() => _RideFormPageState();
}

class _RideFormPageState extends State<RideFormPage> {
  final _formKey = GlobalKey<FormState>();
  Title _title = Title.herr;
  late String _name;
  late String _destination;
  late String _price;
  DateTime? _startDate = DateTime.now();
  DateTime? _startTime = DateTime.now();
  DateTime? _endDate = DateTime.now();
  DateTime? _endTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fahrt hinzufügen'),
        ),
        body: SingleChildScrollView(child: buildBody(context)));
  }

  Center buildBody(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: RadioButton<Title>(
                      label: 'Herr',
                      value: Title.herr,
                      groupValue: _title,
                      onChanged: (value) => setState(
                        () {
                          _title = value!;
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: RadioButton<Title>(
                      label: 'Frau',
                      value: Title.frau,
                      groupValue: _title,
                      onChanged: (value) => setState(
                        () {
                          _title = value!;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              CustomTextFormField(
                label: 'Name',
                onChanged: (value) => _name = value,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomTextFormField(
                label: 'Ort',
                onChanged: (value) => _destination = value,
              ),
              const SizedBox(
                height: 16,
              ),
              DateTimeFormField(
                label: 'Start',
                onChangedDate: (value) => _startDate = value,
                onChangedTime: (value) => _startTime = value,
              ),
              const SizedBox(
                height: 16,
              ),
              DateTimeFormField(
                label: 'Ende',
                onChangedDate: (value) => _endDate = value,
                onChangedTime: (value) => _endTime = value,
              ),
              const SizedBox(
                height: 16,
              ),
              CurrencyFormField(
                label: 'Preis (€)',
                onChanged: (value) => _price = value,
              ),
              const SizedBox(
                height: 16,
              ),
              CustomElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    dispatchAdd();
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   SnackBar(
                    //       content: Text(
                    //           '$_title $_name $_destination sd: $_startDate st: $_startTime ed: $_endDate et: $_endTime $_price')),
                    // );
                  }
                },
                label: 'Erstellen',
              )
            ],
          ),
        ),
      ),
    );
  }

  void dispatchAdd() {
    BlocProvider.of<ManageWorkBloc>(context).add(
      AddRideToList(
        title: _title,
        name: _name,
        destination: _destination,
        startDate: _startDate!,
        startTime: _startTime!,
        endDate: _endDate!,
        endTime: _endTime!,
        price: _price,
      ),
    );
  }
}
