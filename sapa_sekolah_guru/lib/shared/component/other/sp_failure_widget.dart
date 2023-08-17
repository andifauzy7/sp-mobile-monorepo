import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class SPFailureWidget extends StatelessWidget {
  final String message;
  const SPFailureWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const ClampingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: <Widget>[
              const Spacer(),
              Image.asset(
                Assets.images.imageFailure.path,
                height: 120,
                width: double.infinity,
              ),
              Text(
                message.isNotEmpty ? message : 'Oops, telah terjadi kesalahan',
                style: SPTextStyles.text12W400303030,
              ),
              const Spacer(),
            ],
          ),
        ),
      ],
    );
  }
}
