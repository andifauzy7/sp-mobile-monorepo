import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_name.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_attendances/get_attendances_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/attendance/widget/attendance_calendar.dart';

class AttendancePage extends StatelessWidget {
  final StudentModel student;
  const AttendancePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetAttendancesBloc>()
        ..add(
          GetAttendancesEvent(
            studentId: student.studentId.toString(),
            month: DateTime.now().month.toString(),
            year: DateTime.now().year.toString(),
          ),
        ),
      child: _AttendancePageBody(student),
    );
  }
}

class _AttendancePageBody extends StatefulWidget {
  final StudentModel student;
  const _AttendancePageBody(this.student);

  @override
  State<_AttendancePageBody> createState() => _AttendancePageBodyState();
}

class _AttendancePageBodyState extends State<_AttendancePageBody> {
  DateTime selected = DateTime.now();

  Widget _renderLabel({required String label, required Color color}) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: SPTextStyles.text10W400303030,
        )
      ],
    );
  }

  void _fetchAttendances() {
    BlocProvider.of<GetAttendancesBloc>(context).add(
      GetAttendancesEvent(
        studentId: widget.student.studentId.toString(),
        month: selected.month.toString(),
        year: selected.year.toString(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        _fetchAttendances();
        return Future.value(null);
      },
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
        body: SPContainerImage(
          imageUrl: SPAssets.images.circleBackground.path,
          package: spComponentPackage,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SPAppBar(title: 'Kehadiran Siswa'),
                  const SizedBox(height: 24),
                  CardName(
                    name: widget.student.studentName ?? '-',
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetAttendancesBloc, GetAttendancesState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );

                        if (state is GetAttendancesError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }

                        if (state is GetAttendancesSuccess) {
                          renderWidget = SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    _renderLabel(
                                      color: SPColors.color4299E1,
                                      label: 'Hadir',
                                    ),
                                    const SizedBox(width: 12),
                                    _renderLabel(
                                      color: SPColors.colorECC94B,
                                      label: 'Sakit',
                                    ),
                                    const SizedBox(width: 12),
                                    _renderLabel(
                                      color: SPColors.colorCBD5E0,
                                      label: 'Izin',
                                    ),
                                    const SizedBox(width: 12),
                                    _renderLabel(
                                      color: SPColors.colorF56565,
                                      label: 'Alpha',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                AttendanceCalendar(
                                  initialDate: selected,
                                  attendances: state.attendances,
                                  onPageChanged: (day) {
                                    selected = day;
                                    _fetchAttendances();
                                  },
                                ),
                              ],
                            ),
                          );
                        }

                        return SPSwitcherAnimation(child: renderWidget);
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
