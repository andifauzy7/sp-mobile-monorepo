import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

enum CardConsultationAnswerPov { teacher, parent }

class CardConsultationAnswer extends StatelessWidget {
  final CardConsultationAnswerPov pov;
  final String sender;
  final String message;
  const CardConsultationAnswer({
    super.key,
    required this.pov,
    required this.sender,
    required this.message,
  });

  Widget _renderLeftPadding() {
    if (pov == CardConsultationAnswerPov.parent) {
      if (sender == 'teacher') {
        return const SizedBox.shrink();
      } else {
        return const Spacer(flex: 1);
      }
    } else {
      // POV Teacher
      if (sender == 'teacher') {
        return const Spacer(flex: 1);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  Widget _renderRightPadding() {
    if (pov == CardConsultationAnswerPov.parent) {
      if (sender != 'teacher') {
        return const SizedBox.shrink();
      } else {
        return const Spacer(flex: 1);
      }
    } else {
      // POV Teacher
      if (sender != 'teacher') {
        return const Spacer(flex: 1);
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _renderLeftPadding(),
        Expanded(
          flex: 4,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.all(
                Radius.circular(16),
              ),
              boxShadow: SPShadow.shadowGrey,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tanggapan ${(sender == "teacher" ? "Guru" : "Orangtua")}',
                  style: SPTextStyles.text14W400303030,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  message,
                  style: SPTextStyles.text12W400B3B3B3,
                ),
              ],
            ),
          ),
        ),
        _renderRightPadding(),
      ],
    );
  }
}
