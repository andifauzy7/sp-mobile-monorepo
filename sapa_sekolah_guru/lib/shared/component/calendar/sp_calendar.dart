import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';
import 'package:table_calendar/table_calendar.dart';

class SPCalendar extends StatefulWidget {
  final Function(DateTime selected) onSelect;
  const SPCalendar({
    super.key,
    required this.onSelect,
  });

  @override
  State<SPCalendar> createState() => _SPCalendarState();
}

class _SPCalendarState extends State<SPCalendar> {
  DateTime currentDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.now(),
      focusedDay: currentDate,
      currentDay: currentDate,
      headerStyle: HeaderStyle(
        leftChevronVisible: true,
        rightChevronVisible: true,
        formatButtonVisible: false,
        titleCentered: true,
        headerPadding: const EdgeInsets.only(bottom: 8),
        titleTextStyle: SPTextStyles.text14W400303030,
        leftChevronIcon: SvgPicture.asset(
          Assets.icon.arrowCircleLeft.path,
        ),
        rightChevronIcon: SvgPicture.asset(
          Assets.icon.arrowCircleRight.path,
        ),
        titleTextFormatter: (date, locale) => DateFormat.yMMMM('id_ID').format(
          date,
        ),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: SPTextStyles.text10W400B3B3B3,
        weekendStyle: SPTextStyles.text10W400EB5757,
        dowTextFormatter: (date, locale) => DateFormat.E('id_ID').format(date),
      ),
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: SPColors.colorFFE5C0,
          shape: BoxShape.circle,
        ),
        weekendTextStyle: SPTextStyles.text12W400EB5757,
        defaultTextStyle: SPTextStyles.text12W400808080,
        outsideTextStyle: SPTextStyles.text12W400808080,
        todayTextStyle: SPTextStyles.text12W400808080,
        disabledTextStyle: SPTextStyles.text12W400808080.copyWith(
          color: SPColors.color808080.withOpacity(0.6),
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) => setState(() {
        currentDate = selectedDay;
        widget.onSelect(currentDate);
      }),
    );
  }
}
