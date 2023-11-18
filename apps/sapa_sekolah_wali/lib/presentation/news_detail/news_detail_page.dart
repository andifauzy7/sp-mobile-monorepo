import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsModel news;
  const NewsDetailPage({
    super.key,
    required this.news,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.colorFAFAFA,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SPAppBar(title: 'Detail Informasi'),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    SPCachedNetworkImage(
                      imageUrl: news.newsImage ?? '',
                      width: MediaQuery.of(context).size.width * 0.6,
                      height: MediaQuery.of(context).size.width * 0.3,
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 8),
                              Center(
                                child: Text(
                                  news.newsTitle ?? '-',
                                  style: SPTextStyles.text14W400303030,
                                ),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                'Deskripsi',
                                style: SPTextStyles.text14W400303030,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                '-',
                                style: SPTextStyles.text12W400B3B3B3,
                                textAlign: TextAlign.justify,
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
