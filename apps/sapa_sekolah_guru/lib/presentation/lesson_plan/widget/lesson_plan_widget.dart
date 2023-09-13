import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_pick_calendar.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_plan_list_widget.dart';

class LessonPlanWidget extends StatefulWidget {
  const LessonPlanWidget({super.key});

  @override
  State<LessonPlanWidget> createState() => _LessonPlanWidgetState();
}

class _LessonPlanWidgetState extends State<LessonPlanWidget> {
  DateTime dateTime = DateTime.now();
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: index,
      children: [
        LessonPickCalendar(
          onSelect: (selected) => setState(
            () {
              index = 1;
              dateTime = selected;
              BlocProvider.of<GetLessonPlansBloc>(context).add(
                GetLessonPlansEvent(lessonDate: selected),
              );
            },
          ),
        ),
        LessonPlanListWidget(
          dateTime: dateTime,
          onTapDate: () => setState(() {
            index = 0;
          }),
        ),
      ],
    );
  }
}
