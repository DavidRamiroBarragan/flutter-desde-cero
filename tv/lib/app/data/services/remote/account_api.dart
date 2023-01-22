import '../../../domain/models/user.dart';
import '../../http/http.dart';

class AccountApi {
  final Http _http;

  AccountApi(this._http);

  Future<User?> getAccount(String sessionId) async {
    final result = await _http.request('/account', queryParameters: {
      'session_id': sessionId,
    }, onSuccess: (json) {
      return User(
        id: json['id'],
        username: json['username'],
      );
    });

    return result.when((_) => null, (user) => user);
  }
}
