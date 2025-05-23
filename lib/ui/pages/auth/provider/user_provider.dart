import 'package:chat/data/model/auth/me_model.dart';
import 'package:chat/data/repositories/auth_repository.dart';
import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat/data/enum/state_handler.dart';

class UserProvider with ChangeNotifier {
  final bool _isLoggedIn = AuthTokenStorage.getToken().isNotEmpty;
  bool get isLoggedIn => _isLoggedIn;

  MeModel? _userData;
  MeModel get userData => _userData ?? MeModel();

  StateHandler userState = StateHandler.initial;

  void checkMyInformation() async {
    if (!isLoggedIn) {
      userState = StateHandler.loading;
      notifyListeners();
    }

    try {
      final response = await AuthRepository.getMyProfile();
      _userData = response;
      userState = StateHandler.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AuthTokenStorage.clearToken();
          notifyListeners();
        }
      }
      userState = StateHandler.error;
      notifyListeners();
    }
  }

  void changeUserData(final MeModel user) {
    _userData = user;
    notifyListeners();
  }
}
