import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportDaily extends StatelessWidget {
  const ReportDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: SPColors.colorEAD2E0,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Work Habits',
                    style: SPTextStyles.text14W400WHITE,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Complete work in time',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: SPColors.colorE3E3E3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Quality of Work',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                color: SPColors.colorC7A7D9,
                padding: const EdgeInsets.all(8),
                child: Center(
                  child: Text(
                    'Needs to work on',
                    style: SPTextStyles.text14W400WHITE,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Complete work in time',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Divider(
                  color: SPColors.colorE3E3E3,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  'Quality of Work',
                  style: SPTextStyles.text12W400303030,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.icon.trueCheckbox.path,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Lorem Ipsum',
                      style: SPTextStyles.text12W400B3B3B3,
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Teacher Comments',
          style: SPTextStyles.text16W400303030,
        ),
        const SizedBox(height: 16),
        const SPTextField(
          hintText: 'Add comments',
          maxLines: 4,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SPElevatedButton(
                onPressed: () => {},
                text: 'Submit',
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
