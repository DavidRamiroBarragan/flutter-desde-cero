import '../../../../domain/either/either.dart';
import '../../../../domain/failures/sign_in/sign_in_failures.dart';
import '../../../../domain/models/user/user.dart';
import '../../../../domain/repositories/authentication_repository.dart';
import '../../../global/state_notifier.dart';
import 'state/sign_in_state.dart';

class SignInController extends StateNotifier<SignInState> {
  final AuthenticationRepository authenticationRepository;

  SignInController(
    super.state, {
    required this.authenticationRepository,
  });

  void onUserNameChanged(String text) {
    onlyUpdate(state.copyWith(username: text.trim().toLowerCase()));
  }

  void onPasswordChanged(String text) {
    onlyUpdate(state.copyWith(password: text.replaceAll(' ', '')));
  }

  Future<Either<SignInFailure, User>> submit() async {
    state = state.copyWith(
      fetching: true,
    );
    final result = await authenticationRepository.singIn(
      state.username,
      state.password,
    );

    result.when(
      left: (_) {
        state = state.copyWith(
          fetching: false,
        );
      },
      right: (_) => null,
    );

    return result;
  }
}
