import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends StatelessWidget {
  final _dateFormat = DateFormat("dd.MM.yyyy");
  final _timeFormat = DateFormat("HH:mm");
  final String label;

  DateTimeFormField({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Expanded(
              child: DateTimeField(
                format: _dateFormat,
                initialValue: DateTime.now(),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: DateTimeField(
                format: _timeFormat,
                initialValue: DateTime.now(),
                onShowPicker: (context, currentValue) async {
                  final time = await showTimePicker(
                    builder: (context, childWidget) {
                      return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(alwaysUse24HourFormat: true),
                          child: childWidget!);
                    },
                    context: context,
                    initialTime:
                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                  );
                  return DateTimeField.convert(time);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
