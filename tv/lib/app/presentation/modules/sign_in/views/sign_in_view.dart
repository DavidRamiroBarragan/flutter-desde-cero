import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SignInView extends StatefulWidget {
  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (context) => SignInController(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Builder(builder: (context) {
                final signInController = Provider.of<SignInController>(context);
                return AbsorbPointer(
                  absorbing: signInController.fetching,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (value) {
                            signInController.onUserNameChanged(value);
                          },
                          decoration:
                              const InputDecoration(hintText: 'username'),
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
                            signInController.onPasswordChanged(value);
                          },
                          decoration:
                              const InputDecoration(hintText: 'password'),
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
                        if (signInController.fetching)
                          const CircularProgressIndicator()
                        else
                          MaterialButton(
                            onPressed: () {
                              final isValid = Form.of(context)!.validate();

                              if (isValid) {
                                submit(context);
                              }
                            },
                            color: Colors.blue,
                            child: const Text('Sign In'),
                          ),
                      ]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> submit(BuildContext context) async {
    final SignInController signInController = context.read();

    signInController.onFetchingChanged(true);
    if (!mounted) {
      return;
    }
    final authenticationRepository =
        Provider.of<AuthenticationRepository>(context, listen: false);
    final result = await authenticationRepository.singIn(
      signInController.username,
      signInController.password,
    );

    result.when((failure) {
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Unknown',
        SignInFailure.network: 'Network error',
      }[failure];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
      signInController.onFetchingChanged(false);
    }, (user) {
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
