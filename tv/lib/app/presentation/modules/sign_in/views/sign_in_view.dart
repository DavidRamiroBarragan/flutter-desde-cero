import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../controller/sign_in_controller.dart';
import '../controller/state/sign_in_state.dart';
import '../widgets/submit_button.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SignInController>(
      create: (context) => SignInController(
        const SignInState(),
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              child: Builder(builder: (context) {
                final signInController =
                    Provider.of<SignInController>(context, listen: true);
                return AbsorbPointer(
                  absorbing: signInController.state.fetching,
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
                        const SubmitButton(),
                      ]),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
