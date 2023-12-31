import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_activity/add_activity_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/activity_create.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class ActivityListWidget extends StatelessWidget {
  const ActivityListWidget({super.key});

  void _createActivityDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          BlocProvider(
            create: (_) => GetIt.instance.get<AddActivityBloc>(),
            child: ActivityCreate(
              onSuccess: () => BlocProvider.of<GetActivitiesBloc>(context).add(
                GetActivitiesEvent(),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetActivitiesBloc>(context).add(
          GetActivitiesEvent(),
        );
        return Future.value(null);
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(16),
                ),
                boxShadow: SPShadow.shadowGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List Daftar Aktivitas',
                    style: SPTextStyles.text12W400303030,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetActivitiesBloc, GetActivitiesState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetActivitiesSuccess) {
                          if (state.activities.isEmpty) {
                            renderWidget = const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          } else {
                            renderWidget = ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.activities.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) => _renderCard(
                                lesson:
                                    state.activities[index].activityName ?? '-',
                              ),
                            );
                          }
                        }
                        if (state is GetActivitiesError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(bottom: 16, top: 12),
            child: SPElevatedButton(
              onPressed: () => _createActivityDialog(context),
              text: 'Tambah Aktivitas',
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderCard({
    required String lesson,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: SPColors.colorFAFAFA,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: Text(
        lesson,
        style: SPTextStyles.text12W400808080,
      ),
    );
  }
}
