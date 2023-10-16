import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/form/sp_dropdown_field.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';

class ConsultationAddPage extends StatelessWidget {
  const ConsultationAddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ConsultationAddPageBody();
  }
}

class _ConsultationAddPageBody extends StatefulWidget {
  const _ConsultationAddPageBody();

  @override
  State<_ConsultationAddPageBody> createState() =>
      __ConsultationAddPageBodyState();
}

class __ConsultationAddPageBodyState extends State<_ConsultationAddPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.colorFAFAFA,
      body: SPContainerImage(
        imageUrl: SPAssets.images.circleBackground.path,
        package: spComponentPackage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SPAppBar(title: 'Konsultasi'),
                        const SizedBox(height: 24),
                        Text(
                          'Konsultasi pada Guru',
                          style: SPTextStyles.text16W400303030,
                        ),
                        const SizedBox(height: 20),
                        SPDropdownField(
                          items: const ['Test 1'],
                          hintText: 'Pilih Murid',
                          suffix: SvgPicture.asset(
                            SPAssets.icon.arrowDown.path,
                            package: spComponentPackage,
                          ),
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 16),
                        SPDropdownField(
                          items: const ['Test 2'],
                          hintText: 'Pilih Guru',
                          suffix: SvgPicture.asset(
                            SPAssets.icon.arrowDown.path,
                            package: spComponentPackage,
                          ),
                          onChanged: (value) {},
                        ),
                        const SizedBox(height: 16),
                        SPTextField(
                          hintText: 'Tambah pesan',
                          maxLines: 4,
                          onChanged: (value) => {},
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 16, top: 12),
                  child: SPElevatedButton(
                    type: SPElevatedButtonType.primary,
                    onPressed: () => {},
                    text: 'Submit',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
