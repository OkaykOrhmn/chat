class Routes {
  static const String BASE_URL = 'http://10.0.2.2:3000/api';

  // Auth
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String me = '/auth/me';

  //User
  static const String status = '/user/status';
  static const String statuses = '/user/statuses';
  static const String ghostMode = '/user/ghost';
}
