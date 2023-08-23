import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/report_student/report_student_page.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  void _navigateToReportStudentPage(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ReportStudentPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.value(null);
      },
      child: Scaffold(
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
              padding: const EdgeInsets.all(16),
              child: Column(
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
                        'Laporan',
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SPTextField(
                    hintText: 'Cari berdasarkan nama',
                    prefix: SvgPicture.asset(
                      Assets.icon.searchNormal.path,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: 10,
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                      itemBuilder: (_, __) => GestureDetector(
                        onTap: () => _navigateToReportStudentPage(context),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Rizal Bakri',
                                style: SPTextStyles.text12W400303030,
                              ),
                              SvgPicture.asset(
                                Assets.icon.arrowRight.path,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
