import 'package:chat/core/api/api.dart';
import 'package:chat/core/api/response.dart';
import 'package:chat/core/api/routes.dart';
import 'package:chat/data/model/auth/auth_model.dart';
import 'package:chat/data/model/auth/me_model.dart';

class AuthRepository {
  static Future<MeModel> getMyProfile() async {
    try {
      final response = await Api().dio.get(Routes.me);
      if (response.statusCode == 200) {
        return ResponseModel<MeModel>.fromJson(response.data, MeModel.fromJson)
            .data!;
      } else {
        throw Exception(
            {'message': 'Failed to load profile', 'response': response});
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<AuthModel> login(String username, String password) async {
    try {
      final response = await Api().dio.post(Routes.login,
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        return ResponseModel<AuthModel>.fromJson(
                response.data, AuthModel.fromJson)
            .data!;
      } else {
        throw Exception({'message': 'Failed to login', 'response': response});
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<AuthModel> register(String username, String password) async {
    try {
      final response = await Api().dio.post(Routes.register,
          data: {'username': username, 'password': password});
      if (response.statusCode == 200) {
        return ResponseModel<AuthModel>.fromJson(
                response.data, AuthModel.fromJson)
            .data!;
      } else {
        throw Exception(
            {'message': 'Failed to register', 'response': response});
      }
    } catch (e) {
      rethrow;
    }
  }
}
