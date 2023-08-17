import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class AddPlanningPage extends StatelessWidget {
  const AddPlanningPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.colorFAFAFA,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.lessonPlanBackground.path,
            ),
          ),
        ),
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
                        Row(
                          children: [
                            SPIconButton(
                              url: Assets.icon.arrowLeft.path,
                              onTap: () => Navigator.pop(context),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Text(
                              "Planning",
                              style: SPTextStyles.text16W400303030,
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Buat Planning Harian',
                          style: SPTextStyles.text16W400303030,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SPTextField(
                          hintText: 'Pilih Murid',
                          enabled: false,
                          suffix: SvgPicture.asset(
                            Assets.icon.arrowDown.path,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: SPTextField(
                                hintText: 'Pilih Jam',
                                enabled: false,
                                suffix: SvgPicture.asset(
                                  Assets.icon.timer.path,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: SPTextField(
                                hintText: 'Pilih Tanggal',
                                enabled: false,
                                suffix: SvgPicture.asset(
                                  Assets.icon.calendarPicker.path,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SPTextField(
                          hintText: 'Pilih Daftar Pelajaran',
                          enabled: false,
                          suffix: SvgPicture.asset(
                            Assets.icon.arrowDown.path,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        SPTextField(
                          hintText: 'Pilih Aktivitas',
                          enabled: false,
                          suffix: SvgPicture.asset(
                            Assets.icon.arrowDown.path,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const SPTextField(
                          hintText: 'Tambah keterangan',
                          maxLines: 4,
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(bottom: 16, top: 12),
                  child: SPElevatedButton(
                    onPressed: () => {},
                    text: 'Submit Planning',
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
