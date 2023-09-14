import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lessons/get_lessons_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/activity_list_widget.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_list_widget.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/lesson_plan_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

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
    const Tab(text: 'Area'),
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
      body: SPContainerImage(
        imageUrl: SPAssets.images.circleBackground.path,
        package: spComponentPackage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
              children: [
                SPAppBar(
                  title: index == 0
                      ? "Planning"
                      : index == 1
                          ? "Lesson"
                          : "Activity",
                ),
                const SizedBox(height: 24),
                Container(
                  height: kToolbarHeight - 8.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: SPShadow.shadowGrey,
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
                const SizedBox(height: 12),
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
