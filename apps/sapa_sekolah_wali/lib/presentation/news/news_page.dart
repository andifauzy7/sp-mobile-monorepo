import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/home/widget/news_card.dart';

class NewsPage extends StatelessWidget {
  final List<NewsModel> news;
  const NewsPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.colorFAFAFA,
      body: SPContainerImage(
        imageUrl: SPAssets.images.circleBackground.path,
        package: spComponentPackage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SPAppBar(title: 'Informasi Sekolah'),
                const SizedBox(height: 24),
                Expanded(
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    primary: false,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                    ),
                    itemCount: news.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return NewsCard(
                        news: news[index].news,
                        newsTitle: news[index].newsTitle,
                        imageUrl: news[index].newsImage,
                      );
                    },
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
