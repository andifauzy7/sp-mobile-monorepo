import 'package:flutter/material.dart';

class SPContainerImage extends StatelessWidget {
  final String imageUrl;
  final Widget child;
  const SPContainerImage({
    super.key,
    required this.imageUrl,
    this.child = const SizedBox.shrink(),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imageUrl,
          ),
        ),
      ),
      child: child,
    );
  }
}
