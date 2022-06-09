import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16.h,
        ),
        Row(
          children: [
            Expanded(
              child: DateTimeField(
                onChanged: onChangedDate,
                validator: (value) {
                  return (value == null) ? '' : null;
                },
                format: _dateFormat,
                initialValue: initialValueDate ?? DateTime.now(),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
              ),
            ),
            SizedBox(
              width: 32.w,
            ),
            Expanded(
              child: DateTimeField(
                onChanged: onChangedTime,
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
            ),
          ],
        ),
      ],
    );
  }
}
