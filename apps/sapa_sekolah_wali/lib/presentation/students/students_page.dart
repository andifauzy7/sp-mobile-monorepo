import 'package:flutter/material.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/lesson_plans/lesson_plans_page.dart';
import 'package:sapa_sekolah_wali/presentation/student_detail/student_detail_page.dart';

enum StudentsPagePurpose {
  childrenData,
  paymentData,
  reportData,
  lessonPlan,
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
    /*
    Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReportStudentPage(
            student: student,
          ),
        ),
      ); */
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
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                SPAssets.images.lessonPlanBackground.path,
                package: 'sapa_component',
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
                        url: SPAssets.icon.arrowLeft.path,
                        color: SPColors.colorC8A8DA,
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        widget.pagePurpose.title,
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocListener<GetStudentsBloc, GetStudentsState>(
                      listener: (context, state) {
                        if (state is GetStudentsSuccess) {
                          studentFiltered = state.students;
                        }
                      },
                      child: BlocBuilder<GetStudentsBloc, GetStudentsState>(
                        builder: (context, state) {
                          if (state is GetStudentsSuccess) {
                            return Column(
                              children: [
                                SPTextField(
                                  controller: searchController,
                                  hintText: 'Cari berdasarkan nama',
                                  prefix: SvgPicture.asset(
                                    SPAssets.icon.searchNormal.path,
                                    package: 'sapa_component',
                                  ),
                                  onChanged: (value) => setState(() {
                                    studentFiltered = state.students
                                        .where((element) =>
                                            (element.studentName ?? '')
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
                                    separatorBuilder: (_, __) => const SizedBox(
                                      height: 12,
                                    ),
                                    itemBuilder: (_, index) => GestureDetector(
                                      onTap: () => _navigateTo(
                                        context,
                                        student: studentFiltered[index],
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(16),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              studentFiltered[index]
                                                      .studentName ??
                                                  '-',
                                              style:
                                                  SPTextStyles.text12W400303030,
                                            ),
                                            SvgPicture.asset(
                                              SPAssets.icon.arrowRight.path,
                                              package: 'sapa_component',
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is GetStudentsError) {
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
