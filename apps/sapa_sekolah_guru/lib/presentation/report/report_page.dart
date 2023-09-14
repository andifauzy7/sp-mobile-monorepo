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
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/report_student/report_student_page.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetStudentsBloc>()
        ..add(
          GetStudentsEvent(),
        ),
      child: const _ReportPageBody(),
    );
  }
}

class _ReportPageBody extends StatefulWidget {
  const _ReportPageBody();

  @override
  State<_ReportPageBody> createState() => _ReportPageBodyState();
}

class _ReportPageBodyState extends State<_ReportPageBody> {
  final TextEditingController searchController = TextEditingController();
  List<StudentModel> studentFiltered = [];

  void _navigateToReportStudentPage(
    BuildContext context, {
    required StudentModel student,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => ReportStudentPage(
            student: student,
          ),
        ),
      );

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
                  const SPAppBar(title: 'Laporan'),
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
                                  const SizedBox(height: 16),
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
                                        onTap: () =>
                                            _navigateToReportStudentPage(
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
