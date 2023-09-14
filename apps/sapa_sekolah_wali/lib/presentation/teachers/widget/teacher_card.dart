import 'package:flutter/material.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
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
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SPCachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
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
