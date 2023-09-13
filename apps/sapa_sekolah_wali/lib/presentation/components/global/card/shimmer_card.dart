import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerCard extends StatelessWidget {
  const ShimmerCard({Key? key, this.height = 50}) : super(key: key);

  final double height;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: Container(
        height: height,
        width: double.infinity,
        margin: const EdgeInsets.only(
          bottom: 12,
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.grey[300]),
      ),
    );
  }
}
