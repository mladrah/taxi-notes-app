import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String initialValue;
  final void Function(String) onChanged;
  final List<String> suggestions;
  final TextEditingController _controller = TextEditingController();

  CustomTextFormField({
    Key? key,
    required this.label,
    required this.onChanged,
    required this.suggestions,
    this.initialValue = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _controller.text = initialValue;
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: TypeAheadFormField(
            suggestionsCallback: (content) {
              if (content != '') {
                return suggestions.where((suggestion) =>
                    suggestion.toLowerCase().contains(content.toLowerCase()));
              }

              return <String>[];
            },
            onSuggestionSelected: (String content) {
              _controller.text = content;
              onChanged(content);
            },
            itemBuilder: (_, String suggestion) =>
                ListTile(title: Text(suggestion)),
            hideOnEmpty: true,
            hideOnLoading: true,
            animationDuration: const Duration(milliseconds: 250),
            validator: (value) {
              return (value == null || value.isEmpty ? '' : null);
            },
            textFieldConfiguration: TextFieldConfiguration(
                controller: _controller,
                onChanged: onChanged,
                decoration: InputDecoration(hintText: label)),
          ),
        ),
      ],
    );
  }
}
