import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_component/styles/sp_colors.dart';

class SPIconButton extends StatelessWidget {
  final Color? color;
  final String url;
  final VoidCallback? onTap;
  const SPIconButton({
    super.key,
    required this.url,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color ?? SPColors.colorFFE5C0,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: SvgPicture.asset(
          url,
          package: 'sapa_component',
        ),
      ),
    );
  }
}
