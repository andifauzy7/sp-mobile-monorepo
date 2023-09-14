import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_colors.dart';

class SPShadow {
  static List<BoxShadow> shadowFAFAFA = [
    BoxShadow(
      color: SPColors.colorFAFAFA,
      spreadRadius: 8,
      blurRadius: 8,
      offset: const Offset(0, 0),
    ),
  ];

  static List<BoxShadow> shadowGrey = [
    BoxShadow(
      offset: const Offset(2, 2),
      color: Colors.grey[300]!,
      blurRadius: 5,
    )
  ];
}
