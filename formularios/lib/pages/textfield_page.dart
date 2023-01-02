import 'package:flutter/material.dart';
import '../constants/countries.dart';
import '../models/country.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  late List<Country> _countries;
  String _query = '';

  @override
  void initState() {
    super.initState();
    _countries = countries.map<Country>((e) => Country.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    late final List<Country> filteredList;

    if (_query.isEmpty) {
      filteredList = _countries;
    } else {
      filteredList = _countries
          .where((element) => element.name.toLowerCase().contains(
                _query.toLowerCase(),
              ))
          .toList();
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: TextField(
          onChanged: (value) {
            _query = value;
            setState(() {});
          },
        ),
      ),
      body: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(filteredList[index].name),
          );
        },
        itemCount: filteredList.length,
      ),
    );
  }
}
