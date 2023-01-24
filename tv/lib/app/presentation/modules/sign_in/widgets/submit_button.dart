import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/enums.dart';
import '../../../controller/session_controller.dart';
import '../../../routes/routes.dart';
import '../controller/sign_in_controller.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final signInController = Provider.of<SignInController>(context);
    if (signInController.state.fetching) {
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
    final result = await signInController.submit();

    if (!signInController.mounted) {
      return;
    }

    result.when((failure) {
      final message = {
        SignInFailure.notFound: 'Not Found',
        SignInFailure.unauthorized: 'Invalid password',
        SignInFailure.unknown: 'Unknown',
        SignInFailure.network: 'Network error',
      }[failure];

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message!)));
    }, (user) {
      final SessionController sessionController = context.read();

      sessionController.setUser(user);
      Navigator.pushReplacementNamed(context, Routes.home);
    });
  }
}
