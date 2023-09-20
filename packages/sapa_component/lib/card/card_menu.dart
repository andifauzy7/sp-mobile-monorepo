import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class CardMenu extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  final String? package;
  const CardMenu({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
    this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
              package: package,
              width: 50,
              height: 50,
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              title,
              style: SPTextStyles.text14W400303030,
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: SPTextStyles.text10W400808080,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
