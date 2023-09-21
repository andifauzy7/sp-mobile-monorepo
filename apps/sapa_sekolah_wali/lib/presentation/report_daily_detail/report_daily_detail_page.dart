import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_daily_report_detail/get_daily_report_detail_bloc.dart';

class ReportDailyDetailPage extends StatelessWidget {
  final String reportId;
  const ReportDailyDetailPage({
    super.key,
    required this.reportId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetDailyReportDetailBloc>()
        ..add(
          GetDailyReportDetailEvent(
            reportId: reportId,
          ),
        ),
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

  void _refetchDetailReport(BuildContext context) {
    BlocProvider.of<GetDailyReportDetailBloc>(context).add(
      GetDailyReportDetailEvent(reportId: widget.reportId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        _refetchDetailReport(context);
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
                  const SPAppBar(title: 'Laporan Harian'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocConsumer<GetDailyReportDetailBloc,
                        GetDailyReportDetailState>(
                      listener: (context, state) {
                        if (state is GetDailyReportDetailSuccess) {
                          setState(() {
                            indexCompleteWork = state.report.completeWork ?? 0;
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
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetDailyReportDetailSuccess) {
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
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
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
                                        isSelected:
                                            indexBehaviorSchool == (index + 1),
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
                                        isSelected:
                                            indexAreaImprovement == (index + 1),
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
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
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
                  ? SPAssets.icon.trueCheckbox.path
                  : SPAssets.icon.emptyCheckbox.path,
              package: spComponentPackage,
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
