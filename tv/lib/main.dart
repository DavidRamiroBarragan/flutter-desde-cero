import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'app/data/http/http.dart';
import 'app/data/repositories_implementation/account_repository_impl.dart';
import 'app/data/repositories_implementation/authentication_repository_impl.dart';
import 'app/data/repositories_implementation/connectivity_repository_impl.dart';
import 'app/data/services/remote/authentication_api.dart';
import 'app/data/services/remote/internet_checker.dart';
import 'app/domain/repositories/account_repository.dart';
import 'app/domain/repositories/authentication_repository.dart';
import 'app/domain/repositories/connectivity_repository.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;

import 'app/my_app.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      Provider<AccountRepository>(create: (_) => AccountRepositoryImpl()),
      Provider<ConnectivityRepository>(
        create: (__) => ConnectivityRepositoryImpl(
          Connectivity(),
          InternetChecker(),
        ),
      ),
      Provider<AuthenticationRepository>(
        create: (___) => AuthenticationRepositoryImpl(
          const FlutterSecureStorage(),
          AuthenticationApi(
            Http(
              baseUrl: 'https://api.themoviedb.org/3',
              apiKey: '515f378a95ecec04875b1d0cefac12df',
              client: http.Client(),
            ),
          ),
        ),
      ),
    ],
    child: const MyApp(),
  ));
}
