import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/update_student_presence/update_student_presence_page.dart';
import 'package:sapa_sekolah_guru/shared/component/calendar/sp_calendar.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class StudentPresencePage extends StatelessWidget {
  const StudentPresencePage({super.key});

  void _navigateToUpdateStudentPresence(
    BuildContext context, {
    required DateTime dateTime,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => UpdateStudentPresencePage(
            dateTime: dateTime,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SPIconButton(
                      url: Assets.icon.arrowLeft.path,
                      onTap: () => Navigator.pop(context),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      'Kehadiran Siswa',
                      style: SPTextStyles.text18W400303030,
                    ),
                  ],
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
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
                          onSelect: (selected) => {
                            _navigateToUpdateStudentPresence(
                              context,
                              dateTime: selected,
                            ),
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
