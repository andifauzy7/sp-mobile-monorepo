import 'package:flutter/material.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class NewsCard extends StatelessWidget {
  final String? imageUrl;
  final String? newsTitle;
  const NewsCard({
    super.key,
    this.imageUrl,
    this.newsTitle,
  });

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
            child: SPCachedNetworkImage(
              imageUrl: imageUrl ?? '',
              width: double.infinity,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            newsTitle ?? '-',
            style: SPTextStyles.text10W400808080,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          /*
          Text(
            news ?? '-',
            style: SPTextStyles.text12W400303030,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),*/
        ],
      ),
    );
  }
}
