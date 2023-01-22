import '../../domain/models/user.dart';
import '../../domain/repositories/account_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountApi api;
  final SessionService _sessionService;

  AccountRepositoryImpl(this.api, this._sessionService);

  @override
  Future<User?> getUserData() async {
    final sessionId = await _sessionService.sessionId;
    return api.getAccount(sessionId ?? '');
  }
}
