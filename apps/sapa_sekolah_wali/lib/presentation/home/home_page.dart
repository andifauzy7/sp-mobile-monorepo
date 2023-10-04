import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/toast/sp_toast.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_news/get_news_bloc.dart';
import 'package:sapa_sekolah_wali/gen/assets.gen.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';

import 'widget/news_card.dart';

class HomePage extends StatelessWidget {
  final Function(List<NewsModel> news) onViewAll;
  const HomePage({
    super.key,
    required this.onViewAll,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetNewsBloc>()
        ..add(
          GetNewsEvent(),
        ),
      child: _HomePageBody(onViewAll),
    );
  }
}

class _HomePageBody extends StatelessWidget {
  final Function(List<NewsModel> news) onViewAll;
  const _HomePageBody(this.onViewAll);

  void _comingSoonMessage() => SPToast.showToast(
        message: 'Fitur akan segera hadir',
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetNewsBloc>(context).add(
          GetNewsEvent(),
        );
        return Future.value(null);
      },
      child: Container(
        color: SPColors.colorFAFAFA,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
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
                      BlocBuilder<GetNewsBloc, GetNewsState>(
                        builder: (context, state) {
                          if (state is GetNewsSuccess &&
                              state.news.length > 4) {
                            return GestureDetector(
                              onTap: () => onViewAll(state.news),
                              child: Text(
                                'View All',
                                style: SPTextStyles.text12W500C8A8DA,
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocBuilder<GetNewsBloc, GetNewsState>(
                    builder: (context, state) {
                      Widget renderWidget = const Center(
                        child: CircularProgressIndicator(),
                      );

                      if (state is GetNewsSuccess) {
                        if (state.news.isEmpty) {
                          renderWidget = Column(
                            children: [
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
                            ],
                          );
                        } else {
                          renderWidget = GridView.builder(
                            primary: false,
                            shrinkWrap: true,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 16,
                              crossAxisSpacing: 16,
                            ),
                            itemCount:
                                state.news.length >= 4 ? 4 : state.news.length,
                            itemBuilder: (BuildContext ctx, index) {
                              return NewsCard(
                                news: state.news[index].news,
                                newsTitle: state.news[index].newsTitle,
                                imageUrl: state.news[index].newsImage,
                              );
                            },
                          );
                        }
                      }

                      if (state is GetNewsError) {
                        renderWidget = Column(
                          children: [
                            Image.asset(
                              SPAssets.images.imageFailure.path,
                              package: 'sapa_component',
                              height: 120,
                              width: double.infinity,
                            ),
                            Text(
                              state.message.isEmpty
                                  ? 'Belum ada informasi'
                                  : state.message,
                              style: SPTextStyles.text12W400303030,
                            ),
                          ],
                        );
                      }
                      return SPSwitcherAnimation(child: renderWidget);
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
