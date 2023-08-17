import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

enum SPElevatedButtonType {
  primary,
  disabled,
}

extension SPElevatedButtonExtension on SPElevatedButtonType {
  MaterialStateProperty<Color>? get backgroundColor {
    switch (this) {
      case SPElevatedButtonType.primary:
        return null;
      case SPElevatedButtonType.disabled:
        return MaterialStateProperty.all<Color>(
          Colors.black.withOpacity(0.03),
        );
    }
  }
}

class SPElevatedButton extends StatelessWidget {
  final SPElevatedButtonType type;
  final VoidCallback? onPressed;
  final String text;
  const SPElevatedButton({
    super.key,
    this.onPressed,
    required this.text,
    this.type = SPElevatedButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: type.backgroundColor,
        shadowColor: MaterialStateProperty.all<Color>(
          Colors.black.withOpacity(0.03),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          text,
          style: SPTextStyles.text12W400636363,
        ),
      ),
    );
  }
}
