import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_lesson_plan.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_wali/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/lesson_plan_detail/lesson_plan_detail_page.dart';

class LessonPlansPage extends StatelessWidget {
  final String studentId;
  const LessonPlansPage({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetLessonPlansBloc>()
        ..add(
          GetLessonPlansEvent(studentId: studentId),
        ),
      child: _LessonPlansPageBody(studentId),
    );
  }
}

class _LessonPlansPageBody extends StatelessWidget {
  final String studentId;
  const _LessonPlansPageBody(this.studentId);

  Future<void> _navigateToDetailPlanning(
    BuildContext context, {
    required String id,
  }) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LessonPlanDetailPage(
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetLessonPlansBloc>(context).add(
          GetLessonPlansEvent(studentId: studentId),
        );
        return Future.value(null);
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
                  const SPAppBar(title: 'Lesson Plan'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetLessonPlansBloc, GetLessonPlansState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetLessonPlansError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        if (state is GetLessonPlansSuccess) {
                          if (state.lessonPlans.isEmpty) {
                            renderWidget = const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          } else {
                            renderWidget = ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.lessonPlans.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => _navigateToDetailPlanning(
                                  context,
                                  id: state.lessonPlans[index].lessonplanId
                                      .toString(),
                                ),
                                child: _renderCard(state.lessonPlans[index]),
                              ),
                            );
                          }
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
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

  Widget _renderCard(LessonPlanModel lessonPlan) {
    return CardLessonPlan(
      studentName: lessonPlan.studentName ?? '-',
      date: lessonPlan.lessonplanDate ?? DateTime.now().toString(),
      detailStyle: SPTextStyles.text8W400WHITE,
      lessons: (lessonPlan.lessonList ?? [])
          .map((e) => (e.subjectName ?? ''))
          .toList()
          .join(", "),
    );
  }
}
