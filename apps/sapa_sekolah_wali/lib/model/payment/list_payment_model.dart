class ListPaymentModel {
  ListPaymentModel({
    this.paymentId,
    this.paymentTitle,
    this.studentName,
    this.nominalTransfer,
    this.paymentStatus,
  });

  final int? paymentId;
  final String? paymentTitle;
  final String? studentName;
  final int? nominalTransfer;
  final String? paymentStatus;

  static ListPaymentModel fromJson(Map<String?, dynamic> json) =>
      ListPaymentModel(
        paymentId: json["payment_id"],
        paymentTitle: json["payment_title"],
        studentName: json["student_name"],
        nominalTransfer: json["nominal_transfer"],
        paymentStatus: json["payment_status"],
      );
}
