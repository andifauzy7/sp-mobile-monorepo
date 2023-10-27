import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_monthly_reports/get_monthly_reports_bloc.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/report_monthly_detail/report_monthly_detail_page.dart';

class ReportMonthly extends StatelessWidget {
  final StudentModel student;
  const ReportMonthly({
    super.key,
    required this.student,
  });

  void _navigateToReportMonthlyDetailPage(
    BuildContext context, {
    required String reportId,
    required String studentId,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReportMonthlyDetailPage(
            reportId: reportId,
            studentId: studentId,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetMonthlyReportsBloc>(context).add(
          GetMonthlyReportsEvent(studentId: student.studentId.toString()),
        );
        return Future.value(null);
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetMonthlyReportsBloc, GetMonthlyReportsState>(
              builder: (context, state) {
                if (state is GetMonthlyReportsSuccess) {
                  if (state.reports.isEmpty) {
                    return const SPFailureWidget(
                      message: 'Data kosong',
                    );
                  }
                  return ListView.separated(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: state.reports.length,
                    separatorBuilder: (_, __) => const SizedBox(
                      height: 12,
                    ),
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () => _navigateToReportMonthlyDetailPage(
                        context,
                        reportId:
                            state.reports[index].reportMonthlyId.toString(),
                        studentId: student.studentId.toString(),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          boxShadow: SPShadow.shadowGrey,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              DateFormat('EEEE, d MMMM y', 'id_ID').format(
                                DateTime.parse(
                                    state.reports[index].reportDate ?? ''),
                              ),
                              style: SPTextStyles.text12W400303030,
                            ),
                            SvgPicture.asset(
                              SPAssets.icon.arrowRight.path,
                              package: spComponentPackage,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is GetMonthlyReportsError) {
                  return SPFailureWidget(
                    message: state.message,
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(top: 12),
            child: SPElevatedButton(
              onPressed: () => {},
              text: 'Buat Laporan Bulanan',
            ),
          ),
        ],
      ),
    );
  }
}
