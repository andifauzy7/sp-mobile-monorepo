import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class UpdateStudentPresencePage extends StatelessWidget {
  const UpdateStudentPresencePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      'Absensi Siswa',
                      style: SPTextStyles.text18W400303030,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      Text(
                        'Data Siswa',
                        style: SPTextStyles.text16W400303030,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Nama Guru',
                                  style: SPTextStyles.text14W400B3B3B3,
                                ),
                                Text(
                                  'Retna Putri',
                                  style: SPTextStyles.text14W400303030,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Kelas 7B',
                                  style: SPTextStyles.text14W400303030,
                                ),
                                Text(
                                  'Kelas Hari Ini',
                                  style: SPTextStyles.text14W400303030,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '25 Siswa Murid',
                                  style: SPTextStyles.text12W400B3B3B3,
                                ),
                                Text(
                                  'Bahasa Inggris',
                                  style: SPTextStyles.text12W400B3B3B3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(16),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    'Nama Murid',
                                    style: SPTextStyles.text10W400808080,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Keterangan',
                                    style: SPTextStyles.text10W400808080,
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    'Kehadiran',
                                    style: SPTextStyles.text10W400808080,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _renderRowPresence(
                              name: 'Andrean Primal Bala',
                              group: 'Kelas 7B',
                              label: 'Hadir',
                              presence: 1,
                            ),
                            const SizedBox(height: 8),
                            _renderRowPresence(
                              name: 'Abram Fernai Lantuary P.',
                              group: 'Kelas 7B',
                              label: 'Hadir',
                              presence: 1,
                            ),
                            const SizedBox(height: 8),
                            _renderRowPresence(
                              name: 'Cristiano Ronaldo',
                              group: 'Kelas 7B',
                              label: 'Belum Hadir',
                              presence: 2,
                            ),
                            const SizedBox(height: 8),
                            _renderRowPresence(
                              name: 'Karim Benzema',
                              group: 'Kelas 7B',
                              label: 'Hadir',
                              presence: 1,
                            ),
                            const SizedBox(height: 8),
                            _renderRowPresence(
                              name: 'Dani Carvajal',
                              group: 'Kelas 7B',
                              label: 'Tidak Hadir',
                              presence: 3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SPElevatedButton(
                        type: SPElevatedButtonType.secondary,
                        text: 'Batal',
                        onPressed: () {},
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: SPElevatedButton(
                        text: 'Submit',
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderRowPresence({
    required String name,
    required String group,
    required String label,
    required int presence,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: SPTextStyles.text10W400303030,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                group,
                style: SPTextStyles.text10W400B3B3B3,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Text(
            label,
            style: SPTextStyles.text10W400303030,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Expanded(
          flex: 1,
          child: presence == 1
              ? SvgPicture.asset(
                  Assets.icon.trueCheckbox.path,
                )
              : presence == 2
                  ? SvgPicture.asset(
                      Assets.icon.emptyCheckbox.path,
                    )
                  : SvgPicture.asset(
                      Assets.icon.falseCheckbox.path,
                    ),
        ),
      ],
    );
  }
}
