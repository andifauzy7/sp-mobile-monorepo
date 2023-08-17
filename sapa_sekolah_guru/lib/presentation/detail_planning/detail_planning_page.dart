import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/add_planning/add_planning_page.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class DetailPlanningPage extends StatelessWidget {
  const DetailPlanningPage({super.key});

  void _navigateToAddPlanning(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const AddPlanningPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
            child: Column(
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
                      "Detail Planning",
                      style: SPTextStyles.text16W400303030,
                    )
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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
                        'Murid',
                        style: SPTextStyles.text10W400B3B3B3,
                      ),
                      Text(
                        'Azka Berdaral',
                        style: SPTextStyles.text10W400303030,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
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
                        'Planning yang akan di lakukan',
                        style: SPTextStyles.text10W400303030,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Mata Pelajaran',
                              style: SPTextStyles.text12W400B3B3B3,
                            ),
                          ),
                          Text(
                            'Language',
                            style: SPTextStyles.text12W400303030,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Aktifitas',
                              style: SPTextStyles.text12W400B3B3B3,
                            ),
                          ),
                          Text(
                            'Culture',
                            style: SPTextStyles.text12W400303030,
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Divider(
                          color: SPColors.colorE3E3E3,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Jadwal',
                              style: SPTextStyles.text12W400B3B3B3,
                            ),
                          ),
                          Text(
                            'Senin 23 Agu, 2023',
                            style: SPTextStyles.text10W400303030,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Time',
                              style: SPTextStyles.text12W400B3B3B3,
                            ),
                          ),
                          Text(
                            '07:30 - 08:30',
                            style: SPTextStyles.text10W400303030,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 2,
                    child: SPElevatedButton(
                      onPressed: () => _navigateToAddPlanning(context),
                      text: 'Edit',
                    ),
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
