import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_lesson_plan_activity.dart';
import 'package:sapa_component/card/card_lesson_plan_header.dart';
import 'package:sapa_component/card/card_lesson_plan_note.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart';

class LessonPlanDetailPage extends StatelessWidget {
  final String id;
  const LessonPlanDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetLessonPlanDetailBloc>()
        ..add(
          GetLessonPlanDetailEvent(
            id: id,
          ),
        ),
      child: _DetailPlanningPageBody(id: id),
    );
  }
}

class _DetailPlanningPageBody extends StatefulWidget {
  final String id;
  const _DetailPlanningPageBody({
    required this.id,
  });

  @override
  State<_DetailPlanningPageBody> createState() =>
      _DetailPlanningPageBodyState();
}

class _DetailPlanningPageBodyState extends State<_DetailPlanningPageBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetLessonPlanDetailBloc>(context).add(
          GetLessonPlanDetailEvent(id: widget.id),
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
                  const SPAppBar(title: 'Detail Planning'),
                  const SizedBox(height: 24),
                  Expanded(
                    child: BlocBuilder<GetLessonPlanDetailBloc,
                        GetLessonPlanDetailState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetLessonPlanDetailSuccess) {
                          renderWidget = ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              CardLessonPlanHeader(
                                studentName:
                                    state.lessonPlan.studentName ?? '-',
                                date: state.lessonPlan.lessonplanDate ??
                                    DateTime.now().toString(),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Planning yang akan di lakukan',
                                style: SPTextStyles.text10W400303030,
                              ),
                              const SizedBox(height: 12),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    state.lessonPlan.lessonPlanlesson?.length ??
                                        0,
                                separatorBuilder: (_, __) => const SizedBox(
                                  height: 12,
                                ),
                                itemBuilder: (context, index) =>
                                    CardLessonPlanActivity(
                                  subjectName: state
                                          .lessonPlan
                                          .lessonPlanlesson?[index]
                                          .subjectName ??
                                      '-',
                                  activities: (state
                                              .lessonPlan
                                              .lessonPlanlesson?[index]
                                              .activityList ??
                                          [])
                                      .map((e) => e.activityName)
                                      .toList()
                                      .join("\n"),
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Keterangan',
                                style: SPTextStyles.text10W400303030,
                              ),
                              const SizedBox(height: 12),
                              CardLessonPlanNote(
                                note: state.lessonPlan.planNotes?.isNotEmpty ??
                                        false
                                    ? state.lessonPlan.planNotes!
                                    : '-',
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        }
                        if (state is GetLessonPlanDetailError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
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
}
