import 'package:flutter/material.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/add_planning/add_planning_page.dart';
import 'package:sapa_sekolah_guru/presentation/detail_planning/detail_planning_page.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
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
                      Assets.icon.calendarPicker.path,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
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
                        id: state.lessonPlans[index].lessonplanId.toString(),
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
                  color: SPColors.colorFFE5C0.withOpacity(0.25),
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
