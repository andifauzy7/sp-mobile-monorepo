import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
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
                        "Detail Planning",
                        style: SPTextStyles.text16W400303030,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Expanded(
                    child: BlocBuilder<GetLessonPlanDetailBloc,
                        GetLessonPlanDetailState>(
                      builder: (context, state) {
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
                                      children: [
                                        Text(
                                          'Murid',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                        Text(
                                          'Tanggal',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.lessonPlan.studentName ?? '-',
                                            style:
                                                SPTextStyles.text10W400303030,
                                          ),
                                        ),
                                        Text(
                                          DateFormat('EEEE d MMMM, y', 'id_ID')
                                              .format(
                                            DateTime.parse(state.lessonPlan
                                                    .lessonplanDate ??
                                                ''),
                                          ),
                                          style: SPTextStyles.text10W400303030,
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
                                style: SPTextStyles.text10W400303030,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    state.lessonPlan.lessonPlanlesson?.length ??
                                        0,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              'Mata Pelajaran',
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            ),
                                          ),
                                          Text(
                                            state
                                                    .lessonPlan
                                                    .lessonPlanlesson?[index]
                                                    .subjectName ??
                                                '-',
                                            style:
                                                SPTextStyles.text12W400303030,
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
                                              style:
                                                  SPTextStyles.text12W400B3B3B3,
                                            ),
                                          ),
                                          Text(
                                            (state
                                                        .lessonPlan
                                                        .lessonPlanlesson?[
                                                            index]
                                                        .activityList ??
                                                    [])
                                                .map((e) => e.activityName)
                                                .toList()
                                                .join("\n"),
                                            textAlign: TextAlign.right,
                                            style:
                                                SPTextStyles.text12W400303030,
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
                        if (state is GetLessonPlanDetailError) {
                          return SPFailureWidget(
                            message: state.message,
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
      ),
    );
  }
}
