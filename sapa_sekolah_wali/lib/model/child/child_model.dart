class ChildModel {
  ChildModel({
    this.studentId,
    this.studentName,
  });

  final int? studentId;
  final String? studentName;

  static ChildModel fromMap(Map<String, dynamic> json) => ChildModel(
        studentId: json["student_id"],
        studentName: json["student_name"],
      );
}
