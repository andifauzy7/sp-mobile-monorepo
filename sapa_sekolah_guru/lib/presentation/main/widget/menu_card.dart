import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class MenuCard extends StatelessWidget {
  final String title;
  final String description;
  final String imageUrl;
  const MenuCard({
    super.key,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        color: Colors.white,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              imageUrl,
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
