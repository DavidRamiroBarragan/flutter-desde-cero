import '../../domain/models/user.dart';
import '../../domain/repositories/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  @override
  Future<User?> getUserData() {
    return Future.value(User());
  }
}