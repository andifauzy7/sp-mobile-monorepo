import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardConsultation extends StatelessWidget {
  final String name, message, date;
  final TextStyle? detailStyle;
  const CardConsultation({
    super.key,
    required this.date,
    required this.name,
    required this.message,
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
            message,
            style: SPTextStyles.text12W400B3B3B3,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
