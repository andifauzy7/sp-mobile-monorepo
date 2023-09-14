import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/update_daily_report/update_daily_report_bloc.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class AddDailyReportPage extends StatelessWidget {
  final StudentModel student;
  const AddDailyReportPage({
    super.key,
    required this.student,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<UpdateDailyReportBloc>(),
      child: _ReportDailyDetailBody(student),
    );
  }
}

class _ReportDailyDetailBody extends StatefulWidget {
  final StudentModel student;
  const _ReportDailyDetailBody(this.student);

  @override
  State<_ReportDailyDetailBody> createState() => _ReportDailyDetailBodyState();
}

class _ReportDailyDetailBodyState extends State<_ReportDailyDetailBody> {
  DateTime dateTime = DateTime.now();
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

  Future<void> _confirmCreate(
    BuildContext context, {
    required String studentId,
    required String reportDate,
  }) async {
    await SPDialog.showDefault(
      context,
      children: [
        Text(
          'Yakin untuk membuat laporan harian?',
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
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil membuat laporan harian',
          ).then(
            (value) => Navigator.pop(context, true),
          );
        }
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
                  const SPAppBar(title: 'Buat Laporan Harian'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView(
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
                              Text(
                                'Nama',
                                style: SPTextStyles.text12W400B3B3B3,
                              ),
                              Text(
                                widget.student.studentName ?? '-',
                                style: SPTextStyles.text14W400303030,
                              ),
                            ],
                          ),
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Tanggal',
                                style: SPTextStyles.text12W400B3B3B3,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime? result = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.utc(2010, 10, 16),
                                    lastDate: DateTime.now(),
                                  );

                                  if (result != null) {
                                    setState(() {
                                      dateTime = result;
                                    });
                                  }
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      DateFormat('d MMMM y', 'id_ID').format(
                                        dateTime,
                                      ),
                                      style: SPTextStyles.text14W400303030,
                                    ),
                                    SvgPicture.asset(
                                      SPAssets.icon.calendarPicker.path,
                                      package: spComponentPackage,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                                itemBuilder: (context, index) => _renderRowData(
                                  label: completeWork[index],
                                  isSelected: indexCompleteWork == (index + 1),
                                  onTap: () => setState(() {
                                    indexCompleteWork = index + 1;
                                  }),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                itemBuilder: (context, index) => _renderRowData(
                                  label: qualityWork[index],
                                  isSelected: indexQualityWork == (index + 1),
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                                itemBuilder: (context, index) => _renderRowData(
                                  label: needToWork[index],
                                  isSelected: indexNeedToWork == (index + 1),
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
                          padding: const EdgeInsets.symmetric(vertical: 16),
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
                                itemBuilder: (context, index) => _renderRowData(
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
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
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
                                itemBuilder: (context, index) => _renderRowData(
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
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 12),
                    child: SPElevatedButton(
                      onPressed: () {
                        _confirmCreate(
                          context,
                          studentId: widget.student.studentId.toString(),
                          reportDate: DateFormat("yyyy-MM-dd").format(dateTime),
                        );
                      },
                      text: 'Buat Laporan',
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
