import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/get_name/get_name_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetNameBloc>()
        ..add(
          GetNameEvent(),
        ),
      child: Container(
        color: SPColors.colorFAFAFA,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BlocBuilder<GetNameBloc, GetNameState>(
                            builder: (context, state) {
                              if (state is GetNameSuccess &&
                                  state.name.isNotEmpty) {
                                return Text(
                                  'Hallo ${state.name}',
                                  style: SPTextStyles.text12W400636363,
                                );
                              }
                              return Text(
                                'Hallo ...',
                                style: SPTextStyles.text12W400636363,
                              );
                            },
                          ),
                          Text(
                            'Good Morning',
                            style: SPTextStyles.text20W400303030,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: SPIconButton(
                        url: Assets.icon.notification.path,
                      ),
                    ),
                    /*
                            const SizedBox(
                              width: 8,
                            ),
                            ClipRRect(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(15),
                              ),
                              child: SizedBox(
                                width: 40,
                                height: 40,
                                child: Image.network(
                                  "https://cdn.antaranews.com/cache/1200x800/2022/05/10/Screen-Shot-2022-05-09-at-10.04.13-AM_copy_1024x682.png",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            */
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  children: [
                    SPIconButton(
                      url: Assets.icon.filter.path,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: SPTextField(
                        hintText: 'Search',
                        suffix: SvgPicture.asset(
                          Assets.icon.searchNormal.path,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  'Absensi Guru',
                  style: SPTextStyles.text16W400303030,
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      SPIconButton(
                        url: Assets.icon.edit.path,
                        color: SPColors.color6FCF97,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            BlocBuilder<GetNameBloc, GetNameState>(
                              builder: (context, state) {
                                if (state is GetNameSuccess &&
                                    state.name.isNotEmpty) {
                                  return Text(
                                    state.name,
                                    style: SPTextStyles.text14W400303030,
                                  );
                                }
                                return Text(
                                  '...',
                                  style: SPTextStyles.text14W400303030,
                                );
                              },
                            ),
                            Text(
                              '02 Juli, 2023',
                              style: SPTextStyles.text10W400B3B3B3,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Absen',
                        style: SPTextStyles.text12W4006FCF97,
                      ),
                    ],
                  ),
                ),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pelajaran Hari Ini',
                        style: SPTextStyles.text16W400808080,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dimulai Pada',
                            style: SPTextStyles.text12W400636363,
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(
                                Assets.icon.timer.path,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                '07 : 25 AM',
                                style: SPTextStyles.text12W400636363,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
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
                                  'Bahasa Inggris',
                                  style: SPTextStyles.text12W400636363,
                                ),
                                Text(
                                  'Kelas 7B, 02 Agu, 2023',
                                  style: SPTextStyles.text10W400B3B3B3,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
