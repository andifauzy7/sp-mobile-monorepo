import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_daily_reports/get_daily_reports_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/add_daily_report/add_daily_report_page.dart';
import 'package:sapa_sekolah_guru/presentation/report_daily_detail/report_daily_detail.dart';

class ReportDaily extends StatelessWidget {
  final StudentModel student;
  const ReportDaily({
    super.key,
    required this.student,
  });

  void _navigateToReportDailyDetailPage(
    BuildContext context, {
    required String reportId,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReportDailyDetail(
            reportId: reportId,
          ),
        ),
      );

  void _navigateToAddDailyReportPage(
    BuildContext context, {
    required StudentModel student,
  }) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => AddDailyReportPage(
          student: student,
        ),
      ),
    );

    if (result == true) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<GetDailyReportsBloc>(context).add(
        GetDailyReportsEvent(studentId: student.studentId.toString()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetDailyReportsBloc>(context).add(
          GetDailyReportsEvent(studentId: student.studentId.toString()),
        );
        return Future.value(null);
      },
      child: Column(
        children: [
          Expanded(
            child: BlocBuilder<GetDailyReportsBloc, GetDailyReportsState>(
              builder: (context, state) {
                if (state is GetDailyReportsSuccess) {
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
                      onTap: () => _navigateToReportDailyDetailPage(
                        context,
                        reportId: state.reports[index].reportDailyId.toString(),
                      ),
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
                              DateFormat('EEEE, d MMMM y', 'id_ID').format(
                                DateTime.parse(
                                    state.reports[index].reportDate ?? ''),
                              ),
                              style: SPTextStyles.text12W400303030,
                            ),
                            SvgPicture.asset(
                              Assets.icon.arrowRight.path,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }
                if (state is GetDailyReportsError) {
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
              onPressed: () => _navigateToAddDailyReportPage(
                context,
                student: student,
              ),
              text: 'Buat Laporan Harian',
            ),
          ),
        ],
      ),
    );
  }
}
