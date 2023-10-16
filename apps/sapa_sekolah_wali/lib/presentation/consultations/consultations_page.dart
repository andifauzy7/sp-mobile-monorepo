import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/card/card_consultation.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_wali/presentation/consultation_add/consultation_add_page.dart';
import 'package:sapa_sekolah_wali/presentation/consultation_detail/consultation_detail_page.dart';

class ConsultationsPage extends StatelessWidget {
  const ConsultationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ConsultationPageBody();
  }
}

class _ConsultationPageBody extends StatelessWidget {
  const _ConsultationPageBody();

  Future<void> _navigateToDetailConsultation(
    BuildContext context,
  ) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const ConsultationDetailPage(),
      ),
    );
  }

  Future<void> _navigateToAddConsultation(
    BuildContext context,
  ) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const ConsultationAddPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        return Future.value(null);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: SPColors.colorFAFAFA,
        body: SPContainerImage(
          imageUrl: SPAssets.images.circleBackground.path,
          package: spComponentPackage,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SPAppBar(title: 'Ruang Konsultasi'),
                  const SizedBox(height: 16),
                  Text(
                    'Konsultasi kepada guru murid',
                    style: SPTextStyles.text16W400303030,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      itemCount: 10,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 16,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => _navigateToDetailConsultation(context),
                        child: CardConsultation(
                          date: DateTime.now().toString(),
                          name: 'Siti Mutmainah',
                          detailStyle: SPTextStyles.text8W400WHITE,
                          message:
                              'Selamat pagi ibu Restu Putri, saya ingin berkonsultasi perihal',
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16),
                    child: SPElevatedButton(
                      onPressed: () => _navigateToAddConsultation(context),
                      text: 'Konsultasi',
                    ),
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
