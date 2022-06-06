import 'package:flutter/material.dart' hide Title;
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
              const CustomTextFormField(label: 'Name'),
              const SizedBox(
                height: 16,
              ),
              const CustomTextFormField(label: 'Ort'),
              const SizedBox(
                height: 16,
              ),
              DateTimeFormField(label: 'Start'),
              const SizedBox(
                height: 16,
              ),
              DateTimeFormField(label: 'Ende'),
              const SizedBox(
                height: 16,
              ),
              CurrencyFormField(
                label: 'Preis (€)',
              ),
              const SizedBox(
                height: 16,
              ),
              const CustomElevatedButton(
                label: 'Erstellen',
              )
            ],
          ),
        ),
      ),
    );
  }
}
