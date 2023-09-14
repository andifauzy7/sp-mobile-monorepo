import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/toast/sp_toast.dart';
import 'package:sapa_sekolah_wali/gen/assets.gen.dart';
import 'package:sapa_sekolah_wali/presentation/home/widget/news_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _comingSoonMessage() => SPToast.showToast(
        message: 'Fitur akan segera hadir',
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: SPColors.colorFAFAFA,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, Parents',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: SPTextStyles.text12W400636363,
                          ),
                          Text(
                            DateTime.now().hour <= 12
                                ? 'Selamat Pagi'
                                : DateTime.now().hour < 18
                                    ? 'Selamat Siang'
                                    : 'Selamat Malam',
                            style: SPTextStyles.text20W400303030,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SPIconButton(
                        color: SPColors.colorC8A8DA,
                        onTap: () => _comingSoonMessage(),
                        url: SPAssets.icon.notification.path,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                GestureDetector(
                  onTap: () => _comingSoonMessage(),
                  child: Image.asset(
                    Assets.images.homeBanner.path,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Informasi Sekolah',
                          style: SPTextStyles.text16W500303030,
                        ),
                        Text(
                          'Terbaru Seputar Little Castle',
                          style: SPTextStyles.text10W400B3B3B3,
                        ),
                      ],
                    ),
                    Text(
                      'View All',
                      style: SPTextStyles.text12W500C8A8DA,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Image.asset(
                  SPAssets.images.imageFailure.path,
                  package: 'sapa_component',
                  height: 120,
                  width: double.infinity,
                ),
                Text(
                  'Belum ada informasi',
                  style: SPTextStyles.text12W400303030,
                ),
                /*
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                  ),
                  itemCount: 4,
                  itemBuilder: (BuildContext ctx, index) {
                    return const NewsCard();
                  },
                ),*/
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
