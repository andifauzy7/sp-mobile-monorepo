import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_lesson/add_lesson_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_create.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class LessonListWidget extends StatelessWidget {
  const LessonListWidget({super.key});

  void _createLessonDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          BlocProvider(
            create: (_) => GetIt.instance.get<AddLessonBloc>(),
            child: LessonCreate(
              onSuccess: () => BlocProvider.of<GetLessonsBloc>(context).add(
                GetLessonsEvent(),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetLessonsBloc>(context).add(
          GetLessonsEvent(),
        );
        return Future.value(null);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                boxShadow: SPShadow.shadowGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List Area',
                    style: SPTextStyles.text12W400303030,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetLessonsBloc, GetLessonsState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetLessonsSuccess) {
                          if (state.lessons.isEmpty) {
                            renderWidget = const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          } else {
                            renderWidget = ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.lessons.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) => _renderCard(
                                lesson: state.lessons[index].subjectName ?? '-',
                              ),
                            );
                          }
                        }
                        if (state is GetLessonsError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 16, top: 12),
            child: SPElevatedButton(
              onPressed: () => _createLessonDialog(context),
              text: 'Tambah Area Pengembangan',
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderCard({
    required String lesson,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: SPColors.colorFAFAFA,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Text(
        lesson,
        style: SPTextStyles.text12W400808080,
      ),
    );
  }
}
