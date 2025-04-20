class ResponseModel<T> {
  bool? success;
  String? message;
  T? data;

  ResponseModel({this.success, this.message, this.data});

  ResponseModel.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      if (this.data is Map<String, dynamic>) {
        data['data'] = this.data;
      } else {
        data['data'] = (this.data as dynamic).toJson();
      }
    }
    return data;
  }
}
