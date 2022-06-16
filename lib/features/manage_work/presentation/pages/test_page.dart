// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TestPage extends StatelessWidget {
  TestPage({Key? key}) : super(key: key);
  final TextEditingController _controller = TextEditingController();
  static const List<String> _options = <String>[
    'aardvarkasdasdasdasdsdfsdfasdgg',
    'bobcat',
    'chameleon',
    '12',
    'chameasdleon',
    'chameldseon',
    'chameddsleon',
    'asds',
    'dasdasd',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              TypeAheadFormField(
                textFieldConfiguration:
                    TextFieldConfiguration(controller: _controller),
                onSuggestionSelected: (String val) => _controller.text = val,
                itemBuilder: (_, String item) => ListTile(title: Text(item)),
                suggestionsCallback: (suggestions) {
                  if (suggestions != '') {
                    return _options.where((element) => element
                        .toLowerCase()
                        .contains(suggestions.toLowerCase()));
                  }
                  return <String>[];
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class AutocompleteBasicExample extends StatelessWidget {
//   const AutocompleteBasicExample({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return TypeAheadFormField(
//       suggestionsCallback: (suggestions) {
//         if (suggestions != '') {
//           return _options.where((element) =>
//               element.toLowerCase().contains(suggestions.toLowerCase()));
//         }
//         return <String>[];
//       },
//       itemBuilder: (_, String item) => ListTile(title: Text(item)),
//       onSuggestionSelected: (String val) => log(val),
//       hideOnEmpty: true,
//       hideOnLoading: true,
//     );
//   }
// }
