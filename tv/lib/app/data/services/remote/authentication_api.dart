import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';

class AuthenticationApi {
  final Client _client;
  final _apiKey = '515f378a95ecec04875b1d0cefac12df';
  final _baseUrl = 'https://api.themoviedb.org/3';

  AuthenticationApi(this._client);

  Future<String?> createRequestToken() async {
    try {
      final response = await _client.get(
        Uri.parse('$_baseUrl/authentication/token/new?api_key=$_apiKey'),
      );

      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(jsonDecode(response.body));
        return body['request_token'];
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    try {
      final response = await _client.post(
        Uri.parse(
            '$_baseUrl/authentication/token/validate_with_login?api_key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'password': password,
          'request_token': requestToken
        }),
      );
      switch (response.statusCode) {
        case 200:
          final json = Map<String, dynamic>.from(jsonDecode(response.body));
          return Either.right(json['request_token'] as String);
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    try {
      final response = await _client.post(
        Uri.parse('$_baseUrl/authentication/session/new?api_key=$_apiKey'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'request_token': requestToken}),
      );
      switch (response.statusCode) {
        case 200:
          final json = Map<String, dynamic>.from(jsonDecode(response.body));
          return Either.right(json['session_id'] as String);
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    } catch (e) {
      if (e is SocketException) {
        return Either.left(SignInFailure.network);
      }
      return Either.left(SignInFailure.unknown);
    }
  }
}
