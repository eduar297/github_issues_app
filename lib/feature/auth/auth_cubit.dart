import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_issues_app/domain/auth/auth_repository.dart';
import 'package:github_issues_app/domain/auth/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;

  AuthCubit(this.authRepository) : super(Initial());

  Future<void> signIn(String value) async {
    try {
      emit(Loading());

      final result = await authRepository.getToken(value);
      final token = result.item1;
      final user = result.item2;
      final repos = result.item3;

      await authRepository.saveToken(token);

      emit(Authenticated(token, user, repos));
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> signOut() async {
    await authRepository.deleteToken();

    emit(Unauthenticated());
  }

  Future<void> checkToken() async {
    final token = await authRepository.readToken();
    if (token != null) {
      try {
        final result = await authRepository.getToken(token);
        final user = result.item2;
        final repos = result.item3;

        emit(Authenticated(token, user, repos));
      } catch (e) {
        emit(Unauthenticated());
      }
    } else {
      emit(Unauthenticated());
    }
  }
}
