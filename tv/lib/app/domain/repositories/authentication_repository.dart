

import '../models/user.dart';

abstract class Authenticationrepository {
  Future<bool> get isSignedIn;
  Future<User?> getUserData();
}