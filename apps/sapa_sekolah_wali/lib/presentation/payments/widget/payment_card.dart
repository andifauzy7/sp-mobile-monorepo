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
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: SPShadow.shadowGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isPaid ? SPColors.color6FCF97 : SPColors.colorEB5757,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: Icon(
                    isPaid ? Icons.check : Icons.close,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        payment.paymentTitle ?? '',
                        style: SPTextStyles.text12W400303030,
                      ),
                      Text(
                        payment.studentName ?? '',
                        style: SPTextStyles.text14W400303030,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Total Tagihan',
                    style: SPTextStyles.text14W400303030,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  NumberFormat.currency(
                    locale: 'id',
                    decimalDigits: 0,
                  ).format(
                    payment.nominalTransfer,
                  ),
                  style: SPTextStyles.text16W500303030,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
