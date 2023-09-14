class PaymentsResponseModel {
  bool? success;
  String? message;
  List<PaymentModel>? data;

  PaymentsResponseModel({this.success, this.message, this.data});

  PaymentsResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentModel>[];
      json['data'].forEach((v) {
        data!.add(PaymentModel.fromJson(v));
      });
    }
  }
}

class PaymentModel {
  PaymentModel({
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

  static PaymentModel fromJson(Map<String?, dynamic> json) => PaymentModel(
        paymentId: json["payment_id"],
        paymentTitle: json["payment_title"],
        studentName: json["student_name"],
        nominalTransfer: json["nominal_transfer"],
        paymentStatus: json["payment_status"],
      );
}
