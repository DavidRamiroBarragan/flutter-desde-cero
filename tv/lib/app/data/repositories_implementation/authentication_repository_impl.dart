import '../../domain/either/either.dart';
import '../../domain/failures/sign_in/sign_in_failures.dart';
import '../../domain/models/user/user.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../services/local/session_service.dart';
import '../services/remote/account_api.dart';
import '../services/remote/authentication_api.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationApi _authenticationApi;
  final SessionService _sessionService;
  final AccountApi _accountApi;

  AuthenticationRepositoryImpl({
    required sessionService,
    required authenticationApi,
    required accountApi,
  })  : _sessionService = sessionService,
        _authenticationApi = authenticationApi,
        _accountApi = accountApi;

  @override
  Future<bool> get isSignedIn async {
    final id = await _sessionService.sessionId;
    return id != null;
  }

  @override
  Future<Either<SignInFailure, User>> singIn(
    String username,
    String password,
  ) async {
    final requestTokenResult = await _authenticationApi.createRequestToken();

    return requestTokenResult.when(
        left: (failure) async => Either.left(failure),
        right: (requestToken) async {
          final loginResult = await _authenticationApi.createSessionWithLogin(
            username: username,
            password: password,
            requestToken: requestToken,
          );

          return loginResult.when(
            left: (failure) async {
              return Either.left(failure);
            },
            right: (requestToken) async {
              final sessionResult =
                  await _authenticationApi.createSession(requestToken);

              return sessionResult.when(
                left: (failure) async => Either.left(failure),
                right: (sessionId) async {
                  _sessionService.saveSessionId(sessionId);
                  final user = await _accountApi.getAccount(sessionId);

                  if (user == null) {
                    return Either.left(SignInFailure.unknown());
                  }
                  return Either.right(user);
                },
              );
            },
          );
        });
  }

  @override
  Future<void> signOut() async {
    await _sessionService.signOut();
  }
}
