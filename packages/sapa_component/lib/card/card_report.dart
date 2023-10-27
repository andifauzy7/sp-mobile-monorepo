import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';

class CardReport extends StatelessWidget {
  final String reportDate;
  const CardReport({super.key, required this.reportDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            DateFormat('EEEE, d MMMM y', 'id_ID').format(
              DateTime.parse(reportDate),
            ),
            style: SPTextStyles.text12W400303030,
          ),
          SvgPicture.asset(
            SPAssets.icon.arrowRight.path,
            package: spComponentPackage,
          ),
        ],
      ),
    );
  }
}
