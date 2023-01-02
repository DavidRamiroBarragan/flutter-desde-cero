import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formularios/utils/capitalize_input_formatter.dart';
import '../constants/countries.dart';
import '../models/country.dart';

class TextFieldPage extends StatefulWidget {
  const TextFieldPage({Key? key}) : super(key: key);

  @override
  State<TextFieldPage> createState() => _TextFieldPageState();
}

class _TextFieldPageState extends State<TextFieldPage> {
  late List<Country> _countries;
  final _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _countries = countries.map<Country>((c) => Country.fromJson(c)).toList();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late final List<Country> filteredList;
    final query = _editingController.text;

    if (query.isEmpty) {
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
          controller: _editingController,
          inputFormatters: [
            FilteringTextInputFormatter(
              RegExp(r'^[a-zA-Z\s]*$'),
              allow: true,
            ),
            CapitalizeInputFormatter()
          ],
          onChanged: (_) {
            setState(() {});
          },
          decoration: InputDecoration(
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffd81b60),
              ),
            ),
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xffd81b60),
              ),
            ),
            disabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black12,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
            label: const Text('Search...'),
            hintText: 'Example: Ecuador',
            hintStyle: const TextStyle(
              color: Colors.black26,
            ),
            prefixIcon: const Icon(Icons.search_outlined),
            suffixIcon: IconButton(
                onPressed: () {
                  _editingController.text = '';
                  FocusScope.of(context).unfocus();
                },
                icon: const Icon(Icons.close)),
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
    _editingController.text.toLowerCase(),
      );
}
