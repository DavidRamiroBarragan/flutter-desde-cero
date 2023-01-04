import 'package:flutter/material.dart';

class CustomCheckbox extends FormField<bool> {
  CustomCheckbox(
      {Key? key,
      required void Function(bool value) onChange,
      AutovalidateMode? autovalidateMode,
      String? Function(bool?)? validator,
      bool? initialValue})
      : super(
            key: key,
            autovalidateMode: autovalidateMode,
            validator: validator,
            initialValue: initialValue,
            builder: (state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CheckboxListTile(
                    title: const Text('Hello world'),
                    controlAffinity: ListTileControlAffinity.leading,
                    value: state.value ?? false,
                    onChanged: (value) {
                      state.didChange(value);
                      if (value != null) {
                        onChange(value);
                      }
                    },
                  ),
                  if (state.hasError)
                    Text(
                      state.errorText!,
                      style: const TextStyle(
                        color: Colors.redAccent,
                      ),
                    ),
                ],
              );
            });
}
