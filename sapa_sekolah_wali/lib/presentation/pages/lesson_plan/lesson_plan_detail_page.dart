// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';

class LessonPlanDetailPage extends StatefulWidget {
  final String? lessonPlanId;
  const LessonPlanDetailPage({super.key, this.lessonPlanId});

  @override
  State<LessonPlanDetailPage> createState() => _LessonPlanDetailPageState();
}

class _LessonPlanDetailPageState extends State<LessonPlanDetailPage> {
  final bloc = getIt<GetLessonPlanDetailBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(
      GetLessonPlanDetailEvent(
        id: widget.lessonPlanId!,
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
                    'Detail Planning',
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
                child: BlocBuilder<GetLessonPlanDetailBloc,
                    GetLessonPlanDetailState>(
                  builder: (context, state) {
                    if (state is GetLessonPlanDetailError) {
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

                    if (state is GetLessonPlanDetailSuccess) {
                      return ListView(
                        physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics(),
                        ),
                        children: [
                          Container(
                            width: double.infinity,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text(
                                      'Murid',
                                    ),
                                    Text(
                                      'Tanggal',
                                    ),
                                  ],
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.lessonPlan.studentName ?? '-',
                                      ),
                                    ),
                                    Text(
                                      state.lessonPlan.lessonplanDate
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            'Planning yang akan di lakukan',
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount:
                                state.lessonPlan.lessonPlanlesson?.length ?? 0,
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 12,
                            ),
                            itemBuilder: (context, index) => Container(
                              width: double.infinity,
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
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Mata Pelajaran',
                                        ),
                                      ),
                                      Text(
                                        state
                                                .lessonPlan
                                                .lessonPlanlesson?[index]
                                                .subjectName ??
                                            '-',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Text(
                                          'Aktifitas',
                                        ),
                                      ),
                                      Text(
                                        (state
                                                    .lessonPlan
                                                    .lessonPlanlesson?[index]
                                                    .activityList ??
                                                [])
                                            .map((e) => e.activityName)
                                            .toList()
                                            .join("\n"),
                                        textAlign: TextAlign.right,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                        ],
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
}
