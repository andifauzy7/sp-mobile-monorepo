import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/home/widget/news_card.dart';
import 'package:sapa_sekolah_wali/presentation/news_detail/news_detail_page.dart';

class NewsPage extends StatelessWidget {
  final List<NewsModel> news;
  const NewsPage({
    super.key,
    required this.news,
  });

  Future<void> _navigateToNewsDetail(
    BuildContext context, {
    required NewsModel news,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NewsDetailPage(
          news: news,
        ),
      ),
    );
  }

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
                      return GestureDetector(
                        onTap: () => _navigateToNewsDetail(
                          context,
                          news: news[index],
                        ),
                        child: NewsCard(
                          news: news[index].news,
                          newsTitle: news[index].newsTitle,
                          imageUrl: news[index].newsImage,
                        ),
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
