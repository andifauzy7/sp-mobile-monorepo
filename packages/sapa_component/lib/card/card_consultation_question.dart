import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardConsultationQuestion extends StatelessWidget {
  final String name, date, message;
  const CardConsultationQuestion({
    super.key,
    required this.name,
    required this.date,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: SPTextStyles.text14W400303030,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
              Text(
                DateFormat('d MMMM, y', 'id_ID').format(
                  DateTime.parse(date),
                ),
                style: SPTextStyles.text12W400B3B3B3,
              ),
            ],
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
