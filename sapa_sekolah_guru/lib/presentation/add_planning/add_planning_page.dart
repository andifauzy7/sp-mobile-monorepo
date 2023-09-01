import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/bloc/add_lesson_plan/add_lesson_plan_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/activities_response_model.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_dropdown_field.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class AddPlanningPage extends StatelessWidget {
  final String? lessonPlanId;
  final VoidCallback onSuccess;
  const AddPlanningPage({
    super.key,
    required this.onSuccess,
    this.lessonPlanId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<GetStudentsBloc>()
            ..add(
              GetStudentsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<GetLessonsBloc>()
            ..add(
              GetLessonsEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<GetActivitiesBloc>()
            ..add(
              GetActivitiesEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<AddLessonPlanBloc>(),
        ),
      ],
      child: _AddPlanningPageBody(onSuccess, lessonPlanId),
    );
  }
}

class _AddPlanningPageBody extends StatefulWidget {
  final String? lessonPlanId;
  final VoidCallback onSuccess;
  const _AddPlanningPageBody(this.onSuccess, this.lessonPlanId);

  @override
  State<_AddPlanningPageBody> createState() => _AddPlanningPageBodyState();
}

class _AddPlanningPageBodyState extends State<_AddPlanningPageBody> {
  final TextEditingController noteController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  DateTime? dateTime;
  String studentId = '';
  String lessonId = '';
  List<ActivityModel> activitiesId = [];
  bool _isEnable = false;

  void _setEnableButton() {
    bool studentPass = studentId.isNotEmpty;
    bool lessonPass = lessonId.isNotEmpty;
    bool activitiesPass = activitiesId.isNotEmpty;
    bool notePass = noteController.text.isNotEmpty;
    bool datePass = dateTime != null;
    setState(() {
      _isEnable =
          studentPass && lessonPass && activitiesPass && notePass && datePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddLessonPlanBloc, AddLessonPlanState>(
      listener: (context, state) async {
        if (state is AddLessonPlanLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddLessonPlanError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddLessonPlanSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menambahkan lesson planning',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
      },
      child: Scaffold(
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
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                "Planning",
                                style: SPTextStyles.text16W400303030,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Buat Planning Harian',
                            style: SPTextStyles.text16W400303030,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          BlocBuilder<GetStudentsBloc, GetStudentsState>(
                            builder: (context, state) {
                              if (state is GetStudentsError) {
                                return Text(state.message);
                              }
                              if (state is GetStudentsSuccess) {
                                return SPDropdownField(
                                  items: state.students
                                      .map((e) => e.studentName ?? '')
                                      .toList(),
                                  hintText: 'Pilih Murid',
                                  suffix: SvgPicture.asset(
                                    Assets.icon.arrowDown.path,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      studentId = state.students
                                          .where((element) =>
                                              element.studentName == value)
                                          .first
                                          .studentId
                                          .toString();
                                    });
                                    _setEnableButton();
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SPTextField(
                            controller: dateController,
                            hintText: 'Pilih Tanggal',
                            enabled: false,
                            suffix: SvgPicture.asset(
                              Assets.icon.calendarPicker.path,
                            ),
                            onTap: () async {
                              DateTime? result = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime.utc(2010, 10, 16),
                                lastDate: DateTime.now(),
                              );

                              if (result != null) {
                                dateTime = result;
                                dateController.text =
                                    DateFormat('EEEE d MMMM, y', 'id_ID')
                                        .format(
                                  result,
                                );
                              }
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<GetLessonsBloc, GetLessonsState>(
                            builder: (context, state) {
                              if (state is GetLessonsError) {
                                return Text(state.message);
                              }
                              if (state is GetLessonsSuccess) {
                                return SPDropdownField(
                                  items: state.lessons
                                      .map((e) => e.subjectName ?? '')
                                      .toList(),
                                  hintText: 'Pilih Daftar Pelajaran',
                                  suffix: SvgPicture.asset(
                                    Assets.icon.arrowDown.path,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      lessonId = state.lessons
                                          .where((element) =>
                                              element.subjectName == value)
                                          .first
                                          .subjectId
                                          .toString();
                                    });
                                    _setEnableButton();
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          BlocBuilder<GetActivitiesBloc, GetActivitiesState>(
                            builder: (context, state) {
                              if (state is GetActivitiesError) {
                                return Text(state.message);
                              }
                              if (state is GetActivitiesSuccess) {
                                return SPDropdownField(
                                  items: state.activities
                                      .map((e) => e.activityName ?? '')
                                      .toList(),
                                  hintText: 'Pilih Aktivitas',
                                  suffix: SvgPicture.asset(
                                    Assets.icon.arrowDown.path,
                                  ),
                                  onChanged: (value) {
                                    try {
                                      activitiesId
                                          .where((element) =>
                                              element.activityName == value)
                                          .first;
                                    } catch (e) {
                                      setState(() {
                                        activitiesId.add(state.activities
                                            .where((element) =>
                                                element.activityName == value)
                                            .first);
                                      });
                                      _setEnableButton();
                                    }
                                  },
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          Wrap(
                            spacing: 8,
                            children: activitiesId
                                .map((e) => Chip(
                                      backgroundColor: SPColors.colorFFE5C0,
                                      label: Text(
                                        e.activityName ?? '-',
                                        style: SPTextStyles.text12W400636363,
                                      ),
                                      deleteIconColor: SPColors.color636363,
                                      onDeleted: () => setState(() {
                                        activitiesId.remove(e);
                                      }),
                                    ))
                                .toList(),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          SPTextField(
                            controller: noteController,
                            hintText: 'Tambah keterangan',
                            maxLines: 4,
                            onChanged: (value) => _setEnableButton(),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 16, top: 12),
                    child: SPElevatedButton(
                      type: _isEnable
                          ? SPElevatedButtonType.primary
                          : SPElevatedButtonType.disabled,
                      onPressed: () => {
                        if (_isEnable)
                          {
                            BlocProvider.of<AddLessonPlanBloc>(context).add(
                              AddLessonPlanEvent(
                                lessonPlanId: widget.lessonPlanId,
                                studentId: studentId,
                                datePlan: dateTime!,
                                lessonId: lessonId,
                                activityId: activitiesId,
                              ),
                            ),
                          }
                      },
                      text: 'Submit Planning',
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
