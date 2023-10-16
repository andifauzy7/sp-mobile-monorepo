import 'package:flutter/material.dart';
import 'package:sapa_component/card/card_menu.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onPresence,
      onPermit,
      onLessonPlan,
      onReport,
      onConsultation;
  const MenuPage({
    super.key,
    required this.onPresence,
    required this.onPermit,
    required this.onLessonPlan,
    required this.onReport,
    required this.onConsultation,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: SPColors.colorFAFAFA,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Center(
              child: Text(
                'Menu',
                style: SPTextStyles.text18W400303030,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: GridView.count(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                primary: false,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                crossAxisCount: 2,
                children: <Widget>[
                  GestureDetector(
                    onTap: onPresence,
                    child: CardMenu(
                      title: 'Absensi',
                      description: 'Absensi Siswa',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuAttendance.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onPermit,
                    child: CardMenu(
                      title: 'Izin Murid',
                      description: 'Memberikan Izin\nKepada Murid',
                      imageUrl: Assets.images.menuPermission.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onLessonPlan,
                    child: CardMenu(
                      title: 'Lesson Plan',
                      description: 'Buat Plan',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuLessonPlan.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onReport,
                    child: CardMenu(
                      title: 'Laporan',
                      description: 'Berisi Laporan\nPeriodik',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuReport.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onConsultation,
                    child: CardMenu(
                      title: 'Konsultasi',
                      description: 'Konsultasi\nOrang Tua',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuConsultation.path,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
