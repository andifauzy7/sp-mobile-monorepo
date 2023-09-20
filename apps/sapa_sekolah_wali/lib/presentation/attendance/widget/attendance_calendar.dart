import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/model/attendances_response_model.dart';

class AttendanceCalendar extends StatelessWidget {
  final DateTime initialDate;
  final List<AttendanceModel> attendances;
  final Function(DateTime focusedDay)? onPageChanged;
  const AttendanceCalendar({
    super.key,
    required this.attendances,
    required this.initialDate,
    this.onPageChanged,
  });

  Widget _getDateWidget(DateTime day) {
    BoxDecoration decoration = const BoxDecoration();
    Color color = SPColors.color808080;
    AttendanceModel attendance = attendances.firstWhere(
      (element) => element.tanggal == DateFormat("yyyy-MM-dd").format(day),
      orElse: () => AttendanceModel(),
    );

    if (attendance.status == 'Hadir') {
      color = Colors.white;
      decoration = BoxDecoration(
        color: SPColors.color4299E1,
        shape: BoxShape.circle,
      );
    }

    if (attendance.status == 'Sakit') {
      color = Colors.white;
      decoration = BoxDecoration(
        color: SPColors.colorECC94B,
        shape: BoxShape.circle,
      );
    }

    if (attendance.status == 'Izin') {
      decoration = BoxDecoration(
        color: SPColors.colorCBD5E0,
        shape: BoxShape.circle,
      );
    }

    if (attendance.status == 'Tanpa Keterangan') {
      color = Colors.white;
      decoration = BoxDecoration(
        color: SPColors.colorF56565,
        shape: BoxShape.circle,
      );
    }

    return Container(
      margin: const EdgeInsets.all(4),
      alignment: Alignment.center,
      decoration: decoration,
      child: Text(
        day.day.toString(),
        style: SPTextStyles.text12W400808080.copyWith(
          color: color,
        ),
      ),
    );
  }

  void _createPermissionDialog(
    BuildContext context, {
    required AttendanceModel attendance,
  }) async =>
      await SPDialog.showDefault(
        context,
        children: [
          Text(
            'Pemberian Izin Murid',
            style: SPTextStyles.text14W400303030,
          ),
          const SizedBox(height: 12),
          SPTextField(
            enabled: false,
            hintText: 'Tipe Izin',
            initialValue: attendance.status,
          ),
          const SizedBox(height: 10),
          SPTextField(
            enabled: false,
            hintText: 'Tanggal',
            initialValue: DateFormat('dd MMM yyyy').format(
              DateTime.parse(
                attendance.tanggal ?? DateTime.now().toString(),
              ),
            ),
            suffix: SvgPicture.asset(
              SPAssets.icon.calendarPicker.path,
              package: spComponentPackage,
            ),
          ),
          const SizedBox(height: 10),
          SPTextField(
            initialValue: attendance.reason ?? '-',
            hintText: 'Keterangan',
            maxLines: 4,
            enabled: false,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: SPElevatedButton(
              text: 'Tutup',
              type: SPElevatedButtonType.primary,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        boxShadow: SPShadow.shadowGrey,
      ),
      child: TableCalendar(
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.now(),
        focusedDay: initialDate,
        currentDay: initialDate,
        calendarBuilders: CalendarBuilders(
          todayBuilder: (context, day, focusedDay) {
            return _getDateWidget(day);
          },
          defaultBuilder: (_, day, focusedDay) {
            return _getDateWidget(day);
          },
          disabledBuilder: (_, day, focusedDay) => Container(
            margin: const EdgeInsets.all(4),
            alignment: Alignment.center,
            child: Text(
              day.day.toString(),
              style: SPTextStyles.text12W400808080.copyWith(
                color: SPColors.color808080.withOpacity(0.6),
              ),
            ),
          ),
          outsideBuilder: (_, day, focusedDay) => const SizedBox.shrink(),
        ),
        headerStyle: HeaderStyle(
          leftChevronVisible: true,
          rightChevronVisible: true,
          formatButtonVisible: false,
          titleCentered: true,
          headerPadding: const EdgeInsets.only(bottom: 8),
          titleTextStyle: SPTextStyles.text14W400303030,
          leftChevronIcon: SvgPicture.asset(
            SPAssets.icon.arrowCircleLeft.path,
            package: spComponentPackage,
          ),
          rightChevronIcon: SvgPicture.asset(
            SPAssets.icon.arrowCircleRight.path,
            package: spComponentPackage,
          ),
          titleTextFormatter: (date, locale) =>
              DateFormat.yMMMM('id_ID').format(
            date,
          ),
        ),
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: SPTextStyles.text10W400B3B3B3,
          weekendStyle: SPTextStyles.text10W400EB5757,
          dowTextFormatter: (date, locale) =>
              DateFormat.E('id_ID').format(date),
        ),
        onDaySelected: (selectedDay, focusedDay) {
          AttendanceModel attendance = attendances.firstWhere(
            (element) =>
                element.tanggal == DateFormat("yyyy-MM-dd").format(selectedDay),
            orElse: () => AttendanceModel(),
          );

          if ((attendance.tanggal?.isNotEmpty ?? false) &&
              (attendance.status?.isNotEmpty ?? false)) {
            _createPermissionDialog(
              context,
              attendance: attendance,
            );
          }
        },
        onPageChanged: onPageChanged,
      ),
    );
  }
}
