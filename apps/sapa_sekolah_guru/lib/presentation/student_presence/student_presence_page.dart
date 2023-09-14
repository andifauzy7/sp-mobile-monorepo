import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/calendar/sp_calendar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_teacher/get_teacher_bloc.dart';
import 'package:sapa_sekolah_guru/model/teacher_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/update_student_presence/update_student_presence_page.dart';

class StudentPresencePage extends StatelessWidget {
  const StudentPresencePage({super.key});

  void _navigateToUpdateStudentPresence(
    BuildContext context, {
    required DateTime dateTime,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => UpdateStudentPresencePage(
            dateTime: dateTime,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetTeacherBloc>()
        ..add(
          GetTeacherEvent(),
        ),
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
        body: SPContainerImage(
          imageUrl: SPAssets.images.circleBackground.path,
          package: spComponentPackage,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SPAppBar(title: 'Kehadiran Siswa'),
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        const SizedBox(height: 24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: SPShadow.shadowGrey,
                          ),
                          child: BlocBuilder<GetTeacherBloc, GetTeacherState>(
                            builder: (context, state) {
                              TeacherModel teacherModel = TeacherModel(
                                employeeName: "Teacher",
                                employeePhoto: "",
                              );
                              if (state is GetTeacherSuccess) {
                                teacherModel = state.teacher;
                              }

                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SPCachedNetworkImage(
                                    width: 40,
                                    height: 40,
                                    imageUrl: teacherModel.employeePhoto ?? '',
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Nama',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              '${teacherModel.employeeName} ',
                                              style:
                                                  SPTextStyles.text14W400303030,
                                            ),
                                            Text(
                                              'Guru',
                                              style:
                                                  SPTextStyles.text10W400B3B3B3,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Silahkan Pilih Tanggal',
                          style: SPTextStyles.text16W400303030,
                        ),
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            boxShadow: SPShadow.shadowGrey,
                          ),
                          child: SPCalendar(
                            lastDay: DateTime.now(),
                            onSelect: (selected) => {
                              _navigateToUpdateStudentPresence(
                                context,
                                dateTime: selected,
                              ),
                            },
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
