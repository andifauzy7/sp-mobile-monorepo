import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void showErrorDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/others/lottie_error.json',
                height: 125,
                width: 125,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 8),
              Text(
                message,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                'Please report this error to developers and attach the screenshoot',
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    },
  );
}
