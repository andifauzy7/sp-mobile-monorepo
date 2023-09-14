import 'package:flutter/material.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/presentation/menu/widget/menu_card.dart';

class MenuPage extends StatelessWidget {
  final VoidCallback onChildrenData,
      onTeacherData,
      onPaymentData,
      onReportData,
      onLessonPlan;
  const MenuPage({
    super.key,
    required this.onChildrenData,
    required this.onTeacherData,
    required this.onPaymentData,
    required this.onReportData,
    required this.onLessonPlan,
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
                    child: MenuCard(
                      title: 'Data Murid',
                      description: 'Data Murid',
                      imageUrl: 'assets/images/data_murid.png',
                      color: SPColors.colorEAD2E0,
                    ),
                  ),
                  GestureDetector(
                    onTap: onTeacherData,
                    child: MenuCard(
                      title: 'Data Guru',
                      description: 'Data Pengajar',
                      imageUrl: 'assets/images/data_murid.png',
                      color: SPColors.colorC8A8DA,
                    ),
                  ),
                  GestureDetector(
                    onTap: onPaymentData,
                    child: MenuCard(
                      title: 'Pembayaran',
                      description: 'Rekap Pembayaran',
                      imageUrl: 'assets/images/pembayaran.png',
                      color: SPColors.colorFFE5C0,
                    ),
                  ),
                  GestureDetector(
                    onTap: onReportData,
                    child: MenuCard(
                      title: 'Laporan',
                      description: 'Laporan Siswa',
                      imageUrl: 'assets/images/laporan.png',
                      color: SPColors.colorEAD2E0,
                    ),
                  ),
                  GestureDetector(
                    onTap: onLessonPlan,
                    child: MenuCard(
                      title: 'Lesson Plan',
                      description: 'Planning Siswa',
                      imageUrl: 'assets/images/laporan.png',
                      color: SPColors.colorC8A8DA,
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
