import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/add_activity/add_activity_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_activities/get_activities_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/widget/activity_create.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/dialog/sp_dialog.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_failure_widget.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

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
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'List Daftar Aktivitas',
                    style: SPTextStyles.text12W400303030,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<GetActivitiesBloc, GetActivitiesState>(
                      builder: (context, state) {
                        if (state is GetActivitiesSuccess) {
                          return ListView.separated(
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
                        if (state is GetActivitiesError) {
                          return SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
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
      ),
      child: Text(
        lesson,
        style: SPTextStyles.text12W400808080,
      ),
    );
  }
}
