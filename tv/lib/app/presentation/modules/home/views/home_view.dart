import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controller/session_controller.dart';
import '../../../routes/routes.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final SessionController sessionController = Provider.of(context);
    final user = sessionController.state!;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user.avatarPath != null)
              Image.network(
                  'https://image.tmdb.org/t/p/w500/${user.avatarPath}'),
            Text(
              user.username,
              style: const TextStyle(fontSize: 20),
            ),
            TextButton(
                onPressed: () async {
                  await sessionController.signOut();
                  if (mounted) {
                    Navigator.pushReplacementNamed(context, Routes.singIn);
                  }
                },
                child: const Text('Sign out')),
          ],
        ),
      ),
    );
  }
}
