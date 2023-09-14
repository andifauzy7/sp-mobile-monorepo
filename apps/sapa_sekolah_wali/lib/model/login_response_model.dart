class LoginResponseModel {
  bool? success;
  String? message;
  Data? data;

  LoginResponseModel({this.success, this.message, this.data});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = (json['data'] != null && json['data'].isNotEmpty)
        ? Data.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? nama;
  String? token;
  String? userId;

  Data({this.nama, this.token, this.userId});

  Data.fromJson(Map<String, dynamic> json) {
    nama = json['nama'];
    token = json['token'];
    userId = json['user_id'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nama'] = nama;
    data['token'] = token;
    data['user_id'] = userId;
    return data;
  }
}
