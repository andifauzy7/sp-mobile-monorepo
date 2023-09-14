import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/model/payments_response_model.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({
    Key? key,
    required this.payment,
  }) : super(key: key);

  final PaymentModel payment;

  bool get isPaid => payment.paymentStatus == 'Lunas';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.paymentTitle ?? '',
                      style: SPTextStyles.text12W500303030,
                    ),
                    Text(
                      payment.studentName ?? '-',
                      style: SPTextStyles.text10W400B3B3B3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: isPaid ? SPColors.color6FCF97 : SPColors.colorEB5757,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text(
                  isPaid ? 'Lunas' : 'Belum Lunas',
                  style: SPTextStyles.text10W400WHITE,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            NumberFormat.currency(
              locale: 'id',
              decimalDigits: 0,
            ).format(
              payment.nominalTransfer,
            ),
            style: SPTextStyles.text12W500303030,
          ),
        ],
      ),
    );
  }
}
