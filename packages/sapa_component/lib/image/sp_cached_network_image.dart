import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class SPCachedNetworkImage extends StatelessWidget {
  const SPCachedNetworkImage({
    Key? key,
    required this.width,
    this.height,
    required this.imageUrl,
    this.radius = 15,
  }) : super(key: key);

  final double radius;
  final double width;
  final double? height;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(radius + 2),
        ),
        border: Border.all(
          width: 1,
          color: Theme.of(context).primaryColor,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(radius),
        ),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.cover,
          errorWidget: (context, url, error) => Container(
            color: Theme.of(context).primaryColor.withOpacity(0.4),
            child: const Icon(
              Icons.broken_image_rounded,
              color: Colors.white,
            ),
          ),
          placeholder: (context, url) => Container(
            padding: const EdgeInsets.all(16),
            color: Theme.of(context).primaryColor,
            child: const CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
