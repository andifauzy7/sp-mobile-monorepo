import 'package:flutter/material.dart';

showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      child: Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Center(
              child: CircularProgressIndicator(
                color: Color(0xff4CAF50),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
