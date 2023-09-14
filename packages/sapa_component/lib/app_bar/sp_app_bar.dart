import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class SPAppBar extends StatelessWidget {
  final String title;
  const SPAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SPIconButton(
          url: SPAssets.icon.arrowLeft.path,
          color: Theme.of(context).primaryColor,
          onTap: () => Navigator.pop(context),
        ),
        const SizedBox(width: 16),
        Text(
          title,
          style: SPTextStyles.text18W400303030,
        ),
      ],
    );
  }
}
