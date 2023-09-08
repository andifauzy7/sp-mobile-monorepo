import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffe16cb3).withOpacity(0.2),
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
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name\n',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Guru',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              const SizedBox(width: 2),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 14,
              )
            ],
          )
        ],
      ),
    );
  }
}
