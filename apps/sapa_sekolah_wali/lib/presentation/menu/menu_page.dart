import 'package:flutter/material.dart';
import 'package:sapa_component/card/card_menu.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/gen/assets.gen.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onChildrenData,
      onTeacherData,
      onPaymentData,
      onReportData,
      onLessonPlan,
      onAttendance,
      onConsultation;
  const MenuPage({
    super.key,
    required this.onChildrenData,
    required this.onTeacherData,
    required this.onPaymentData,
    required this.onReportData,
    required this.onLessonPlan,
    required this.onAttendance,
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
                    onTap: onChildrenData,
                    child: CardMenu(
                      title: 'Data Murid',
                      description: 'Data Murid',
                      imageUrl: Assets.images.menuDataStudent.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTeacherData,
                    child: CardMenu(
                      title: 'Data Guru',
                      description: 'Data Pengajar',
                      imageUrl: Assets.images.menuDataTeacher.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onPaymentData,
                    child: CardMenu(
                      title: 'Pembayaran',
                      description: 'Rekap Pembayaran',
                      imageUrl: Assets.images.menuPayment.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onReportData,
                    child: CardMenu(
                      title: 'Laporan',
                      description: 'Laporan Siswa',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuReport.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onLessonPlan,
                    child: CardMenu(
                      title: 'Lesson Plan',
                      description: 'Planning Siswa',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuLessonPlan.path,
                    ),
                  ),
                  GestureDetector(
                    onTap: onAttendance,
                    child: CardMenu(
                      title: 'Absensi',
                      description: 'Absensi Murid',
                      package: spComponentPackage,
                      imageUrl: SPAssets.images.menuAttendance.path,
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
