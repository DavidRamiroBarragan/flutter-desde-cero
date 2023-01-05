import 'package:flutter/widgets.dart';
import 'routes.dart';

import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/home/views/home_view.dart';

Map<String, Widget Function(BuildContext)> get appRoutes {
  return {
    Routes.splash: (context) => const SplashView(),
    Routes.singIn: (context) => const SignInView(),
    Routes.home: (context) => const HomeView(),
  };
}