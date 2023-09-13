class TeacherModel {
  final int? employeeId;
  final String? employeeName;
  final String? employeePhoto;

  TeacherModel({this.employeeId, this.employeeName, this.employeePhoto});

  static TeacherModel fromMap(Map<String, dynamic> json) => TeacherModel(
        employeeId: json['employee_id'],
        employeeName: json['employee_name'],
        employeePhoto: json['employee_photo'],
      );
}
