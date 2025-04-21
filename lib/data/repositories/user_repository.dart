import 'package:chat/core/api/api.dart';
import 'package:chat/core/api/response.dart';
import 'package:chat/core/api/routes.dart';

class UserRepository {
  static Future<Map<String, String>> getStatuses() async {
    try {
      final response = await Api().dio.get(Routes.statuses);
      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        return data
            .map((key, value) => MapEntry(key.toString(), value.toString()));
      } else {
        throw Exception(
            {'message': 'Failed to load statuses', 'response': response});
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> changeStatus(final String statusId) async {
    try {
      final response = await Api().dio.put(Routes.status, data: {
        'status': statusId,
      });
      if (response.statusCode == 200) {
        return ResponseModel<String>.fromJson(
            response.data, (data) => data as String).data!;
      } else {
        throw Exception(
            {'message': 'Failed to change status', 'response': response});
      }
    } catch (e) {
      rethrow;
    }
  }
}
