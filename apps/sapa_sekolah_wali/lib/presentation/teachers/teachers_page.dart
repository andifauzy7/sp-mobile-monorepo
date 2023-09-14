import 'package:flutter/material.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_teachers/get_teachers_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/model/teachers_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/teachers/widget/teacher_card.dart';

class TeachersPage extends StatelessWidget {
  const TeachersPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetTeachersBloc>()
        ..add(
          GetTeachersEvent(),
        ),
      child: const _StudentsPageBody(),
    );
  }
}

class _StudentsPageBody extends StatefulWidget {
  const _StudentsPageBody();

  @override
  State<_StudentsPageBody> createState() => _StudentsPageBodyState();
}

class _StudentsPageBodyState extends State<_StudentsPageBody> {
  final TextEditingController searchController = TextEditingController();
  List<TeacherModel> teacherFiltered = [];

  void _navigateToReportStudentPage(
    BuildContext context, {
    required StudentModel student,
  }) {
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
        BlocProvider.of<GetTeachersBloc>(context).add(GetTeachersEvent());
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
                        'Data Guru',
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocListener<GetTeachersBloc, GetTeachersState>(
                      listener: (context, state) {
                        if (state is GetTeachersSuccess) {
                          teacherFiltered = state.teachers;
                        }
                      },
                      child: BlocBuilder<GetTeachersBloc, GetTeachersState>(
                        builder: (context, state) {
                          if (state is GetTeachersSuccess) {
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
                                    teacherFiltered = state.teachers
                                        .where((element) =>
                                            (element.employeeName ?? '')
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                        .toList();
                                  }),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Expanded(
                                  child: GridView.count(
                                    physics: const BouncingScrollPhysics(),
                                    crossAxisCount: 2,
                                    childAspectRatio: (1 / 1.3),
                                    shrinkWrap: true,
                                    mainAxisSpacing: 16,
                                    crossAxisSpacing: 16,
                                    children: List.generate(
                                        teacherFiltered.length, (index) {
                                      return GestureDetector(
                                        onTap: () => {},
                                        child: TeacherCard(
                                          imageUrl: teacherFiltered[index]
                                                  .employeePhoto ??
                                              '',
                                          name: teacherFiltered[index]
                                                  .employeeName ??
                                              '',
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is GetTeachersError) {
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
