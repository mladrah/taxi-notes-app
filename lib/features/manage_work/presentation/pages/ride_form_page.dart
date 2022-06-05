import 'package:flutter/material.dart' hide Title;
import '../../domain/entities/ride.dart';
import '../widgets/custom_text_form_field.dart';
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
        body: buildBody(context));
  }

  Form buildBody(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          buildTitleRadioButtons(),
          const SizedBox(
            height: 16,
          ),
          const CustomTextFormField(hintText: 'Name'),
        ],
      ),
    );
  }

  Widget buildTitleRadioButtons() {
    return Row(
      children: [
        Expanded(
          child: RadioButton<Title>(
              label: 'Herr',
              value: Title.herr,
              groupValue: _title,
              onChanged: (value) => setState(() {
                    _title = value!;
                  })),
        ),
        Expanded(
            child: RadioButton<Title>(
                label: 'Frau',
                value: Title.frau,
                groupValue: _title,
                onChanged: (value) => setState(() {
                      _title = value!;
                    }))),
      ],
    );
  }
}
