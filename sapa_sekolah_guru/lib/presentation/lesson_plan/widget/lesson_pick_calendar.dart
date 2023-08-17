import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/shared/component/calendar/sp_calendar.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class LessonPickCalendar extends StatelessWidget {
  final Function(DateTime selected) onSelect;
  const LessonPickCalendar({
    super.key,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                child: SizedBox(
                  width: 40,
                  height: 40,
                  child: Image.network(
                    'https://www.timeshighereducation.com/sites/default/files/styles/article_teaser/public/shutterstock_508251865_resize.jpg?itok=4R835hL_',
                    fit: BoxFit.cover,
                  ),
                ),
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
                          'Restu Putri ',
                          style: SPTextStyles.text14W400303030,
                        ),
                        Text(
                          'Guru Bhs. Inggris',
                          style: SPTextStyles.text10W400B3B3B3,
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
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
            onSelect: onSelect,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}
