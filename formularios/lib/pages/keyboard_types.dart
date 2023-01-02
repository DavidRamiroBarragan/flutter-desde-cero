import 'package:flutter/material.dart';

class KeyboardsTypesPages extends StatelessWidget {
  const KeyboardsTypesPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.all(25),
        children: [
          const TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text('E-mail'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              label: Text('Phone'),
            ),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(
            height: 20,
          ),
          const TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              label: Text('Price'),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              label: Text('Name'),
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (value) {
              print(value);
            },
          ),
        ],
      ),
    );
  }
}
