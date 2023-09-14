import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
                image: DecorationImage(
                  image: CachedNetworkImageProvider(
                    'https://images.template.net/wp-content/uploads/2015/12/20071035/Free-Newspaper-Template.jpeg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Keperluan Sekolah',
            style: SPTextStyles.text10W400808080,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            'Pembayaran Juli',
            style: SPTextStyles.text12W400303030,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
