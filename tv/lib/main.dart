import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/services/local/session_service.dart';
import 'app/data/services/remote/account_api.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'app/my_app.dart';
import 'app/presentation/controller/session_controller.dart';

void main() {
  final Http http = Http(
    baseUrl: 'https://api.themoviedb.org/3',
    apiKey: '515f378a95ecec04875b1d0cefac12df',
    client: Client(),
  );
  final SessionService sessionService = SessionService(
    const FlutterSecureStorage(),
  );
  final AccountApi accountApi = AccountApi(http);

  runApp(MultiProvider(
    providers: [
      Provider<AccountRepository>(
        create: (_) => AccountRepositoryImpl(accountApi, sessionService),
      ),
      Provider<ConnectivityRepository>(
        create: (__) => ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        ),
      ),
      Provider<AuthenticationRepository>(
        create: (___) => AuthenticationRepositoryImpl(
          sessionService: sessionService,
          authenticationApi: AuthenticationApi(http),
          accountApi: accountApi,
        ),
      ),
      ChangeNotifierProvider<SessionController>(
        create: (_) => SessionController(),
      )
    ],
    child: const MyApp(),
  ));
}
