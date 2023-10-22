import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_dropdown_field.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/add_consultation/add_consultation_bloc.dart';
import 'package:sapa_sekolah_wali/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_wali/bloc/get_teachers/get_teachers_bloc.dart';

class ConsultationAddPage extends StatelessWidget {
  final VoidCallback onSuccess;
  const ConsultationAddPage({
    super.key,
    required this.onSuccess,
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
          create: (context) => GetIt.instance.get<GetTeachersBloc>()
            ..add(
              GetTeachersEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<AddConsultationBloc>(),
        ),
      ],
      child: _ConsultationAddPageBody(onSuccess),
    );
  }
}

class _ConsultationAddPageBody extends StatefulWidget {
  final VoidCallback onSuccess;
  const _ConsultationAddPageBody(this.onSuccess);

  @override
  State<_ConsultationAddPageBody> createState() =>
      __ConsultationAddPageBodyState();
}

class __ConsultationAddPageBodyState extends State<_ConsultationAddPageBody> {
  TextEditingController noteController = TextEditingController();
  String studentId = '';
  String teacherId = '';
  bool _isEnable = false;

  void _setEnableButton() {
    bool studentPass = studentId.isNotEmpty;
    bool teacherPass = teacherId.isNotEmpty;
    bool notePass = noteController.text.isNotEmpty;
    setState(() {
      _isEnable = studentPass && teacherPass && notePass;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddConsultationBloc, AddConsultationState>(
      listener: (context, state) async {
        if (state is AddConsultationLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is AddConsultationError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is AddConsultationSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menambahkan konsultasi',
          ).then(
            (value) => Navigator.pop(context),
          );
          widget.onSuccess();
        }
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
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SPAppBar(title: 'Konsultasi'),
                          const SizedBox(height: 24),
                          Text(
                            'Konsultasi pada Guru',
                            style: SPTextStyles.text16W400303030,
                          ),
                          const SizedBox(height: 20),
                          BlocBuilder<GetStudentsBloc, GetStudentsState>(
                            builder: (context, state) {
                              if (state is GetStudentsError) {
                                return Text(state.message);
                              }
                              if (state is GetStudentsSuccess) {
                                return SPDropdownField(
                                  value: null,
                                  items: state.students
                                      .map((e) => e.studentName ?? '')
                                      .toList(),
                                  hintText: 'Pilih Murid',
                                  suffix: SvgPicture.asset(
                                    SPAssets.icon.arrowDown.path,
                                    package: spComponentPackage,
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
                          const SizedBox(height: 16),
                          BlocBuilder<GetTeachersBloc, GetTeachersState>(
                            builder: (context, state) {
                              if (state is GetTeachersError) {
                                return Text(state.message);
                              }
                              if (state is GetTeachersSuccess) {
                                return SPDropdownField(
                                  value: null,
                                  items: state.teachers
                                      .map((e) => e.employeeName ?? '')
                                      .toList(),
                                  hintText: 'Pilih Guru',
                                  suffix: SvgPicture.asset(
                                    SPAssets.icon.arrowDown.path,
                                    package: spComponentPackage,
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      teacherId = state.teachers
                                          .where((element) =>
                                              element.employeeName == value)
                                          .first
                                          .employeeId
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
                          const SizedBox(height: 16),
                          SPTextField(
                            controller: noteController,
                            hintText: 'Tambah pesan',
                            maxLines: 4,
                            onChanged: (value) => _setEnableButton(),
                          ),
                          const SizedBox(height: 24),
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
                      onPressed: () {
                        if (_isEnable) {
                          BlocProvider.of<AddConsultationBloc>(context).add(
                            AddConsultationEvent(
                              studentId: studentId,
                              teacherId: teacherId,
                              questionText: noteController.text,
                            ),
                          );
                        }
                      },
                      text: 'Submit',
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
