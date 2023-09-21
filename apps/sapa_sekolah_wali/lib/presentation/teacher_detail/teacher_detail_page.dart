import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_teacher_detail/get_teacher_detail_bloc.dart';

class TeacherDetailPage extends StatelessWidget {
  final String teacherId;
  const TeacherDetailPage({
    super.key,
    required this.teacherId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetTeacherDetailBloc>()
        ..add(
          GetTeacherDetailEvent(
            teacherId: teacherId,
          ),
        ),
      child: _TeacherDetailPageBody(teacherId),
    );
  }
}

class _TeacherDetailPageBody extends StatelessWidget {
  final String teacherId;
  const _TeacherDetailPageBody(this.teacherId);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetTeacherDetailBloc>(context)
            .add(GetTeacherDetailEvent(
          teacherId: teacherId,
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
                  child: SPAppBar(title: 'Detail Guru'),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child:
                      BlocBuilder<GetTeacherDetailBloc, GetTeacherDetailState>(
                    builder: (context, state) {
                      Widget renderWidget = const Center(
                        child: CircularProgressIndicator(),
                      );
                      if (state is GetTeacherDetailSuccess) {
                        renderWidget = Column(
                          children: [
                            SPCachedNetworkImage(
                              imageUrl: state.teacherDetail.employeePhoto ?? '',
                              width: MediaQuery.of(context).size.height * 0.3,
                              height: MediaQuery.of(context).size.height * 0.3,
                            ),
                            const SizedBox(height: 16),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 8),
                                      Center(
                                        child: Text(
                                          state.teacherDetail.employeeName ??
                                              '-',
                                          style: SPTextStyles.text14W400303030,
                                        ),
                                      ),
                                      const SizedBox(height: 24),
                                      Text(
                                        'Deskripsi ${state.teacherDetail.employeeName ?? '-'}',
                                        style: SPTextStyles.text14W400303030,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        state.teacherDetail.description ?? '-',
                                        style: SPTextStyles.text12W400B3B3B3,
                                        textAlign: TextAlign.justify,
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
                      if (state is GetTeacherDetailError) {
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
