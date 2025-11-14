import 'package:books/features/Auth/data/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo repo;

  AuthCubit(this.repo) : super(AuthInitialState());

  /// Register user with email and password
  register(String email, String password) async {
    emit(AuthLoadingState());
    final result = await repo.registerUser(email, password);

    if (result == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(result));
    }
  }

  /// Login user with email and password
  login(String email, String password) async {
    emit(AuthLoadingState());
    final result = await repo.loginUser(email, password);

    if (result == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(result));
    }
  }

  /// Login user with google
  loginWithGoogle() async {
    emit(AuthLoadingState());
    final result = await repo.loginWithGoogle();
    if (result == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState(result));
    }
  }
}
