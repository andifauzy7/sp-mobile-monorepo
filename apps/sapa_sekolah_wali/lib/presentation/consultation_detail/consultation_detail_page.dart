import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/card/card_consultation_answer.dart';
import 'package:sapa_component/card/card_consultation_question.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/add_consultation_response/add_consultation_response_bloc.dart';
import 'package:sapa_sekolah_wali/bloc/get_consultation_detail/get_consultation_detail_bloc.dart';
import 'package:sapa_sekolah_wali/presentation/consultation_detail/widget/consultation_add_response.dart';

class ConsultationDetailPage extends StatelessWidget {
  final String id;
  const ConsultationDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetConsultationDetailBloc>()
        ..add(
          GetConsultationDetailEvent(
            id: id,
          ),
        ),
      child: _ConsultationDetailPageBody(id),
    );
  }
}

class _ConsultationDetailPageBody extends StatelessWidget {
  final String id;
  const _ConsultationDetailPageBody(this.id);

  void _addResponseDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          BlocProvider(
            create: (_) => GetIt.instance.get<AddConsultationResponseBloc>(),
            child: ConsultationAddResponse(
              consultationId: id,
              onSuccess: () =>
                  BlocProvider.of<GetConsultationDetailBloc>(context).add(
                GetConsultationDetailEvent(id: id),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetConsultationDetailBloc>(context).add(
          GetConsultationDetailEvent(id: id),
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
                  const SPAppBar(title: 'Detail Konsultasi'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetConsultationDetailBloc,
                        GetConsultationDetailState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetConsultationDetailSuccess) {
                          renderWidget = ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              CardConsultationQuestion(
                                name: state.consultation.studentName ?? '-',
                                date: DateFormat("dd-MMM-yyyy HH:mm")
                                    .parse(
                                        state.consultation.questionDate ?? '')
                                    .toString(),
                                message: state.consultation.questionText ?? '-',
                              ),
                              const SizedBox(height: 16),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    state.consultation.reponseDetail?.length ??
                                        0,
                                separatorBuilder: (_, __) => const SizedBox(
                                  height: 16,
                                ),
                                itemBuilder: (context, index) =>
                                    CardConsultationAnswer(
                                  pov: CardConsultationAnswerPov.parent,
                                  sender: state.consultation
                                          .reponseDetail?[index].responseFrom ??
                                      '',
                                  message: state.consultation
                                          .reponseDetail?[index].responseText ??
                                      '',
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is GetConsultationDetailError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(top: 16),
                    child: SPElevatedButton(
                      onPressed: () => _addResponseDialog(context),
                      text: 'Tambah Tanggapan',
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
