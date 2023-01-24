import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/user/user.dart';
import '../../../../domain/repositories/account_repository.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../../domain/repositories/connectivity_repository.dart';
import '../../../controller/session_controller.dart';
import '../../../routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _init();
    });
  }

  Future<void> _init() async {
    final ConnectivityRepository connectivityRepository = context.read();
    final AuthenticationRepository authRepository = context.read();
    final AccountRepository accountRepository = context.read();
    final SessionController sessionController = context.read();

    final hasInternet = await connectivityRepository.hasInternet;

    if (!hasInternet) {
      return _goTo(Routes.singIn);
    }
    final isSignIn = await authRepository.isSignedIn;

    if (!isSignIn) {
      _goTo(Routes.singIn);
    }

    final User? user = await accountRepository.getUserData();

    if (user != null) {
      sessionController.setUser(user);
      return _goTo(Routes.home);
    }

    return _goTo(Routes.singIn);
  }

  void _goTo(String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 80,
          height: 80,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
