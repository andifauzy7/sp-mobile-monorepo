import 'package:flutter/material.dart';

class SPContainerImage extends StatelessWidget {
  final String imageUrl;
  final String? package;
  final Widget child;
  const SPContainerImage({
    super.key,
    required this.imageUrl,
    this.child = const SizedBox.shrink(),
    this.package,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imageUrl,
            package: package,
          ),
        ),
      ),
      child: child,
    );
  }
}
