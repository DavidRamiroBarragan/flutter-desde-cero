import 'package:flutter/material.dart';

class RadioButtonPage extends StatefulWidget {
  const RadioButtonPage({Key? key}) : super(key: key);

  @override
  State<RadioButtonPage> createState() => _RadioButtonPageState();
}

class _RadioButtonPageState extends State<RadioButtonPage> {
  String? _better;
  String? _gender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(15),
          children: [
            const Text('¿Cual es mejor?'),
            RadioListTile<String>(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: const Text('Flutter'),
              value: 'flutter',
              groupValue: _better,
              onChanged: _setFramework,
            ),
            RadioListTile<String>(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: const Text('React Native'),
              value: 'react-native',
              groupValue: _better,
              onChanged: _setFramework,
            ),
            const Divider(),
            const Text('¿What es tu género?'),
            RadioListTile<String>(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: const Text('Masculino'),
              value: 'male',
              groupValue: _gender,
              onChanged: _setGender,
            ),
            RadioListTile<String>(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: const Text('Femenino'),
              value: 'female',
              groupValue: _gender,
              onChanged: _setGender,
              activeColor: Colors.redAccent,
            ),
            RadioListTile<String>(
              visualDensity: VisualDensity.compact,
              contentPadding: EdgeInsets.zero,
              title: const Text('Otro'),
              value: 'other',
              groupValue: _gender,
              onChanged: _setGender,
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }

  void _setFramework(value) {
    setState(() {
      _better = value;
    });
  }

  void _setGender(value) {
    setState(() {
      _gender = value;
    });
  }
}
