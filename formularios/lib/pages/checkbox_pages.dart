import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({Key? key}) : super(key: key);

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  bool _check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarTextStyle: const TextStyle(color: Colors.white),
      ),
      body: SafeArea(
          child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Text('''
              Lorem ipsum dolor sit amet, consectetur adipiscing elit. 
              Donec egestas velit sapien, ut tincidunt felis pretium ut. 
              Integer quis imperdiet elit. Curabitur at enim ornare, 
              condimentum quam sed, rutrum nisl. 
              Vestibulum sed tellus vitae lacus iaculis ultrices. 
              Maecenas tristique aliquet leo sed tristique. 
              Mauris vel placerat odio. Nulla nunc purus, convallis sed 
              commodo nec, convallis vitae justo. 
              Nulla egestas orci vel diam tempus, ac vestibulum erat viverra. 
              Sed ullamcorper massa ac purus lobortis condimentum.
              '''),
              CheckboxListTile(
                value: _check,
                onChanged: (value) {
                  setState(() {
                    _check = value!;
                  });
                },
                title: const Text('Label 1'),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
              // GestureDetector(
              //   onTap: () {
              //     setState(() {
              //       _check = !_check;
              //     });
              //   },
              //   child: Row(
              //     children: [
              //       Checkbox(
              //         value: _check,
              //         onChanged: (value) {
              //           setState(() {
              //             _check = value!;
              //           });
              //         },
              //       ),
              //       const Flexible(
              //         child: Text('Label 2'),
              //       ),
              //     ],
              //   ),
              // ),
              Checkbox(
                fillColor: MaterialStateProperty.all(Colors.lightBlue),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                value: _check,
                onChanged: (value) {
                  setState(() {
                    _check = value!;
                  });
                },
              ),
              MaterialButton(
                onPressed: _check ? () {} : null,
                child: const Text('Next'),
              ),
              Switch(
                value: _check,
                onChanged: (value) {
                  setState(() {
                    _check = value;
                  });
                },
              ),
              const Divider(),
              SwitchListTile(
                inactiveTrackColor: Colors.amber.shade100,
                inactiveThumbColor: Colors.amber.shade100,
                title: const Text('Label Switch'),
                value: _check,
                onChanged: (value) {
                  setState(() {
                    _check = value;
                  });
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}
