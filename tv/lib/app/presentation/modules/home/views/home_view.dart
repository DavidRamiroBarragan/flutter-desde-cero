import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/repositories/authentication_repository.dart';
import '../../../routes/routes.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authenticationRepository =
    Provider.of<AuthenticationRepository>(context, listen: false);
    return Scaffold(
      body: Center(
        child: TextButton(
            onPressed: () async {
              authenticationRepository.signOut();
              Navigator.pushReplacementNamed(context, Routes.singIn);
            },
            child: const Text('Sign out')),
      ),
    );
  }
}
