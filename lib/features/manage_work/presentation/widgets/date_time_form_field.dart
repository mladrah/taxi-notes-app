import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeFormField extends StatelessWidget {
  final String label;
  final DateTime? initialValueDate;
  final DateTime? initialValueTime;

  final void Function(DateTime?) onChangedDate;
  final void Function(DateTime?) onChangedTime;
  final _dateFormat = DateFormat("dd.MM.yyyy");
  final _timeFormat = DateFormat("HH:mm");

  DateTimeFormField(
      {Key? key,
      required this.label,
      required this.onChangedDate,
      required this.onChangedTime,
      this.initialValueDate,
      this.initialValueTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              const Text(
                'Datum',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              DateTimeField(
                onChanged: onChangedDate,
                decoration: const InputDecoration(
                    hintText: 'DD.MM.YYYY',
                ),
                validator: (value) {
                  return (value == null) ? '' : null;
                },
                format: _dateFormat,
                initialValue: initialValueDate ?? DateTime.now(),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      initialDatePickerMode: DatePickerMode.day,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 8,
        ),
        Expanded(
          child: Column(
            children: [
              const Text(
                'Zeit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 8,
              ),
              DateTimeField(
                onChanged: onChangedTime,
                decoration: const InputDecoration(
                    hintText: '00:00',
                ),
                validator: (value) {
                  return (value == null) ? '' : null;
                },
                format: _timeFormat,
                initialValue: initialValueTime ?? DateTime.now(),
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
            ],
          ),
        ),
      ],
    );
  }
}
