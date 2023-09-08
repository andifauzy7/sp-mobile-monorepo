import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  const ActivityCard({
    Key? key,
    this.width,
    this.title,
    this.icons,
    this.subtitle,
    this.backgroundColor = Colors.greenAccent,
    this.onTap,
  }) : super(key: key);

  final double? width;
  final String? title;
  final String? subtitle;
  final IconData? icons;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: backgroundColor, borderRadius: BorderRadius.circular(15)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icons, color: Colors.white),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    title ?? '',
                    style: const TextStyle(color: Colors.white),
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              subtitle ?? '',
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }
}
