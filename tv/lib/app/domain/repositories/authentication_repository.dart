import '../either.dart';
import '../enums.dart';
import '../models/user.dart';

abstract class AuthenticationRepository {
  Future<bool> get isSignedIn;

  Future<Either<SignInFailure, User>> singIn(String username, String password);

  Future<void> signOut();
}
