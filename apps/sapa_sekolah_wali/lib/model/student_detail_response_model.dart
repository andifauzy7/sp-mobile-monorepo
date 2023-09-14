class StudentDetailResponseModel {
  bool? success;
  String? message;
  List<StudentDetailModel>? data;

  StudentDetailResponseModel({this.success, this.message, this.data});

  StudentDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentDetailModel>[];
      json['data'].forEach((v) {
        data!.add(StudentDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class StudentDetailModel {
  String? studentName;
  String? nipd;
  String? nisn;
  String? gender;
  String? tempatLahir;
  String? tanggalLahir;
  String? nik;
  String? religion;
  String? address;
  String? studentPhoto;

  StudentDetailModel(
      {this.studentName,
      this.nipd,
      this.nisn,
      this.gender,
      this.tempatLahir,
      this.tanggalLahir,
      this.nik,
      this.religion,
      this.address,
      this.studentPhoto});

  StudentDetailModel.fromJson(Map<String, dynamic> json) {
    studentName = json['student_name'];
    nipd = json['nipd'].toString();
    nisn = json['nisn'].toString();
    gender = json['gender'];
    tempatLahir = json['tempat_lahir'];
    tanggalLahir = json['tanggal_lahir'];
    nik = json['nik'].toString();
    religion = json['religion'];
    address = json['address'];
    studentPhoto = json['student_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_name'] = studentName;
    data['nipd'] = nipd;
    data['nisn'] = nisn;
    data['gender'] = gender;
    data['tempat_lahir'] = tempatLahir;
    data['tanggal_lahir'] = tanggalLahir;
    data['nik'] = nik;
    data['religion'] = religion;
    data['address'] = address;
    data['student_photo'] = studentPhoto;
    return data;
  }
}
