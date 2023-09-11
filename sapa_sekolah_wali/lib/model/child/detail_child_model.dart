class DetailChildModel {
  DetailChildModel({
    this.studentName,
    this.nipd,
    this.nisn,
    this.gender,
    this.tempatLahir,
    this.tanggalLahir,
    this.nik,
    this.religion,
    this.address,
    this.studentPhoto,
  });

  final String? studentName;
  final String? nipd;
  final int? nisn;
  final String? gender;
  final String? tempatLahir;
  final String? tanggalLahir;
  final String? nik;
  final String? religion;
  final String? address;
  final String? studentPhoto;

  static DetailChildModel fromJson(Map<String?, dynamic> json) =>
      DetailChildModel(
        studentName: json["student_name"],
        nipd: json["nipd"],
        nisn: json["nisn"],
        gender: json["gender"],
        tempatLahir: json["tempat_lahir"],
        tanggalLahir: json["tanggal_lahir"],
        nik: json["nik"],
        religion: json["religion"],
        address: json["address"],
        studentPhoto: json["student_photo"],
      );
}
