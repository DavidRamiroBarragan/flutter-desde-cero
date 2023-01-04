import 'package:flutter/material.dart';

class CustomTextField extends FormField<String> {
  CustomTextField(
      {Key? key,
      required String label,
      void Function(String)? onChanged,
      String? Function(String?)? validator,
      TextInputType? keyboardType,
      TextInputAction? textInputAction,
      void Function(String)? onSubmitted,
      bool obscureText = false})
      : super(
          key: key,
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          builder: (state) {
            bool isOk = !state.hasError &&
                state.value != null &&
                state.value!.isNotEmpty;
            return TextField(
              onChanged: (value) {
                state.didChange(value);
                if (onChanged != null) {
                  onChanged(value);
                }
              },
              textInputAction: textInputAction,
              keyboardType: keyboardType,
              obscureText: obscureText,
              onSubmitted: onSubmitted,
              decoration: InputDecoration(
                label: Text(label),
                suffixIcon: isOk
                    ? const Icon(
                        Icons.check_circle,
                        color: Colors.greenAccent,
                      )
                    : null,
              ),
            );
          },
        );
}
