import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    this.onTap,
    this.title,
    this.isActive = false,
  }) : super(key: key);

  final VoidCallback? onTap;
  final String? title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (isActive) onTap!();
      },
      child: Container(
        height: 45,
        width: double.infinity,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xffFF9800) : Colors.grey[200],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            title ?? '',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
