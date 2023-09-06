import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/report_student/report_student_page.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

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
                        'Laporan',
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
                                    Assets.icon.searchNormal.path,
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
                                      onTap: () => _navigateToReportStudentPage(
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
                                              Assets.icon.arrowRight.path,
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
