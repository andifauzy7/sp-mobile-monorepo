class PaymentDetailResponseModel {
  bool? success;
  String? message;
  List<PaymentDetailModel>? data;

  PaymentDetailResponseModel({this.success, this.message, this.data});

  PaymentDetailResponseModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaymentDetailModel>[];
      json['data'].forEach((v) {
        data!.add(PaymentDetailModel.fromJson(v));
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

class PaymentDetailModel {
  String? paymentTitle;
  String? paymentStart;
  String? dueDate;
  int? nominalTransfer;
  String? virtualAccount;
  String? paymentStatus;
  String? paidDate;
  String? bankName;

  PaymentDetailModel(
      {this.paymentTitle,
      this.paymentStart,
      this.dueDate,
      this.nominalTransfer,
      this.virtualAccount,
      this.paymentStatus,
      this.paidDate,
      this.bankName});

  PaymentDetailModel.fromJson(Map<String, dynamic> json) {
    paymentTitle = json['payment_title'];
    paymentStart = json['payment_start'];
    dueDate = json['due_date'];
    nominalTransfer = json['nominal_transfer'];
    virtualAccount = json['virtual_account'];
    paymentStatus = json['payment_status'];
    paidDate = json['paid_date'];
    bankName = json['bank_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['payment_title'] = paymentTitle;
    data['payment_start'] = paymentStart;
    data['due_date'] = dueDate;
    data['nominal_transfer'] = nominalTransfer;
    data['virtual_account'] = virtualAccount;
    data['payment_status'] = paymentStatus;
    data['paid_date'] = paidDate;
    data['bank_name'] = bankName;
    return data;
  }
}
