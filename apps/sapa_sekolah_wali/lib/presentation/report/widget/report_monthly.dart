import 'package:flutter/material.dart';
import 'package:sapa_component/card/card_report.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_monthly_reports/get_monthly_reports_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/report_monthly_detail/report_monthly_detail_page.dart';

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
          GetMonthlyReportsEvent(studentId: "30"),
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
                      child: CardReport(
                        reportDate: state.reports[index].reportDate ?? '',
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
        ],
      ),
    );
  }
}
