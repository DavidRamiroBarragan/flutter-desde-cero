import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

import '../../domain/either.dart';

class Http {
  final String _baseUrl;
  final String _apiKey;
  final Client _client;

  Http({
    required Client client,
    required String apiKey,
    required String baseUrl,
  })  : _client = client,
        _baseUrl = baseUrl,
        _apiKey = apiKey;

  Future<Either<HttpFailure, String>> request(String path,
      {HttpMethod httpMethod = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      bool useApiKey = true,
      Map<String, dynamic> body = const {}}) async {
    try {
      if (useApiKey) {
        queryParameters = {
          ...queryParameters,
          'api_key': _apiKey,
        };
      }
      late final Response response;
      Uri url = Uri.parse(
        path.startsWith('http') ? path : '$_baseUrl$path',
      );
      if (queryParameters.isNotEmpty) {
        url = url.replace(
          queryParameters: queryParameters,
        );
      }
      headers = {
        'Content-Type': 'application/json',
        ...headers,
      };

      final String parsedBody = jsonEncode(body);
      switch (httpMethod) {
        case HttpMethod.get:
          response = await _client.get(url);
          break;
        case HttpMethod.post:
          response = await _client.post(
            url,
            headers: headers,
            body: parsedBody,
          );
          break;
        case HttpMethod.patch:
          response = await _client.patch(
            url,
            headers: headers,
            body: parsedBody,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
            body: parsedBody,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(url, headers: headers, body: parsedBody);
          break;
      }

      final statusCode = response.statusCode;

      if (statusCode >= 200 && statusCode < 300) {
        return Either.right(response.body);
      }

      return Either.left(HttpFailure(statusCode: statusCode));
    } catch (e) {
      if (e is SocketException || e is ClientException) {
        return Either.left(HttpFailure(
          exception: NetworkException(),
        ));
      }

      return Either.left(HttpFailure(
        exception: e,
      ));
    }
  }
}

class HttpFailure {
  final int? statusCode;
  final Object? exception;

  HttpFailure({
    this.statusCode,
    this.exception,
  });
}

class NetworkException {}

enum HttpMethod { get, post, patch, delete, put }
