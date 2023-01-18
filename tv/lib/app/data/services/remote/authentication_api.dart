

import '../../../domain/either.dart';
import '../../../domain/enums.dart';
import '../../http/http.dart';

class AuthenticationApi {
  final Http _http;

  AuthenticationApi(this._http);

  Future<Either<SignInFailure, String>> createRequestToken() async {
    final result = await _http.request(
      '/authentication/token/new',
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
    );

    return result.when(_handleFailure, _handleSuccess);
  }

  Future<Either<SignInFailure, String>> createSessionWithLogin({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    final result = await _http.request(
      '/authentication/token/validate_with_login',
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['request_token'] as String;
      },
      httpMethod: HttpMethod.post,
      body: {
        'username': username,
        'password': password,
        'request_token': requestToken
      },
    );

    return result.when(_handleFailure, _handleSuccess);
  }

  Future<Either<SignInFailure, String>> createSession(
      String requestToken) async {
    final result = await _http.request(
      '/authentication/session/new',
      httpMethod: HttpMethod.post,
      body: {'request_token': requestToken},
      onSuccess: (responseBody) {
        final json = responseBody as Map;
        return json['session_id'] as String;
      },
    );

    return result.when(_handleFailure, _handleSuccess);
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

  Either<SignInFailure, String> _handleSuccess(String request) =>
      Either.right(request);
}
