import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardLessonPlanHeader extends StatelessWidget {
  final String studentName;
  final String date;
  const CardLessonPlanHeader({
    super.key,
    required this.studentName,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            children: [
              Text(
                'Murid',
                style: SPTextStyles.text10W400B3B3B3,
              ),
              Text(
                'Tanggal',
                style: SPTextStyles.text10W400B3B3B3,
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  studentName,
                  style: SPTextStyles.text10W400303030,
                ),
              ),
              Text(
                DateFormat('EEEE d MMMM, y', 'id_ID').format(
                  DateTime.parse(date),
                ),
                style: SPTextStyles.text10W400303030,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
