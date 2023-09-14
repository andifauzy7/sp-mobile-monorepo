import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_students_attendance/get_students_attendance_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_teacher/get_teacher_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/submit_student_attendance/submit_student_attendance_bloc.dart';
import 'package:sapa_sekolah_guru/model/students_attendance_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/update_student_presence/widget/student_presence_row.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class UpdateStudentPresencePage extends StatelessWidget {
  final DateTime dateTime;
  const UpdateStudentPresencePage({
    super.key,
    required this.dateTime,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<GetStudentsAttendanceBloc>()
            ..add(
              GetStudentsAttendanceEvent(
                dateTime: dateTime,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<GetTeacherBloc>()
            ..add(
              GetTeacherEvent(),
            ),
        ),
        BlocProvider(
          create: (context) =>
              GetIt.instance.get<SubmitStudentAttendanceBloc>(),
        ),
      ],
      child: _UpdateStudentPresencePageBody(
        dateTime: dateTime,
      ),
    );
  }
}

class _UpdateStudentPresencePageBody extends StatefulWidget {
  final DateTime dateTime;
  const _UpdateStudentPresencePageBody({required this.dateTime});

  @override
  State<_UpdateStudentPresencePageBody> createState() =>
      _UpdateStudentPresencePageBodyState();
}

class _UpdateStudentPresencePageBodyState
    extends State<_UpdateStudentPresencePageBody> {
  List<StudentAttendanceModel> attendances = const [];
  @override
  Widget build(BuildContext context) {
    return BlocListener<SubmitStudentAttendanceBloc,
        SubmitStudentAttendanceState>(
      listener: (context, state) async {
        if (state is SubmitStudentAttendanceLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is SubmitStudentAttendanceError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is SubmitStudentAttendanceSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil update absensi siswa',
          ).then(
            (value) => BlocProvider.of<GetStudentsAttendanceBloc>(context).add(
              GetStudentsAttendanceEvent(dateTime: widget.dateTime),
            ),
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          BlocProvider.of<GetStudentsAttendanceBloc>(context).add(
            GetStudentsAttendanceEvent(dateTime: widget.dateTime),
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
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SPAppBar(title: 'Absensi Siswa'),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BlocConsumer<GetStudentsAttendanceBloc,
                          GetStudentsAttendanceState>(
                        listener: (context, state) {
                          if (state is GetStudentsAttendanceSuccess) {
                            attendances = state.attendances;
                          }
                        },
                        builder: (context, state) {
                          Widget renderWidget = const Center(
                            child: CircularProgressIndicator(),
                          );
                          if (state is GetStudentsAttendanceError) {
                            renderWidget = SPFailureWidget(
                              message: state.message,
                            );
                          }

                          if (state is GetStudentsAttendanceSuccess) {
                            if (state.attendances.isEmpty) {
                              renderWidget = const SPFailureWidget(
                                message: 'Data kosong',
                              );
                            } else {
                              renderWidget = ListView(
                                physics: const BouncingScrollPhysics(),
                                children: [
                                  Text(
                                    'Data Siswa',
                                    style: SPTextStyles.text16W400303030,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Nama Guru',
                                              style:
                                                  SPTextStyles.text14W400B3B3B3,
                                            ),
                                            BlocBuilder<GetTeacherBloc,
                                                GetTeacherState>(
                                              builder: (context, state) {
                                                String name = "Teacher";
                                                if (state
                                                    is GetTeacherSuccess) {
                                                  name = state.teacher
                                                          .employeeName ??
                                                      name;
                                                }
                                                return Text(
                                                  name,
                                                  style: SPTextStyles
                                                      .text14W400303030,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Tanggal',
                                              style:
                                                  SPTextStyles.text14W400303030,
                                            ),
                                            Text(
                                              DateFormat('d MMMM y', 'id_ID')
                                                  .format(widget.dateTime),
                                              style:
                                                  SPTextStyles.text14W400303030,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          '${state.attendances.length} Siswa Murid',
                                          style: SPTextStyles.text12W400B3B3B3,
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
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                'Nama Murid',
                                                style: SPTextStyles
                                                    .text10W400808080,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Keterangan',
                                                style: SPTextStyles
                                                    .text10W400808080,
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                'Kehadiran',
                                                style: SPTextStyles
                                                    .text10W400808080,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                        ListView.separated(
                                          shrinkWrap: true,
                                          primary: false,
                                          itemCount: attendances.length,
                                          separatorBuilder: (_, __) =>
                                              const SizedBox(
                                            height: 8,
                                          ),
                                          itemBuilder: (_, index) {
                                            return StudentPresenceRow(
                                              name: attendances[index]
                                                      .studentName ??
                                                  '-',
                                              isPresence: attendances[index]
                                                      .ispresence ??
                                                  false,
                                              onChanged: (value) {
                                                attendances[index].ispresence =
                                                    value;
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                ],
                              );
                            }
                          }
                          return SPSwitcherAnimation(child: renderWidget);
                        },
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: SPElevatedButton(
                            type: SPElevatedButtonType.secondary,
                            text: 'Batal',
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: SPElevatedButton(
                            text: 'Submit',
                            onPressed: () =>
                                BlocProvider.of<SubmitStudentAttendanceBloc>(
                                        context)
                                    .add(
                              SubmitStudentAttendanceEvent(
                                dateTime: widget.dateTime,
                                attendances: attendances,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
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
