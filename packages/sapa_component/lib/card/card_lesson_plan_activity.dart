import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardLessonPlanActivity extends StatelessWidget {
  final String subjectName;
  final String activities;
  final String planNotes;

  const CardLessonPlanActivity({
    super.key,
    required this.subjectName,
    required this.activities,
    required this.planNotes,
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
          Text(
            'Area Pengembangan',
            style: SPTextStyles.text12W400B3B3B3,
          ),
          Text(
            subjectName,
            style: SPTextStyles.text12W400303030,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Aktifitas',
            style: SPTextStyles.text12W400B3B3B3,
          ),
          Text(
            activities,
            style: SPTextStyles.text12W400303030,
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            'Keterangan',
            style: SPTextStyles.text12W400B3B3B3,
          ),
          Text(
            planNotes.isEmpty ? '-' : planNotes,
            style: SPTextStyles.text12W400303030,
          ),
        ],
      ),
    );
  }
}
