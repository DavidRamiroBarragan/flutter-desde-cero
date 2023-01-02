import 'package:flutter/material.dart';


class SliderPage extends StatefulWidget {
  const SliderPage({Key? key}) : super(key: key);

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  double _value = 0;
  double _value2 = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Slider(
                value: _value2,
                label: '$_value2',
                divisions: 10,
                min: 0,
                max: 10,
                onChanged: (value) {
                  setState((){
                    _value2 = value.floorToDouble();
                  });
                },
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Slider(
                  value: _value,
                  label: '$_value',
                  divisions: 100,
                  min: 0,
                  max: 100,
                  onChanged: (value) {
                    setState((){
                      _value = value.floorToDouble();
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
