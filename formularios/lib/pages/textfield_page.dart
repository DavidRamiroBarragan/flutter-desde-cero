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
    _countries = countries.map<Country>((c) => Country.fromJson(c)).toList();
  }

  @override
  Widget build(BuildContext context) {
    late final List<Country> filteredList;

    if (_query.isEmpty) {
      filteredList = _countries;
    } else {
      filteredList = _countries.where(finder).toList();
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
          decoration: const InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffd81b60),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffd81b60),
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 10),
            label: Text('Search...'),
            hintText: 'Example: Ecuador',
            hintStyle: TextStyle(
              color: Colors.black26,
            ),
            prefixIcon: Icon(Icons.search_outlined),
            suffixIcon: Icon(Icons.close),

          ),
        ),
      ),
      body: GestureDetector(
        child: ListView.builder(
          // Esconder el teclado cuando hacemos drag sobre la lista
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(filteredList[index].name),
            );
          },
          itemCount: filteredList.length,
        ),
      ),
    );
  }

  bool finder(c) => c.name.toLowerCase().contains(
        _query.toLowerCase(),
      );
}
