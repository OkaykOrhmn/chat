import 'package:chat/data/model/auth/me_model.dart';

class AuthModel {
  String? token;
  MeModel? user;

  AuthModel({this.token, this.user});

  AuthModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? MeModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
