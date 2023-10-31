import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/add_monthly_report_response/add_monthly_report_response_bloc.dart';
import 'package:sapa_sekolah_wali/bloc/get_monthly_report_detail/get_monthly_report_detail_bloc.dart';

import 'widget/report_monthly_add_response.dart';

class ReportMonthlyDetailPage extends StatelessWidget {
  final String reportId;
  final String studentId;
  const ReportMonthlyDetailPage({
    super.key,
    required this.reportId,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetMonthlyReportDetailBloc>()
        ..add(
          GetMonthlyReportDetailEvent(
            reportId: reportId,
            studentId: studentId,
          ),
        ),
      child: _ReportMonthlyDetailPageBody(reportId, studentId),
    );
  }
}

class _ReportMonthlyDetailPageBody extends StatelessWidget {
  final String reportId;
  final String studentId;
  const _ReportMonthlyDetailPageBody(this.reportId, this.studentId);

  static List<Color> colors = [
    SPColors.color8CC2F0,
    SPColors.color6FCF97,
    SPColors.colorEB5757,
    SPColors.colorF942A5,
  ];

  void _addResponseDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          BlocProvider(
            create: (_) => GetIt.instance.get<AddMonthlyReportResponseBloc>(),
            child: ReportMonthlyAddResponse(
              reportId: reportId,
              studentId: studentId,
              onSuccess: () => {},
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetMonthlyReportDetailBloc>(context).add(
          GetMonthlyReportDetailEvent(
            reportId: reportId,
            studentId: studentId,
          ),
        );
        return Future.value(null);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: SPColors.colorFAFAFA,
        body: SPContainerImage(
          imageUrl: SPAssets.images.circleBackground.path,
          package: spComponentPackage,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SPAppBar(title: 'Laporan Bulanan'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetMonthlyReportDetailBloc,
                        GetMonthlyReportDetailState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );

                        if (state is GetMonthlyReportDetailSuccess) {
                          renderWidget = ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  boxShadow: SPShadow.shadowGrey,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: SPTextStyles.text12W400B3B3B3,
                                        ),
                                        Text(
                                          DateFormat('d MMMM y', 'id_ID')
                                              .format(
                                            DateTime.parse(
                                                state.report.reportDate ?? ''),
                                          ),
                                          style: SPTextStyles.text12W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      state.report.studentName ?? '-',
                                      style: SPTextStyles.text14W400303030,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    state.report.reportDetail?.length ?? 0,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    boxShadow: SPShadow.shadowGrey,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.report.reportDetail?[index]
                                                .headerReport ??
                                            '-',
                                        style: SPTextStyles.text12W400B3B3B3
                                            .copyWith(
                                          color: colors[index % colors.length],
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        state.report.reportDetail?[index]
                                                .reportDetail ??
                                            '-',
                                        style: SPTextStyles.text10W400B3B3B3,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Pendapat Orang Tua',
                                style: SPTextStyles.text12W400303030,
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  boxShadow: SPShadow.shadowGrey,
                                ),
                                child: Text(
                                  state.report.parentNotes ?? '-',
                                  style: SPTextStyles.text10W400B3B3B3,
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }

                        if (state is GetMonthlyReportDetailError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12),
                    child: SPElevatedButton(
                      onPressed: () => _addResponseDialog(context),
                      text: 'Tambah Pendapat Orang Tua',
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
