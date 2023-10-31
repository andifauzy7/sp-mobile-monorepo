import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_monthly_report_detail/get_monthly_report_detail_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/update_monthly_report/update_monthly_report_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<GetMonthlyReportDetailBloc>()
            ..add(
              GetMonthlyReportDetailEvent(
                reportId: reportId,
                studentId: studentId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<UpdateMonthlyReportBloc>(),
        ),
      ],
      child: _ReportMonthlyDetailPageBody(reportId, studentId),
    );
  }
}

class _ReportMonthlyDetailPageBody extends StatefulWidget {
  final String reportId;
  final String studentId;
  const _ReportMonthlyDetailPageBody(this.reportId, this.studentId);

  @override
  State<_ReportMonthlyDetailPageBody> createState() =>
      _ReportMonthlyDetailPageBodyState();
}

class _ReportMonthlyDetailPageBodyState
    extends State<_ReportMonthlyDetailPageBody> {
  List<String> values = [];
  static List<Color> colors = [
    SPColors.color8CC2F0,
    SPColors.color6FCF97,
    SPColors.colorEB5757,
    SPColors.colorF942A5,
  ];

  Future<void> _confirmUpdate(
    BuildContext context, {
    required String reportMonthlyId,
    required String studentId,
    required String reportDate,
    required List<Map<String, String>> reportMonthly,
  }) async {
    await SPDialog.showDefault(
      context,
      children: [
        Text(
          'Yakin untuk memperbaharui laporan bulanan?',
          textAlign: TextAlign.center,
          style: SPTextStyles.text14W400636363,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: SPElevatedButton(
                text: 'Kembali',
                type: SPElevatedButtonType.secondary,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SPElevatedButton(
                text: 'Yakin',
                onPressed: () {
                  BlocProvider.of<UpdateMonthlyReportBloc>(context).add(
                    UpdateMonthlyReportEvent(
                      reportMonthlyId: reportMonthlyId,
                      reportDate: reportDate,
                      studentId: studentId,
                      reportMonthly: reportMonthly,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMonthlyReportBloc, UpdateMonthlyReportState>(
      listener: (context, state) async {
        if (state is UpdateMonthlyReportLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is UpdateMonthlyReportError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is UpdateMonthlyReportSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil memperbaharui laporan bulanan',
          ).then(
            (value) => Navigator.pop(context, true),
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<GetMonthlyReportDetailBloc>(context).add(
            GetMonthlyReportDetailEvent(
              reportId: widget.reportId,
              studentId: widget.studentId,
            ),
          );
          return Future.value(null);
        },
        child: Scaffold(
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
                            for (int i = 0;
                                i < (state.report.reportDetail?.length ?? 0);
                                i++) {
                              values.add(
                                  state.report.reportDetail?[i].reportDetail ??
                                      "");
                            }

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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Nama',
                                            style:
                                                SPTextStyles.text12W400B3B3B3,
                                          ),
                                          Text(
                                            DateFormat('d MMMM y', 'id_ID')
                                                .format(
                                              DateTime.parse(
                                                  state.report.reportDate ??
                                                      ''),
                                            ),
                                            style:
                                                SPTextStyles.text12W400B3B3B3,
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
                                            color:
                                                colors[index % colors.length],
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        SPTextField(
                                          maxLines: 3,
                                          initialValue: state
                                              .report
                                              .reportDetail?[index]
                                              .reportDetail,
                                          hintText: 'Tulis penilaian ...',
                                          onChanged: (value) {
                                            values[index] = value;
                                          },
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
                    BlocBuilder<GetMonthlyReportDetailBloc,
                        GetMonthlyReportDetailState>(
                      builder: (context, state) {
                        if (state is GetMonthlyReportDetailSuccess) {
                          return Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 12),
                            child: SPElevatedButton(
                              onPressed: () {
                                List<Map<String, String>> reportMonthly = [];

                                for (int i = 0; i < values.length; i++) {
                                  reportMonthly.add(
                                    {
                                      "component_id": state
                                          .report.reportDetail![i].componentId
                                          .toString(),
                                      "report_text": values[i],
                                    },
                                  );
                                }

                                _confirmUpdate(
                                  context,
                                  reportMonthlyId:
                                      state.report.reportMonthlyId.toString(),
                                  studentId: widget.studentId.toString(),
                                  reportDate:
                                      state.report.reportDate.toString(),
                                  reportMonthly: reportMonthly,
                                );
                              },
                              text: 'Update Laporan',
                            ),
                          );
                        }

                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
