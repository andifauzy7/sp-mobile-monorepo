import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/calendar/sp_calendar.dart';
import 'package:sapa_component/card/card_name.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';

class AttendancePage extends StatelessWidget {
  final StudentModel student;
  const AttendancePage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return _AttendancePageBody(student);
  }
}

class _AttendancePageBody extends StatelessWidget {
  final StudentModel student;
  const _AttendancePageBody(this.student);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  name: student.studentName ?? '-',
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16),
                    ),
                    boxShadow: SPShadow.shadowGrey,
                  ),
                  child: SPCalendar(
                    lastDay: DateTime.now(),
                    onSelect: (selected) => {},
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
