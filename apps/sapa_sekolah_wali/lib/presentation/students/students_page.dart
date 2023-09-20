import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_student.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/attendance/attendance_page.dart';
import 'package:sapa_sekolah_wali/presentation/lesson_plans/lesson_plans_page.dart';
import 'package:sapa_sekolah_wali/presentation/payments/payments_page.dart';
import 'package:sapa_sekolah_wali/presentation/student_detail/student_detail_page.dart';

enum StudentsPagePurpose {
  childrenData,
  paymentData,
  reportData,
  lessonPlan,
  attendanceData,
}

extension StudentsPagePurposeExtension on StudentsPagePurpose {
  String get title {
    switch (this) {
      case StudentsPagePurpose.paymentData:
        return 'Pembayaran';
      case StudentsPagePurpose.reportData:
        return 'Laporan';
      case StudentsPagePurpose.lessonPlan:
        return 'Lesson Plan';
      case StudentsPagePurpose.attendanceData:
        return 'Kehadiran Siswa';
      case StudentsPagePurpose.childrenData:
      default:
        return 'Data Murid';
    }
  }
}

class StudentsPage extends StatelessWidget {
  final StudentsPagePurpose pagePurpose;
  const StudentsPage({
    super.key,
    required this.pagePurpose,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetStudentsBloc>()
        ..add(
          GetStudentsEvent(),
        ),
      child: _StudentsPageBody(pagePurpose),
    );
  }
}

class _StudentsPageBody extends StatefulWidget {
  final StudentsPagePurpose pagePurpose;
  const _StudentsPageBody(this.pagePurpose);

  @override
  State<_StudentsPageBody> createState() => _StudentsPageBodyState();
}

class _StudentsPageBodyState extends State<_StudentsPageBody> {
  final TextEditingController searchController = TextEditingController();
  List<StudentModel> studentFiltered = [];

  void _navigateTo(
    BuildContext context, {
    required StudentModel student,
  }) {
    if (widget.pagePurpose == StudentsPagePurpose.lessonPlan) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => LessonPlansPage(
            studentId: student.studentId.toString(),
          ),
        ),
      );
    }

    if (widget.pagePurpose == StudentsPagePurpose.childrenData) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => StudentDetailPage(
            studentId: student.studentId.toString(),
          ),
        ),
      );
    }

    if (widget.pagePurpose == StudentsPagePurpose.paymentData) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => PaymentsPage(
            studentId: student.studentId.toString(),
          ),
        ),
      );
    }

    if (widget.pagePurpose == StudentsPagePurpose.attendanceData) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AttendancePage(
            student: student,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetStudentsBloc>(context).add(GetStudentsEvent());
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
                  SPAppBar(title: widget.pagePurpose.title),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocListener<GetStudentsBloc, GetStudentsState>(
                      listener: (context, state) {
                        if (state is GetStudentsSuccess) {
                          studentFiltered = state.students;
                        }
                      },
                      child: BlocBuilder<GetStudentsBloc, GetStudentsState>(
                        builder: (context, state) {
                          Widget renderWidget = const Center(
                            child: CircularProgressIndicator(),
                          );
                          if (state is GetStudentsSuccess) {
                            if (state.students.isEmpty) {
                              renderWidget = const SPFailureWidget(
                                message: 'Data kosong',
                              );
                            } else {
                              renderWidget = Column(
                                children: [
                                  SPTextField(
                                    controller: searchController,
                                    hintText: 'Cari berdasarkan nama',
                                    prefix: SvgPicture.asset(
                                      SPAssets.icon.searchNormal.path,
                                      package: spComponentPackage,
                                    ),
                                    onChanged: (value) => setState(() {
                                      studentFiltered = state.students
                                          .where((element) => (element
                                                      .studentName ??
                                                  '')
                                              .toLowerCase()
                                              .contains(value.toLowerCase()))
                                          .toList();
                                    }),
                                  ),
                                  const SizedBox(
                                    height: 16,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                      physics: const BouncingScrollPhysics(
                                        parent: AlwaysScrollableScrollPhysics(),
                                      ),
                                      itemCount: studentFiltered.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(
                                        height: 12,
                                      ),
                                      itemBuilder: (_, index) =>
                                          GestureDetector(
                                        onTap: () => _navigateTo(
                                          context,
                                          student: studentFiltered[index],
                                        ),
                                        child: CardStudent(
                                          studentName: studentFiltered[index]
                                                  .studentName ??
                                              '-',
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                          }
                          if (state is GetStudentsError) {
                            renderWidget = SPFailureWidget(
                              message: state.message,
                            );
                          }
                          return SPSwitcherAnimation(child: renderWidget);
                        },
                      ),
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
