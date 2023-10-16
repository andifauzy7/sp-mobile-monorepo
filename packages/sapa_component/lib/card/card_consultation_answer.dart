import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardConsultationAnswer extends StatelessWidget {
  final String message;
  const CardConsultationAnswer({
    super.key,
    required this.message,
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
          Text(
            'Tanggapan',
            style: SPTextStyles.text14W400303030,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            message,
            style: SPTextStyles.text12W400B3B3B3,
          ),
        ],
      ),
    );
  }
}
