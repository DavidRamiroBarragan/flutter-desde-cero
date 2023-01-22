import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _key = 'sessionId';

class SessionService {
  final FlutterSecureStorage _secureStorage;

  SessionService(this._secureStorage);

  Future<String?> get sessionId async {
    return await _secureStorage.read(key: _key);
  }

  Future<void> saveSessionId(String sessionId) {
    return _secureStorage.write(key: _key, value: sessionId);
  }

  Future<void> signOut() async {
    await _secureStorage.delete(key: _key);
  }
}
