import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../domain/models/user.dart';
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
    var injector = Injector.of(context);
    final connectivityRepository = injector.connectivityRepository;
    final hasInternet = await connectivityRepository.hasInternet;

    if (hasInternet) {
      final authRepository = injector.authenticationRepository;
      if (await authRepository.isSignedIn) {
        final User? user = await authRepository.getUserData();
        if (mounted) {
          if (user != null) {
            _goTo(Routes.home);
          } else {
            _goTo(Routes.singIn);
          }
        }
      } else if (mounted) {
        _goTo(Routes.singIn);
      }
    } else {}
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
