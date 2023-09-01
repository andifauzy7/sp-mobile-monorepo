import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';

class SPCachedNetworkImage extends StatelessWidget {
  const SPCachedNetworkImage({
    Key? key,
    required this.width,
    required this.height,
    required this.imageUrl,
    this.radius = 15,
  }) : super(key: key);

  final double radius;
  final double width;
  final double height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(radius),
      ),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(radius),
          ),
          border: Border.all(
            width: 2,
            color: SPColors.colorFFE5C0,
          ),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            color: SPColors.colorFFE5C0,
            child: const Icon(
              Icons.broken_image_rounded,
              color: Colors.white,
            ),
          ),
          placeholder: (context, url) => Container(
            padding: const EdgeInsets.all(16),
            color: SPColors.colorFFE5C0,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
