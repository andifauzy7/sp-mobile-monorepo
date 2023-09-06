import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/get_daily_report_detail/get_daily_report_detail_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportDailyDetail extends StatelessWidget {
  final String reportId;
  const ReportDailyDetail({
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
  final List<String> completeWork = [
    "Always",
    "Most of The Time",
    "Sometimes",
    "Had to Miss Recess To Complete"
  ];

  final List<String> qualityWork = [
    "Excellent",
    "Good",
    "Satisfactory",
    "Needs Improvement"
  ];

  final List<String> needToWork = [
    "Reading",
    "Speeling",
    "Writing",
    "Math",
  ];

  final List<String> behaviorSchool = [
    "Excellent",
    "Good",
    "Satisfactory",
    "Needs Improvement"
  ];

  final List<String> areaImprovement = [
    "Talking",
    "Listening Skill",
    "Following Instructions",
    "Staying on Task"
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetDailyReportDetailBloc>(context).add(
          GetDailyReportDetailEvent(reportId: widget.reportId),
        );
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
                    child: BlocBuilder<GetDailyReportDetailBloc,
                        GetDailyReportDetailState>(
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
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: SPTextStyles.text12W400B3B3B3,
                                        ),
                                        Text(
                                          state.report.studentName ?? '-',
                                          style: SPTextStyles.text14W400303030,
                                        ),
                                      ],
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
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (state.report.completeWork ==
                                                      (index + 1))
                                                  ? Assets
                                                      .icon.trueCheckbox.path
                                                  : Assets
                                                      .icon.emptyCheckbox.path,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              completeWork[index],
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            )
                                          ],
                                        ),
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
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (state.report.qualityWork ==
                                                      (index + 1))
                                                  ? Assets
                                                      .icon.trueCheckbox.path
                                                  : Assets
                                                      .icon.emptyCheckbox.path,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              qualityWork[index],
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            )
                                          ],
                                        ),
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
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (state.report.needWork ==
                                                      (index + 1))
                                                  ? Assets
                                                      .icon.trueCheckbox.path
                                                  : Assets
                                                      .icon.emptyCheckbox.path,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              needToWork[index],
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            )
                                          ],
                                        ),
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
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (state.report.behaviorSchool ==
                                                      (index + 1))
                                                  ? Assets
                                                      .icon.trueCheckbox.path
                                                  : Assets
                                                      .icon.emptyCheckbox.path,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              behaviorSchool[index],
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            )
                                          ],
                                        ),
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
                                      itemBuilder: (context, index) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 4,
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              (state.report.improvement ==
                                                      (index + 1))
                                                  ? Assets
                                                      .icon.trueCheckbox.path
                                                  : Assets
                                                      .icon.emptyCheckbox.path,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              areaImprovement[index],
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            )
                                          ],
                                        ),
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12),
                    child: SPElevatedButton(
                      onPressed: () => {},
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
