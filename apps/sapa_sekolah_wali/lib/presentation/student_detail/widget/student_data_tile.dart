import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class StudentDataTile extends StatelessWidget {
  final String label;
  final String? value;
  const StudentDataTile({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: SPColors.colorF0F0F0,
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: SPTextStyles.text10W400B3B3B3,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              (value != null && (value?.isNotEmpty ?? false)) ? value! : '-',
              style: SPTextStyles.text10W400333333,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
