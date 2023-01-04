import 'package:flutter/material.dart';
import 'package:forms/pages/login_mixin.dart';
import 'package:forms/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  String _email = '';
  String _password = '';

  void _submit(BuildContext context) {
    final formState = Form.of(context);
    if (formState?.validate() ?? false) {
      // cualquier acción
    }
  }

  @override
  Widget build(BuildContext context) {
    bool allowSubmit = emailValidator(_email) == null;

    if (allowSubmit) {
      allowSubmit = passwordValidator(_password) == null;
    }
    return Form(
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              CustomTextField(
                  // initialValue: 'test@text.com',
                  onChanged: (value) {
                    _email = value.trim();
                  },
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  label: 'Email',
                  validator: emailValidator),
              const SizedBox(
                height: 30,
              ),
              Builder(builder: (context) {
                return CustomTextField(
                  onChanged: (value) {
                    _password = value.replaceAll(' ', '');
                  },
                  obscureText: true,
                  textInputAction: TextInputAction.send,
                  label: 'Password',
                  validator: passwordValidator,
                  onSubmitted: (_) => _submit(context),
                );
              }),
              const SizedBox(
                height: 30,
              ),
              // CustomCheckbox(
              //     autovalidateMode: AutovalidateMode.onUserInteraction,
              //     onChange: (value) {
              //       setState(() {
              //         _checked = value;
              //       });
              //     }),
              // const SizedBox(
              //   height: 30,
              // ),
              Builder(
                builder: (context) {
                  return ElevatedButton(
                    onPressed: allowSubmit ? () => _submit(context) : null,
                    child: const Text('Sign In'),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
