import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/add_planning/add_planning_page.dart';
import 'package:sapa_sekolah_guru/presentation/detail_planning/detail_planning_page.dart';
import 'package:sapa_sekolah_guru/shared/component/button/sp_elevated_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class LessonPlanListWidget extends StatelessWidget {
  final DateTime dateTime;
  final VoidCallback onTapDate;
  const LessonPlanListWidget({
    super.key,
    required this.dateTime,
    required this.onTapDate,
  });

  void _navigateToDetailPlanning(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const DetailPlanningPage(),
        ),
      );

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
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onTapDate,
              child: Row(
                children: [
                  SvgPicture.asset(
                    Assets.icon.calendarPicker.path,
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    DateFormat('EEEE d MMMM, y', 'id_ID').format(dateTime),
                    style: SPTextStyles.text12W400303030,
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            ),
            const Spacer(),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Expanded(
          child: ListView.separated(
            itemCount: 10,
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) => GestureDetector(
              onTap: () => _navigateToDetailPlanning(context),
              child: _renderCard(),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 16, top: 12),
          child: SPElevatedButton(
            onPressed: () => _navigateToAddPlanning(context),
            text: 'Buat Planning',
          ),
        ),
      ],
    );
  }

  Widget _renderCard() {
    return Container(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ananda Aulia',
                      style: SPTextStyles.text12W500303030,
                    ),
                    Text(
                      'Senin 23 Agu, 2023 | 07:30-08:30',
                      style: SPTextStyles.text10W400B3B3B3,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6,
                  horizontal: 12,
                ),
                decoration: BoxDecoration(
                  color: SPColors.colorFFE5C0.withOpacity(0.25),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Text(
                  'Lihat Detail',
                  style: SPTextStyles.text8W400B3B3B3,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            'Language, Culture',
            style: SPTextStyles.text12W500303030,
          ),
        ],
      ),
    );
  }
}
