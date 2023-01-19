import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInController = Provider.of<SignInController>(context);
    if (signInController.fetching) {
      return const CircularProgressIndicator();
    }
    return MaterialButton(
      onPressed: () {
        final isValid = Form.of(context)!.validate();

        if (isValid) {
          _submit(context);
        }
      },
      color: Colors.blue,
      child: const Text('Sign In'),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final SignInController signInController = context.read();

    signInController.onFetchingChanged(true);
    if (!signInController.mounted) {
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
