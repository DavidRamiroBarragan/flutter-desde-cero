import 'package:flutter/material.dart';
import 'package:forms/pages/login_mixin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with LoginMixin {
  String _email = '';
  String _password = '';

  // void submit(BuildContext context) {
  //   final formState = Form.of(context);
  //   if (formState?.validate() ?? false) {
  //     // cualquier acción
  //   }
  // }

  void _submit() {}

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
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  // initialValue: 'test@text.com',
                  onChanged: (value) {
                    _email = value.trim();
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    label: Text('Email'),
                  ),
                  validator: emailValidator),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                onChanged: (value) {
                  _password = value.replaceAll(' ', '');
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text('Password'),
                ),
                validator: passwordValidator,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: allowSubmit ? _submit : null,
                child: const Text('Sign In'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
