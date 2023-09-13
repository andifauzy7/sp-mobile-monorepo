import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_daily_report_detail/get_daily_report_detail_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/update_daily_report/update_daily_report_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';

class ReportDailyDetail extends StatelessWidget {
  final String reportId;
  const ReportDailyDetail({
    super.key,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<GetDailyReportDetailBloc>()
            ..add(
              GetDailyReportDetailEvent(
                reportId: reportId,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<UpdateDailyReportBloc>(),
        ),
      ],
      child: _ReportDailyDetailBody(reportId),
    );
  }
}

class _ReportDailyDetailBody extends StatefulWidget {
  final String reportId;
  const _ReportDailyDetailBody(this.reportId);

  @override
  State<_ReportDailyDetailBody> createState() => _ReportDailyDetailBodyState();
}

class _ReportDailyDetailBodyState extends State<_ReportDailyDetailBody> {
  int indexCompleteWork = 0;
  final List<String> completeWork = [
    "Always",
    "Most of The Time",
    "Sometimes",
    "Had to Miss Recess To Complete"
  ];

  int indexQualityWork = 0;
  final List<String> qualityWork = [
    "Excellent",
    "Good",
    "Satisfactory",
    "Needs Improvement"
  ];

  int indexNeedToWork = 0;
  final List<String> needToWork = [
    "Reading",
    "Speeling",
    "Writing",
    "Math",
  ];

  int indexBehaviorSchool = 0;
  final List<String> behaviorSchool = [
    "Excellent",
    "Good",
    "Satisfactory",
    "Needs Improvement"
  ];

  int indexAreaImprovement = 0;
  final List<String> areaImprovement = [
    "Talking",
    "Listening Skill",
    "Following Instructions",
    "Staying on Task"
  ];

  Future<void> _confirmUpdate(
    BuildContext context, {
    required String studentId,
    required String reportDate,
  }) async {
    await SPDialog.showDefault(
      context,
      children: [
        Text(
          'Yakin untuk memperbaharui laporan harian?',
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
                  BlocProvider.of<UpdateDailyReportBloc>(context).add(
                    UpdateDailyReportEvent(
                      reportDailyId: widget.reportId,
                      reportDate: reportDate,
                      studentId: studentId,
                      completeWork: indexCompleteWork.toString(),
                      qualityWork: indexQualityWork.toString(),
                      needToWork: indexNeedToWork.toString(),
                      behaviorSchool: indexBehaviorSchool.toString(),
                      improvement: indexAreaImprovement.toString(),
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

  void _refetchDetailReport(BuildContext context) {
    BlocProvider.of<GetDailyReportDetailBloc>(context).add(
      GetDailyReportDetailEvent(reportId: widget.reportId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateDailyReportBloc, UpdateDailyReportState>(
      listener: (context, state) async {
        if (state is UpdateDailyReportLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is UpdateDailyReportError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is UpdateDailyReportSuccess) {
          _refetchDetailReport(context);
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil memperbaharui laporan harian',
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          _refetchDetailReport(context);
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
                          'Laporan Harian',
                          style: SPTextStyles.text18W400303030,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocConsumer<GetDailyReportDetailBloc,
                          GetDailyReportDetailState>(
                        listener: (context, state) {
                          if (state is GetDailyReportDetailSuccess) {
                            setState(() {
                              indexCompleteWork =
                                  state.report.completeWork ?? 0;
                              indexQualityWork = state.report.qualityWork ?? 0;
                              indexNeedToWork = state.report.needWork ?? 0;
                              indexBehaviorSchool =
                                  state.report.behaviorSchool ?? 0;
                              indexAreaImprovement =
                                  state.report.improvement ?? 0;
                            });
                          }
                        },
                        builder: (context, state) {
                          if (state is GetDailyReportDetailSuccess) {
                            return ListView(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
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
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: SPColors.colorEAD2E0,
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'Work Habits',
                                            style: SPTextStyles.text14W400WHITE,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'Complete work in time',
                                          style: SPTextStyles.text12W400303030,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: completeWork.length,
                                        itemBuilder: (context, index) =>
                                            _renderRowData(
                                          label: completeWork[index],
                                          isSelected:
                                              indexCompleteWork == (index + 1),
                                          onTap: () => setState(() {
                                            indexCompleteWork = index + 1;
                                          }),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Divider(
                                          color: SPColors.colorE3E3E3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'Quality of Work',
                                          style: SPTextStyles.text12W400303030,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: qualityWork.length,
                                        itemBuilder: (context, index) =>
                                            _renderRowData(
                                          label: qualityWork[index],
                                          isSelected:
                                              indexQualityWork == (index + 1),
                                          onTap: () => setState(() {
                                            indexQualityWork = index + 1;
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: SPColors.colorC7A7D9,
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'Needs to work on',
                                            style: SPTextStyles.text14W400WHITE,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: needToWork.length,
                                        itemBuilder: (context, index) =>
                                            _renderRowData(
                                          label: needToWork[index],
                                          isSelected:
                                              indexNeedToWork == (index + 1),
                                          onTap: () => setState(() {
                                            indexNeedToWork = index + 1;
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        color: SPColors.colorEAD2E0,
                                        padding: const EdgeInsets.all(8),
                                        child: Center(
                                          child: Text(
                                            'Behavior',
                                            style: SPTextStyles.text14W400WHITE,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'Behavior at School',
                                          style: SPTextStyles.text12W400303030,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: behaviorSchool.length,
                                        itemBuilder: (context, index) =>
                                            _renderRowData(
                                          label: behaviorSchool[index],
                                          isSelected: indexBehaviorSchool ==
                                              (index + 1),
                                          onTap: () => setState(() {
                                            indexBehaviorSchool = index + 1;
                                          }),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        child: Divider(
                                          color: SPColors.colorE3E3E3,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 8,
                                        ),
                                        child: Text(
                                          'Areas For Improvement',
                                          style: SPTextStyles.text12W400303030,
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        primary: false,
                                        itemCount: areaImprovement.length,
                                        itemBuilder: (context, index) =>
                                            _renderRowData(
                                          label: areaImprovement[index],
                                          isSelected: indexAreaImprovement ==
                                              (index + 1),
                                          onTap: () => setState(() {
                                            indexAreaImprovement = index + 1;
                                          }),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 16),
                              ],
                            );
                          }

                          if (state is GetDailyReportDetailError) {
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
                    BlocBuilder<GetDailyReportDetailBloc,
                        GetDailyReportDetailState>(
                      builder: (context, state) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 12),
                          child: SPElevatedButton(
                            onPressed: () {
                              if (state is GetDailyReportDetailSuccess) {
                                _confirmUpdate(
                                  context,
                                  studentId: state.report.studentId.toString(),
                                  reportDate:
                                      state.report.reportDate.toString(),
                                );
                              }
                            },
                            text: 'Update Laporan',
                          ),
                        );
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

  Widget _renderRowData({
    VoidCallback? onTap,
    required bool isSelected,
    required String label,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 4,
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              isSelected
                  ? Assets.icon.trueCheckbox.path
                  : Assets.icon.emptyCheckbox.path,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: SPTextStyles.text12W400B3B3B3,
            )
          ],
        ),
      ),
    );
  }
}
