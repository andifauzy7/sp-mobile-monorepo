import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/schedule_timeline_card.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/tag_card.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class StudySchedulePage extends StatefulWidget {
  const StudySchedulePage({Key? key}) : super(key: key);

  @override
  State<StudySchedulePage> createState() => _StudySchedulePageState();
}

class _StudySchedulePageState extends State<StudySchedulePage> {
  final controller = DateRangePickerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text('Jadwal KBM', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  '24',
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Kamis', style: TextStyle(color: Colors.grey)),
                      Text('Desember 2021',
                          style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                const TagCard(),
              ],
            ),
            const SizedBox(height: 18),
            SizedBox(
              height: 75,
              child: SfDateRangePicker(
                view: DateRangePickerView.month,
                controller: controller,
                viewSpacing: 8,
                headerHeight: 0,
                selectionColor: Colors.white,
                headerStyle: const DateRangePickerHeaderStyle(
                  textStyle: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                ),
                monthViewSettings: const DateRangePickerMonthViewSettings(
                  viewHeaderHeight: 0,
                  numberOfWeeksInView: 1,
                ),
                cellBuilder: cellBuilder,
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: const [
                    ScheduleTimelineCard(isActive: true),
                    ScheduleTimelineCard(),
                    ScheduleTimelineCard(),
                    ScheduleTimelineCard(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget cellBuilder(BuildContext context, DateRangePickerCellDetails details) {
    final bool isSelected = controller.selectedDate != null &&
        details.date.year == controller.selectedDate!.year &&
        details.date.month == controller.selectedDate!.month &&
        details.date.day == controller.selectedDate!.day;

    if (isSelected) {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format((details.date)),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              details.date.day.toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('E').format((details.date)),
              style: TextStyle(color: Colors.grey[400]),
            ),
            const SizedBox(height: 8),
            Text(
              details.date.day.toString(),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            )
          ],
        ),
      );
    }
  }
}
