import 'package:flutter/material.dart';

class TagCard extends StatelessWidget {
  const TagCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Hari Ini',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
      ),
    );
  }
}
