import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  void _createPermissionDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          Text(
            'Pemberian Izin Murid',
            style: SPTextStyles.text14W400303030,
          ),
          const SizedBox(height: 12),
          SPTextField(
            hintText: 'Tambah Murid',
            enabled: false,
            suffix: SvgPicture.asset(
              Assets.icon.addSquare.path,
            ),
          ),
          const SizedBox(height: 10),
          SPTextField(
            hintText: 'Tipe Izin',
            enabled: false,
            suffix: SvgPicture.asset(
              Assets.icon.addSquare.path,
            ),
          ),
          const SizedBox(height: 10),
          SPTextField(
            hintText: '05/07/23',
            enabled: false,
            suffix: SvgPicture.asset(
              Assets.icon.calendarPicker.path,
            ),
          ),
          const SizedBox(height: 10),
          const SPTextField(
            hintText: 'Tambah keterangan',
            maxLines: 4,
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SPElevatedButton(
              text: 'Submit',
              onPressed: () {},
            ),
          ),
        ],
      );

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
                      'Izin Siswa',
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
                                  'Data Izin Siswa',
                                  style: SPTextStyles.text16W400303030,
                                ),
                                Text(
                                  'View Detail',
                                  style: SPTextStyles.text12W400B3B3B3,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(15),
                                  ),
                                  child: SizedBox(
                                    width: 40,
                                    height: 40,
                                    child: Image.network(
                                      'https://www.timeshighereducation.com/sites/default/files/styles/article_teaser/public/shutterstock_508251865_resize.jpg?itok=4R835hL_',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Dani Carvajal',
                                        style: SPTextStyles.text14W400303030,
                                      ),
                                      Text(
                                        'Siswa, Kelas 7B',
                                        style: SPTextStyles.text10W400B3B3B3,
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Sakit',
                                      style: SPTextStyles.text12W400303030,
                                    ),
                                    Text(
                                      '10 Aug 2023',
                                      style: SPTextStyles.text10W400B3B3B3,
                                    ),
                                  ],
                                ),
                              ],
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
                SizedBox(
                  width: double.infinity,
                  child: SPElevatedButton(
                    text: 'Tambah Data Izin',
                    onPressed: () => _createPermissionDialog(context),
                  ),
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
}
