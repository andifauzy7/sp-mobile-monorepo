class DetailPaymentModel {
  DetailPaymentModel({
    this.paymentTitle,
    this.paymentStart,
    this.dueDate,
    this.nominalTransfer,
    this.virtualAccount,
    this.paymentStatus,
    this.paidDate,
    this.bankName,
  });

  final String? paymentTitle;
  final String? paymentStart;
  final String? dueDate;
  final int? nominalTransfer;
  final String? virtualAccount;
  final String? paymentStatus;
  final String? bankName;
  final DateTime? paidDate;

  static DetailPaymentModel fromJson(Map<String?, dynamic> json) =>
      DetailPaymentModel(
          paymentTitle: json["payment_title"],
          paymentStart: json["payment_start"],
          dueDate: json["due_date"],
          nominalTransfer: json["nominal_transfer"],
          virtualAccount: json["virtual_account"],
          paymentStatus: json["payment_status"],
          paidDate: json["paid_date"] == null
              ? null
              : DateTime.parse(json["paid_date"]),
          bankName: json["bank_name"]);
}
