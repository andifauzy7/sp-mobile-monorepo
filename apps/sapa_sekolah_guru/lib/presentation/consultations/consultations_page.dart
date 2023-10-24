import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_consultation.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_consultations/get_consultations_bloc.dart';
import 'package:sapa_sekolah_guru/presentation/consultation_detail/consultation_detail_page.dart';

class ConsultationsPage extends StatelessWidget {
  const ConsultationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetConsultationsBloc>()
        ..add(
          GetConsultationsEvent(),
        ),
      child: const _ConsultationPageBody(),
    );
  }
}

class _ConsultationPageBody extends StatelessWidget {
  const _ConsultationPageBody();

  Future<void> _navigateToDetailConsultation(
    BuildContext context, {
    required String id,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => ConsultationDetailPage(
          id: id,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetConsultationsBloc>(context).add(
          GetConsultationsEvent(),
        );
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
                    'Konsultasi dari orang tua murid',
                    style: SPTextStyles.text16W400303030,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetConsultationsBloc,
                        GetConsultationsState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetConsultationsSuccess) {
                          if (state.consultations.isEmpty) {
                            renderWidget = const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          } else {
                            renderWidget = ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.consultations.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) => GestureDetector(
                                onTap: () => _navigateToDetailConsultation(
                                  context,
                                  id: state.consultations[index].consultationId
                                      .toString(),
                                ),
                                child: CardConsultation(
                                  date: DateFormat("dd-MMM-yyyy HH:mm")
                                      .parse(state.consultations[index]
                                              .submitDate ??
                                          '')
                                      .toString(),
                                  name:
                                      state.consultations[index].studentName ??
                                          '-',
                                  detailStyle: SPTextStyles.text8W400WHITE,
                                  message:
                                      state.consultations[index].questionText ??
                                          '-',
                                ),
                              ),
                            );
                          }
                        }
                        if (state is GetConsultationsError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
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
