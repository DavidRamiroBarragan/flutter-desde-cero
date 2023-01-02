import 'package:flutter/material.dart';

class CalendarPages extends StatefulWidget {
  const CalendarPages({Key? key}) : super(key: key);

  @override
  State<CalendarPages> createState() => _CalendarPagesState();
}

class _CalendarPagesState extends State<CalendarPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: SafeArea(
        child: CalendarDatePicker(
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
          onDateChanged: (value) {},
          initialDate: DateTime(2010),
          selectableDayPredicate: (day) {
            // Deshabilitar los sábados
            return day.weekday != 6;
          },
        ),
      ),
    );
  }
}
