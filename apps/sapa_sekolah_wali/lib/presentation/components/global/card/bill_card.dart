import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sapa_sekolah_wali/model/payment/list_payment_model.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';

class BillCard extends StatelessWidget {
  const BillCard({
    Key? key,
    this.model,
    required this.studentId,
  }) : super(key: key);

  final ListPaymentModel? model;
  final int studentId;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Map<String, String?> payload = {
          'payment_id': model?.paymentId.toString(),
          'student_id': studentId.toString(),
        };
        Navigator.pushNamed(context, RouteName.detailBill, arguments: payload);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              offset: const Offset(2, 2),
              color: Colors.grey[300]!,
              blurRadius: 5,
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                model?.paymentStatus == "Lunas"
                    ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'LUNAS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          'BELUM LUNAS',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xff4CAF50),
                    borderRadius: BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: const Icon(
                    Icons.check,
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
                        model?.paymentTitle ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        model?.studentName ?? '',
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
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
                const Expanded(
                  child: Text(
                    'Total Tagihan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xffFF9800),
                    ),
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
                    model?.nominalTransfer,
                  ),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
