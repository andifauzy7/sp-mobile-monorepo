// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/get_lesson_plans/get_lesson_plans_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/model/lesson_plan/lesson_plans_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';

class LessonPlanListPage extends StatefulWidget {
  final int? studentId;
  const LessonPlanListPage({super.key, this.studentId});

  @override
  State<LessonPlanListPage> createState() => _LessonPlanListPageState();
}

class _LessonPlanListPageState extends State<LessonPlanListPage> {
  final bloc = getIt<GetLessonPlansBloc>();

  void _navigateToLessonPlanDetail({
    required String lessonPlanId,
  }) {
    Navigator.pushNamed(
      context,
      RouteName.detailLessonPlan,
      arguments: lessonPlanId,
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.add(
      GetLessonPlansEvent(
        studentId: widget.studentId!.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Color(0xfff2bfbf),
        body: Column(
          children: [
            SafeArea(
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Pilih Planning',
                    style: TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.info_outline,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: BlocBuilder<GetLessonPlansBloc, GetLessonPlansState>(
                  builder: (context, state) {
                    if (state is GetLessonPlansError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset(
                              'assets/others/lottie_error.json',
                              height: 175,
                              width: 175,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              state.message,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    }

                    if (state is GetLessonPlansSuccess) {
                      if (state.lessonPlans.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/others/lottie_error.json',
                                height: 175,
                                width: 175,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 12),
                              const Text(
                                'Data kosong',
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
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
                          onTap: () => _navigateToLessonPlanDetail(
                            lessonPlanId: state.lessonPlans[index].lessonplanId
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
            ),
          ],
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
                    ),
                    Text(
                      lessonPlan.lessonplanDate.toString(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Lihat Detail',
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
          ),
        ],
      ),
    );
  }
}
