import 'package:chat/data/repositories/user_repository.dart';
import 'package:chat/data/storage/shared_preferences_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat/data/enum/state_handler.dart';

class StatusProvider with ChangeNotifier {
  Map<String, String>? _statuses;
  Map<String, String> get statuses => _statuses ?? {};

  StateHandler state = StateHandler.initial;

  void getAllStatuses() async {
    state = StateHandler.loading;
    notifyListeners();
    try {
      final response = await UserRepository.getStatuses();
      _statuses = response;
      state = StateHandler.loaded;
      notifyListeners();
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AuthTokenStorage.clearToken();
          notifyListeners();
        }
      }
      state = StateHandler.error;
      notifyListeners();
    }
  }

  Future<bool> changeStatus(String statusKey) async {
    state = StateHandler.loading;
    notifyListeners();
    try {
      await UserRepository.changeStatus(statusKey);
      state = StateHandler.loaded;
      notifyListeners();
      return true;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          AuthTokenStorage.clearToken();
          notifyListeners();
        }
      }
      state = StateHandler.error;
      notifyListeners();
      return false;
    }
  }
}
