import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/card/card_lesson_plan.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/add_planning/add_planning_page.dart';
import 'package:sapa_sekolah_guru/presentation/detail_planning/detail_planning_page.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class LessonPlanListWidget extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onTapDate;
  const LessonPlanListWidget({
    super.key,
    required this.dateTime,
    required this.onTapDate,
  });

  Future<void> _navigateToDetailPlanning(
    BuildContext context, {
    required String id,
  }) async {
    var needRefresh = await Navigator.push<bool>(
      context,
      MaterialPageRoute<bool>(
        builder: (BuildContext context) => DetailPlanningPage(
          id: id,
        ),
      ),
    );

    if (needRefresh == true) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<GetLessonPlansBloc>(context).add(
        GetLessonPlansEvent(lessonDate: dateTime),
      );
    }
  }

  void _navigateToAddPlanning(
    BuildContext context, {
    required VoidCallback onSuccess,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AddPlanningPage(
            onSuccess: onSuccess,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetLessonPlansBloc>(context).add(
          GetLessonPlansEvent(lessonDate: dateTime),
        );
        return Future.value(null);
      },
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: onTapDate,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      SPAssets.icon.calendarPicker.path,
                      package: spComponentPackage,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DateFormat('EEEE d MMMM, y', 'id_ID').format(dateTime),
                      style: SPTextStyles.text12W400303030,
                      textAlign: TextAlign.right,
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
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
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _navigateToDetailPlanning(
                          context,
                          id: state.lessonPlans[index].lessonplanId.toString(),
                        ),
                        child: CardLessonPlan(
                          studentName:
                              state.lessonPlans[index].studentName ?? '-',
                          date: state.lessonPlans[index].lessonplanDate ??
                              DateTime.now().toString(),
                          lessons: (state.lessonPlans[index].lessonList ?? [])
                              .map((e) => (e.subjectName ?? ''))
                              .toList()
                              .join(", "),
                        ),
                      ),
                    );
                  }
                }
                return SPSwitcherAnimation(child: renderWidget);
              },
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 16, top: 12),
            child: SPElevatedButton(
              onPressed: () => _navigateToAddPlanning(context, onSuccess: () {
                BlocProvider.of<GetLessonPlansBloc>(context).add(
                  GetLessonPlansEvent(lessonDate: dateTime),
                );
              }),
              text: 'Buat Planning',
            ),
          ),
        ],
      ),
    );
  }
}
