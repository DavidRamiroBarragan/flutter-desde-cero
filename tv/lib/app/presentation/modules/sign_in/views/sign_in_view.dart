import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _userName = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  setState(() {
                    _userName = value.trim().toLowerCase();
                  });
                },
                decoration: const InputDecoration(hintText: 'username'),
                validator: (value) {
                  value = value?.trim().toLowerCase() ?? '';
                  if (value.isEmpty) {
                    return 'Invalid username';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (value) {
                  setState(() {
                    _password = value.replaceAll(' ', '').toLowerCase();
                  });
                },
                decoration: const InputDecoration(hintText: 'password'),
                validator: (value) {
                  value = value?.replaceAll(' ', '') ?? '';
                  if (value.isEmpty || value.length < 4) {
                    return 'Invalid password';
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Builder(
                builder: (context) {
                  return MaterialButton(
                    onPressed: () {
                      final isValid = Form.of(context)!.validate();

                      if(isValid) {

                      }
                    },
                    color: Colors.blue,
                    child: const Text('Sign In'),
                  );
                }
              )
            ]),
          ),
        ),
      ),
    );
  }
}
