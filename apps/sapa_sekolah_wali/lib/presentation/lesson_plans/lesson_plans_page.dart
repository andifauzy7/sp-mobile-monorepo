import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/application/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_wali/model/lesson_plan/lesson_plans_response_model.dart';

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
  }) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
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
                      "Lesson Plan",
                      style: SPTextStyles.text16W400303030,
                    )
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: BlocBuilder<GetLessonPlansBloc, GetLessonPlansState>(
                    builder: (context, state) {
                      if (state is GetLessonPlansError) {
                        return SPFailureWidget(
                          message: state.message,
                        );
                      }

                      if (state is GetLessonPlansSuccess) {
                        if (state.lessonPlans.isEmpty) {
                          return const SPFailureWidget(
                            message: 'Data kosong',
                          );
                        }

                        return ListView.separated(
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
                              id: state.lessonPlans[index].lessonplanId
                                  .toString(),
                            ),
                            child: _renderCard(state.lessonPlans[index]),
                          ),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
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

  Widget _renderCard(LessonPlanModel lessonPlan) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lessonPlan.studentName ?? '-',
                      style: SPTextStyles.text12W500303030,
                    ),
                    Text(
                      DateFormat('EEEE d MMMM, y', 'id_ID').format(
                        DateTime.parse(lessonPlan.lessonplanDate ?? ''),
                      ),
                      style: SPTextStyles.text10W400B3B3B3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: SPColors.colorC8A8DA.withOpacity(0.25),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Lihat Detail',
                  style: SPTextStyles.text8W400B3B3B3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            (lessonPlan.lessonList ?? [])
                .map((e) => (e.subjectName ?? ''))
                .toList()
                .join(", "),
            style: SPTextStyles.text12W500303030,
          ),
        ],
      ),
    );
  }
}
