import 'package:chat/data/model/auth/auth_model.dart';
import 'package:chat/data/repositories/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({required final username, required final password}) async {
    emit(AuthLoading());
    try {
      final response = await AuthRepository.login(username, password);
      emit(AuthAuthenticated(auth: response));
    } catch (e) {
      if (e is DioException) {
        emit(AuthError(
            message: e.response?.data['message'] ?? "An error occurred"));
        return;
      }
      emit(AuthError(message: e.toString()));
    }
  }

  void signUp({required final username, required final password}) async {
    emit(AuthLoading());
    try {
      final response = await AuthRepository.register(username, password);
      emit(AuthAuthenticated(auth: response));
    } catch (e) {
      if (e is DioException) {
        emit(AuthError(
            message: e.response?.data['message'] ?? "An error occurred"));
        return;
      }
      emit(AuthError(message: e.toString()));
    }
  }

  void logOut() {
    emit(AuthInitial());
  }
}
