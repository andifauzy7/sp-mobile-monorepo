import 'package:sapa_sekolah_wali/model/base_model.dart';

class LoginModel extends BaseModel {
  LoginModel({
    this.nama,
    this.token,
    this.userId,
  });

  final String? nama;
  final String? token;
  final String? userId;

  static LoginModel fromJson(Map<String, dynamic> json) => LoginModel(
        nama: json["nama"],
        token: json["token"],
        userId: json["user_id"],
      );
}
