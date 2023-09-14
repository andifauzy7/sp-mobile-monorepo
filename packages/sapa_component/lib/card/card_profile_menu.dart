import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardProfileMenu extends StatelessWidget {
  final String label;
  final TextStyle? labelStyle;
  final String icon;
  const CardProfileMenu({
    super.key,
    required this.label,
    required this.icon,
    this.labelStyle,
  });

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
            label,
            style: labelStyle ?? SPTextStyles.text12W400303030,
          ),
          SvgPicture.asset(
            icon,
            package: 'sapa_component',
          )
        ],
      ),
    );
  }
}
