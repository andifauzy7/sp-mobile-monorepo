import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/bloc/delete_lesson_plan/delete_lesson_plan_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_lesson_plan_detail/get_lesson_plan_detail_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/lesson_plan_detail_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/add_planning/add_planning_page.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class DetailPlanningPage extends StatelessWidget {
  final String id;
  const DetailPlanningPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetIt.instance.get<GetLessonPlanDetailBloc>()
            ..add(
              GetLessonPlanDetailEvent(
                id: id,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<DeleteLessonPlanBloc>(),
        ),
      ],
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
  bool needRefresh = false;

  Future<void> _confirmDelete(
    BuildContext context, {
    required String lessonPlanId,
    required String subjectPlanId,
  }) async {
    await SPDialog.showDefault(
      context,
      children: [
        Text(
          'Yakin untuk menghapus?',
          textAlign: TextAlign.center,
          style: SPTextStyles.text14W400636363,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: SPElevatedButton(
                text: 'Kembali',
                type: SPElevatedButtonType.secondary,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SPElevatedButton(
                text: 'Yakin',
                onPressed: () {
                  BlocProvider.of<DeleteLessonPlanBloc>(context).add(
                    DeleteLessonPlanEvent(
                      lessonPlanId: lessonPlanId,
                      subjectPlanId: subjectPlanId,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _navigateToAddPlanning(
    BuildContext context, {
    required VoidCallback onSuccess,
    required LessonPlanDetailModel lessonPlan,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => AddPlanningPage(
            onSuccess: onSuccess,
            lessonPlan: lessonPlan,
          ),
        ),
      );

  void _refetchDetailPlanning(BuildContext context) {
    needRefresh = true;
    BlocProvider.of<GetLessonPlanDetailBloc>(context).add(
      GetLessonPlanDetailEvent(id: widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DeleteLessonPlanBloc, DeleteLessonPlanState>(
      listener: (context, state) async {
        if (state is DeleteLessonPlanLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is DeleteLessonPlanError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is DeleteLessonPlanSuccess) {
          _refetchDetailPlanning(context);
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil menghapus subject plan',
          );
        }
      },
      child: RefreshIndicator(
        onRefresh: () {
          _refetchDetailPlanning(context);
          return Future.value(null);
        },
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context, needRefresh);
            return Future.value(true);
          },
          child: Scaffold(
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
                            onTap: () => Navigator.pop(context, needRefresh),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Murid',
                                              style:
                                                  SPTextStyles.text10W400B3B3B3,
                                            ),
                                            Text(
                                              'Tanggal',
                                              style:
                                                  SPTextStyles.text10W400B3B3B3,
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
                                                state.lessonPlan.studentName ??
                                                    '-',
                                                style: SPTextStyles
                                                    .text10W400303030,
                                              ),
                                            ),
                                            Text(
                                              DateFormat(
                                                      'EEEE d MMMM, y', 'id_ID')
                                                  .format(
                                                DateTime.parse(state.lessonPlan
                                                        .lessonplanDate ??
                                                    ''),
                                              ),
                                              style:
                                                  SPTextStyles.text10W400303030,
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
                                    itemCount: state.lessonPlan.lessonPlanlesson
                                            ?.length ??
                                        0,
                                    separatorBuilder: (_, __) => const SizedBox(
                                      height: 12,
                                    ),
                                    itemBuilder: (context, index) => Slidable(
                                      endActionPane: ActionPane(
                                        motion: const ScrollMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) {
                                              _confirmDelete(
                                                context,
                                                lessonPlanId: state
                                                    .lessonPlan.lessonplanId
                                                    .toString(),
                                                subjectPlanId: state
                                                    .lessonPlan
                                                    .lessonPlanlesson![index]
                                                    .subjectplanId
                                                    .toString(),
                                              );
                                            },
                                            backgroundColor:
                                                SPColors.colorEB5757,
                                            foregroundColor: Colors.white,
                                            icon: Icons.delete,
                                            label: 'Delete',
                                          ),
                                        ],
                                      ),
                                      child: Container(
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
                                                    style: SPTextStyles
                                                        .text12W400B3B3B3,
                                                  ),
                                                ),
                                                Text(
                                                  state
                                                          .lessonPlan
                                                          .lessonPlanlesson?[
                                                              index]
                                                          .subjectName ??
                                                      '-',
                                                  style: SPTextStyles
                                                      .text12W400303030,
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
                                                    style: SPTextStyles
                                                        .text12W400B3B3B3,
                                                  ),
                                                ),
                                                Text(
                                                  (state
                                                              .lessonPlan
                                                              .lessonPlanlesson?[
                                                                  index]
                                                              .activityList ??
                                                          [])
                                                      .map(
                                                          (e) => e.activityName)
                                                      .toList()
                                                      .join("\n"),
                                                  textAlign: TextAlign.right,
                                                  style: SPTextStyles
                                                      .text12W400303030,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
                      BlocBuilder<GetLessonPlanDetailBloc,
                          GetLessonPlanDetailState>(
                        builder: (context, state) {
                          if (state is GetLessonPlanDetailSuccess) {
                            return Container(
                              width: double.infinity,
                              padding:
                                  const EdgeInsets.only(bottom: 16, top: 12),
                              child: SPElevatedButton(
                                onPressed: () => _navigateToAddPlanning(
                                  context,
                                  lessonPlan: state.lessonPlan,
                                  onSuccess: () =>
                                      _refetchDetailPlanning(context),
                                ),
                                text: 'Tambah Planning',
                              ),
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
