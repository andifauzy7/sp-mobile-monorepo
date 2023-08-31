import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/bloc/get_name/get_name_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_students_attendance/get_students_attendance_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/update_student_presence/widget/student_presence_row.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

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
          create: (context) => GetIt.instance.get<GetNameBloc>()
            ..add(
              GetNameEvent(),
            ),
        ),
      ],
      child: _UpdateStudentPresencePageBody(
        dateTime: dateTime,
      ),
    );
  }
}

class _UpdateStudentPresencePageBody extends StatelessWidget {
  final DateTime dateTime;
  const _UpdateStudentPresencePageBody({required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetStudentsAttendanceBloc>(context).add(
          GetStudentsAttendanceEvent(dateTime: dateTime),
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
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                        'Absensi Siswa',
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<GetStudentsAttendanceBloc,
                        GetStudentsAttendanceState>(
                      builder: (context, state) {
                        if (state is GetStudentsAttendanceError) {
                          return SPFailureWidget(
                            message: state.message,
                          );
                        }

                        if (state is GetStudentsAttendanceSuccess) {
                          if (state.attendances.isEmpty) {
                            return const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          }
                          return ListView(
                            physics: const BouncingScrollPhysics(),
                            children: [
                              Text(
                                'Data Siswa',
                                style: SPTextStyles.text16W400303030,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Nama Guru',
                                          style: SPTextStyles.text14W400B3B3B3,
                                        ),
                                        BlocBuilder<GetNameBloc, GetNameState>(
                                          builder: (context, state) {
                                            return Text(
                                              (state is GetNameSuccess)
                                                  ? state.name
                                                  : '...',
                                              style:
                                                  SPTextStyles.text14W400303030,
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
                                          style: SPTextStyles.text14W400303030,
                                        ),
                                        Text(
                                          DateFormat('d MMMM y', 'id_ID')
                                              .format(dateTime),
                                          style: SPTextStyles.text14W400303030,
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
                              const SizedBox(
                                height: 16,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: Text(
                                            'Nama Murid',
                                            style:
                                                SPTextStyles.text10W400808080,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Keterangan',
                                            style:
                                                SPTextStyles.text10W400808080,
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Text(
                                            'Kehadiran',
                                            style:
                                                SPTextStyles.text10W400808080,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 12),
                                    ListView.separated(
                                      shrinkWrap: true,
                                      primary: false,
                                      itemCount: state.attendances.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(
                                        height: 8,
                                      ),
                                      itemBuilder: (_, index) {
                                        return _renderRowPresence(
                                          name: state.attendances[index]
                                                  .studentName ??
                                              '-',
                                          isPresence: state.attendances[index]
                                                  .ispresence ??
                                              false,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        }

                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
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
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _renderRowPresence({
    required String name,
    required bool isPresence,
  }) {
    return StudentPresenceRow(
      name: name,
      isPresence: isPresence,
    );
  }
}
