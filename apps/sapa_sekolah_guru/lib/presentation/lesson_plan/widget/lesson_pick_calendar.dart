import 'package:flutter/material.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_teacher/get_teacher_bloc.dart';
import 'package:sapa_sekolah_guru/model/teacher_response_model.dart';
import 'package:sapa_component/calendar/sp_calendar.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';

class LessonPickCalendar extends StatelessWidget {
  final Function(DateTime selected) onSelect;
  const LessonPickCalendar({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetTeacherBloc>()
        ..add(
          GetTeacherEvent(),
        ),
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: BlocBuilder<GetTeacherBloc, GetTeacherState>(
              builder: (context, state) {
                TeacherModel teacherModel = TeacherModel(
                  employeeName: "Teacher",
                  employeePhoto: "",
                );
                if (state is GetTeacherSuccess) {
                  teacherModel = state.teacher;
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SPCachedNetworkImage(
                      width: 40,
                      height: 40,
                      imageUrl: teacherModel.employeePhoto ?? '',
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama',
                            style: SPTextStyles.text10W400B3B3B3,
                          ),
                          Row(
                            children: [
                              Text(
                                '${teacherModel.employeeName} ',
                                style: SPTextStyles.text14W400303030,
                              ),
                              Text(
                                'Guru',
                                style: SPTextStyles.text10W400B3B3B3,
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Silahkan Pilih Tanggal',
            style: SPTextStyles.text16W400303030,
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: SPCalendar(
              lastDay: DateTime(
                DateTime.now().year,
                DateTime.now().month + 6,
                DateTime.now().day,
              ),
              onSelect: onSelect,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}
