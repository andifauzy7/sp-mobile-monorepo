import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class TeacherCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  const TeacherCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: SPColors.colorC8A8DA.withOpacity(0.2),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorWidget: (_, __, ___) => const Icon(
                    Icons.image_not_supported,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            '$name\n',
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: SPTextStyles.text14W400303030,
          )
        ],
      ),
    );
  }
}
