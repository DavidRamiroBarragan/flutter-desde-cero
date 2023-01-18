import 'dart:convert';

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
    );

    return result.when(_handleFailure, (responseBody) {
      final body = Map<String, dynamic>.from(jsonDecode(responseBody));
      return Either.right(body['request_token'] as String);
    });
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
        '/authentication/token/validate_with_login',
        httpMethod: HttpMethod.post,
        body: {
          'username': username,
          'password': password,
          'request_token': requestToken
        });

    return result.when(_handleFailure, (responseBody) {
      final body = Map<String, dynamic>.from(jsonDecode(responseBody));
      return Either.right(body['request_token'] as String);
    });
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request('/authentication/session/new',
        httpMethod: HttpMethod.post, body: {'request_token': requestToken});

    return result.when(_handleFailure, (responseBody) {
      final json = Map<String, dynamic>.from(jsonDecode(responseBody));
      return Either.right(json['session_id'] as String);
    });
  }

  Either<SignInFailure, String> _handleFailure(HttpFailure httpFailure) {
    if (httpFailure.statusCode != null) {
      switch (httpFailure.statusCode!) {
        case 401:
          return Either.left(SignInFailure.unauthorized);
        case 404:
          return Either.left(SignInFailure.notFound);
        default:
          return Either.left(SignInFailure.unknown);
      }
    }

    if (httpFailure.exception is NetworkException) {
      return Either.left(SignInFailure.network);
    }

    return Either.left(SignInFailure.unknown);
  }
}
