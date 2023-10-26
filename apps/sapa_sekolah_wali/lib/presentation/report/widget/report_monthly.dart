import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_monthly_reports/get_monthly_reports_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';

class ReportMonthly extends StatelessWidget {
  final StudentModel student;
  const ReportMonthly({
    super.key,
    required this.student,
  });

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
                      onTap: () => {},
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
        ],
      ),
    );
  }
}
