import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_student_detail/get_student_detail_bloc.dart';
import 'package:sapa_sekolah_wali/presentation/student_detail/widget/student_data_tile.dart';

class StudentDetailPage extends StatelessWidget {
  final String studentId;
  const StudentDetailPage({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetStudentDetailBloc>()
        ..add(
          GetStudentDetailEvent(
            studentId: studentId,
          ),
        ),
      child: _StudentDetailPageBody(studentId),
    );
  }
}

class _StudentDetailPageBody extends StatefulWidget {
  final String studentId;
  const _StudentDetailPageBody(this.studentId);

  @override
  State<_StudentDetailPageBody> createState() => __StudentDetailPageBodyState();
}

class __StudentDetailPageBodyState extends State<_StudentDetailPageBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetStudentDetailBloc>(context)
            .add(GetStudentDetailEvent(
          studentId: widget.studentId,
        ));
        return Future.value(null);
      },
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: SPAppBar(title: 'Detail Siswa'),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      BlocBuilder<GetStudentDetailBloc, GetStudentDetailState>(
                    builder: (context, state) {
                      Widget renderWidget = const Center(
                        child: CircularProgressIndicator(),
                      );
                      if (state is GetStudentDetailSuccess) {
                        renderWidget = Column(
                          children: [
                            SPCachedNetworkImage(
                              imageUrl: state.studentDetail.studentPhoto ?? '',
                              width: 94,
                              height: 94,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              state.studentDetail.studentName ?? '-',
                              style: SPTextStyles.text14W400303030,
                            ),
                            const SizedBox(height: 24),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics(),
                                  ),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 8),
                                      Text(
                                        'Biodata Siswa',
                                        style: SPTextStyles.text14W400303030,
                                      ),
                                      const SizedBox(height: 16),
                                      StudentDataTile(
                                        label: 'Nama Lengkap',
                                        value: state.studentDetail.studentName,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'NIPD',
                                        value: state.studentDetail.nipd,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'NISN',
                                        value: state.studentDetail.nisn,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'Gender',
                                        value: state.studentDetail.gender,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'Tempat Lahir',
                                        value: state.studentDetail.tempatLahir,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'Tanggal Lahir',
                                        value: state.studentDetail.tanggalLahir,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'NIK',
                                        value: state.studentDetail.nik,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'Religion',
                                        value: state.studentDetail.religion,
                                      ),
                                      const SizedBox(height: 8),
                                      StudentDataTile(
                                        label: 'Religion',
                                        value: state.studentDetail.address,
                                      ),
                                      const SizedBox(height: 8),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        );
                      }
                      if (state is GetStudentDetailError) {
                        renderWidget = SPFailureWidget(
                          message: state.message,
                        );
                      }
                      return SPSwitcherAnimation(
                        child: renderWidget,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
