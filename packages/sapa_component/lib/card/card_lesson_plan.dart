import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardLessonPlan extends StatelessWidget {
  final String studentName;
  final String date;
  final String lessons;
  final TextStyle? detailStyle;
  const CardLessonPlan({
    super.key,
    required this.studentName,
    required this.date,
    required this.lessons,
    this.detailStyle,
  });

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
                      studentName,
                      style: SPTextStyles.text12W500303030,
                    ),
                    Text(
                      DateFormat('EEEE d MMMM, y', 'id_ID').format(
                        DateTime.parse(date),
                      ),
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
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Lihat Detail',
                  style: detailStyle ?? SPTextStyles.text8W400B3B3B3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            lessons,
            style: SPTextStyles.text12W500303030,
          ),
        ],
      ),
    );
  }
}
