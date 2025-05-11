import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final void Function(String) onChanged;
  final List<String> suggestions;
  TextEditingController? _controller;

  CustomTextFormField({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.suggestions,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TypeAheadField<String>(
            builder: (context, controller, focusNode) {
              _controller = controller;
              return TextFormField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  onChanged(value);
                },
                decoration: InputDecoration(
                  hintText: label,
                ),
                validator: (value) {
                  return (value == null || value.isEmpty ? '' : null);
                },
              );
            },
            controller: _controller,
            suggestionsCallback: (value) {
              if (value.isEmpty) {
                return <String>[];
              }

              return suggestions
                  .where((suggestion) =>
                      suggestion.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            },
            onSelected: (String value) {
              if (_controller != null) {
                _controller!.text = value;
              }
              onChanged(value);
            },
            itemBuilder: (_, String suggestion) =>
                ListTile(title: Text(suggestion)),
            hideOnEmpty: true,
            hideOnLoading: true,
            animationDuration: const Duration(milliseconds: 150),
          ),
        ),
      ],
    );
  }
}
