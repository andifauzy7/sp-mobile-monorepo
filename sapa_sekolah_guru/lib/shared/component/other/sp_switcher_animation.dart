import 'package:flutter/material.dart';

class SPSwitcherAnimation extends StatelessWidget {
  final Widget child;
  const SPSwitcherAnimation({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: child,
    );
  }
}
