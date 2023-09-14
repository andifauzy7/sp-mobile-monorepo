import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';

class CardStudent extends StatelessWidget {
  final String studentName;
  const CardStudent({super.key, required this.studentName});

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
            studentName,
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
