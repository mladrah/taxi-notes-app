import 'package:flutter/material.dart' hide Title;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:taxi_rahmati/features/manage_work/presentation/bloc/manage_work_bloc.dart';
import '../../domain/entities/ride.dart';
import '../widgets/currency_form_field.dart';
import '../../../../core/presentation/widgets/custom_elevated_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/date_time_form_field.dart';
import '../widgets/radio_button.dart';

class RideFormPage extends StatefulWidget {
  final Ride? ride;
  const RideFormPage({Key? key, this.ride}) : super(key: key);

  @override
  State<RideFormPage> createState() => _RideFormPageState();
}

class _RideFormPageState extends State<RideFormPage> {
  final _formKey = GlobalKey<FormState>();
  late Title _title = widget.ride == null ? Title.herr : widget.ride!.title;
  late String _name = widget.ride == null ? '' : widget.ride!.name;
  late String _destination =
      widget.ride == null ? '' : widget.ride!.destination;
  late String _price = widget.ride == null
      ? ''
      : widget.ride!.price.toString().replaceAll('.', ',');
  late DateTime? _startDate =
      widget.ride == null ? DateTime.now() : widget.ride!.start;
  late DateTime? _startTime =
      widget.ride == null ? DateTime.now() : widget.ride!.start;
  late DateTime? _endDate =
      widget.ride == null ? DateTime.now() : widget.ride!.end;
  late DateTime? _endTime =
      widget.ride == null ? DateTime.now() : widget.ride!.end;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Fahrt hinzufügen',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: buildBody(context));
  }

  Widget buildBody(BuildContext context) {
    return BlocListener<ManageWorkBloc, ManageWorkState>(
      listener: (context, state) {
        if (state is Created) {
          Navigator.pop(context);
        } else if (state is Updated) {
          Navigator.pop(context, state.ride);
        } else if (state is Error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(48.h),
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
                  CustomTextFormField(
                    label: 'Name',
                    onChanged: (value) => _name = value,
                    initialValue: _name,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CustomTextFormField(
                    label: 'Ort',
                    onChanged: (value) => _destination = value,
                    initialValue: _destination,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  DateTimeFormField(
                    label: 'Start',
                    onChangedDate: (value) => _startDate = value,
                    onChangedTime: (value) => _startTime = value,
                    initialValueDate: _startDate,
                    initialValueTime: _startTime,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  DateTimeFormField(
                    label: 'Ende',
                    onChangedDate: (value) => _endDate = value,
                    onChangedTime: (value) => _endTime = value,
                    initialValueDate: _endDate,
                    initialValueTime: _endTime,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  CurrencyFormField(
                    label: 'Preis (€)',
                    onChanged: (value) => _price = value,
                    initialValue: _price,
                  ),
                  SizedBox(
                    height: 32.h,
                  ),
                  BlocBuilder<ManageWorkBloc, ManageWorkState>(
                    builder: (context, state) {
                      if (state is Loading) {
                        return const CustomElevatedButton(
                          onPressed: null,
                          label: 'Erstellen',
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return CustomElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _dispatchEvent();
                            }
                          },
                          label: widget.ride == null ? 'Erstellen' : 'Ändern',
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dispatchEvent() {
    if (widget.ride == null) {
      context.read<ManageWorkBloc>().add(
            AddRideToRepository(
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
    } else {
      context.read<ManageWorkBloc>().add(UpdateRideInRepository(
            id: widget.ride!.id,
            title: _title,
            name: _name,
            destination: _destination,
            startDate: _startDate!,
            startTime: _startTime!,
            endDate: _endDate!,
            endTime: _endTime!,
            price: _price,
          ));
    }
  }
}
