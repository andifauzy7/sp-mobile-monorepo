import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class SPDialog {
  static Future showDefaultLoading(BuildContext context) async {
    return await showDialog(
      barrierColor: SPColors.colorFAFAFA.withOpacity(0.6),
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20.0),
            ),
          ),
          child: WillPopScope(
            onWillPop: () => Future.value(false),
            child: Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future showDefault(
    BuildContext context, {
    required List<Widget> children,
  }) async =>
      await showDialog(
        barrierColor: SPColors.colorFAFAFA.withOpacity(0.6),
        context: context,
        builder: (_) {
          return Dialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(
                16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: children,
              ),
            ),
          );
        },
      );

  static Future showSuccess(
    BuildContext context, {
    required String message,
  }) async =>
      await SPDialog.showDefault(
        context,
        children: [
          Center(
            child: Image.asset(
              Assets.images.imageSuccess.path,
              height: 150,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: SPTextStyles.text14W400636363,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SPElevatedButton(
              text: 'Kembali',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      );

  static Future showFailure(
    BuildContext context, {
    required String message,
  }) async =>
      await SPDialog.showDefault(
        context,
        children: [
          Center(
            child: Image.asset(
              Assets.images.imageFailure.path,
              height: 150,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: SPTextStyles.text14W400636363,
          ),
          const SizedBox(
            height: 16,
          ),
          Center(
            child: SPElevatedButton(
              text: 'Kembali',
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      );
}
