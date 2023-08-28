import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/activity_list_widget.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_list_widget.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_plan_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class LessonPlanPage extends StatefulWidget {
  const LessonPlanPage({super.key});

  @override
  State<LessonPlanPage> createState() => _LessonPlanPageState();
}

class _LessonPlanPageState extends State<LessonPlanPage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController _tabController;

  final _tabs = [
    const Tab(text: 'Lesson Plan'),
    const Tab(text: 'Lesson List'),
    const Tab(text: 'Activity List'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: SPColors.colorFAFAFA,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.lessonPlanBackground.path,
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
                      url: Assets.icon.arrowLeft.path,
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      index == 0
                          ? "Planning"
                          : index == 1
                              ? "Lesson"
                              : "Activity",
                      style: SPTextStyles.text16W400303030,
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: kToolbarHeight - 8.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: SPColors.colorFFE5C0,
                    ),
                    unselectedLabelColor: SPColors.colorB3B3B3,
                    labelStyle: SPTextStyles.text12W400636363,
                    unselectedLabelStyle: SPTextStyles.text12W400B3B3B3,
                    tabs: _tabs,
                    onTap: (value) => setState(() {
                      index = value;
                    }),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Expanded(
                  child: IndexedStack(
                    index: index,
                    children: [
                      BlocProvider(
                        create: (context) =>
                            GetIt.instance.get<GetLessonPlansBloc>(),
                        child: const LessonPlanWidget(),
                      ),
                      BlocProvider(
                        create: (_) => GetIt.instance.get<GetLessonsBloc>()
                          ..add(
                            GetLessonsEvent(),
                          ),
                        child: const LessonListWidget(),
                      ),
                      BlocProvider(
                        create: (_) => GetIt.instance.get<GetActivitiesBloc>()
                          ..add(
                            GetActivitiesEvent(),
                          ),
                        child: const ActivityListWidget(),
                      ),
                    ],
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
