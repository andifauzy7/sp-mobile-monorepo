import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/card/card_consultation_answer.dart';
import 'package:sapa_component/card/card_consultation_question.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';

class ConsultationDetailPage extends StatelessWidget {
  const ConsultationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ConsultationDetailPageBody();
  }
}

class _ConsultationDetailPageBody extends StatelessWidget {
  const _ConsultationDetailPageBody();

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
                  const SPAppBar(title: 'Detail Konsultasi'),
                  const SizedBox(height: 16),
                  CardConsultationQuestion(
                    name: 'Siti Mutmainah',
                    date: DateTime.now().toString(),
                    message:
                        'Selamat pagi ibu Restu Putri, saya ingin berkonsultasi mengenai anak saya dalam ke seharianya bersekolah. Apakah anak saya memilii teman di sekolah? Terimakasih banyak.',
                  ),
                  const SizedBox(height: 16),
                  const CardConsultationAnswer(
                    message:
                        'Selamat Pagi juga ibu, baik saya akan menjawab pertanyaan ibu. Anaknya baik kok bu dan mengikuti pelajaran dengan sangat baik selama sesi belajar mengajar. Temenya banyak kok, dia juga disukai sama beberapa teman kelasnya.',
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: SPElevatedButton(
                          text: 'Batal',
                          type: SPElevatedButtonType.secondary,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: SPElevatedButton(
                          text: 'Submit',
                          onPressed: () {},
                        ),
                      ),
                    ],
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
