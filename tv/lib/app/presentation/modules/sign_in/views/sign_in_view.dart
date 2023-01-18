import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  String _username = '';
  String _password = '';
  bool _fetching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            child: AbsorbPointer(
              absorbing: _fetching,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  onChanged: (value) {
                    setState(() {
                      _username = value.trim().toLowerCase();
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
                      _password = value.replaceAll(' ', '');
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
                Builder(builder: (context) {
                  if (_fetching) {
                    const CircularProgressIndicator();
                  }

                  return MaterialButton(
                    onPressed: () {
                      final isValid = Form.of(context)!.validate();

                      if (isValid) {
                        submit(context);
                      }
                    },
                    color: Colors.blue,
                    child: const Text('Sign In'),
                  );
                })
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit(BuildContext bcontext) async {
    setState(() {
      _fetching = true;
    });
    if (!mounted) {
      return;
    }
    final authenticationRepository =
    Provider.of<AuthenticationRepository>(context, listen: false);
    final result = await authenticationRepository
        .singIn(_username, _password);

    result.when((failure) {
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Unknown',
        SignInFailure.network: 'Network error',
      }[failure];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
      setState(() {
        _fetching = false;
      });
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
