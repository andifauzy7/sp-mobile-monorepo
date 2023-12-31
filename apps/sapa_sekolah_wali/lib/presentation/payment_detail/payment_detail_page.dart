import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_payment_detail/get_payment_detail_bloc.dart';
import 'package:sapa_sekolah_wali/shared/constant/app_constant.dart';

class PaymentDetailPage extends StatelessWidget {
  final String studentId;
  final String paymentId;
  const PaymentDetailPage({
    super.key,
    required this.paymentId,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetPaymentDetailBloc>()
        ..add(
          GetPaymentDetailEvent(
            paymentId: paymentId,
            studentId: studentId,
          ),
        ),
      child: _PaymentDetailPageBody(paymentId, studentId),
    );
  }
}

class _PaymentDetailPageBody extends StatefulWidget {
  final String studentId;
  final String paymentId;
  const _PaymentDetailPageBody(
    this.paymentId,
    this.studentId,
  );

  @override
  State<_PaymentDetailPageBody> createState() => __PaymentDetailPageBodyState();
}

class __PaymentDetailPageBodyState extends State<_PaymentDetailPageBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetPaymentDetailBloc>(context).add(
          GetPaymentDetailEvent(
            paymentId: widget.paymentId,
            studentId: widget.studentId,
          ),
        );
        return Future.value(null);
      },
      child: Scaffold(
        backgroundColor: SPColors.colorFAFAFA,
        body: SPContainerImage(
          imageUrl: SPAssets.images.circleBackground.path,
          package: spComponentPackage,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                children: [
                  const SPAppBar(title: 'Detail Pembayaran'),
                  const SizedBox(height: 24),
                  Expanded(
                    child: BlocBuilder<GetPaymentDetailBloc,
                        GetPaymentDetailState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetPaymentDetailSuccess) {
                          renderWidget = ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  boxShadow: SPShadow.shadowGrey,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Pembayaran',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                        Text(
                                          'Jatuh Tempo',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.paymentDetail.paymentTitle ??
                                                '-',
                                            style:
                                                SPTextStyles.text10W400303030,
                                          ),
                                        ),
                                        Text(
                                          state.paymentDetail.dueDate ?? '-',
                                          style: SPTextStyles.text10W400303030,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Status',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                        Text(
                                          'Metode',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.paymentDetail.paymentStatus ??
                                                '-',
                                            style:
                                                SPTextStyles.text10W400303030,
                                          ),
                                        ),
                                        Text(
                                          state.paymentDetail.bankName ?? '-',
                                          style: SPTextStyles.text10W400303030,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'No. Rekening',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                        Text(
                                          'Nominal',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            state.paymentDetail
                                                    .virtualAccount ??
                                                '-',
                                            style:
                                                SPTextStyles.text10W400303030,
                                          ),
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                            locale: 'id',
                                            decimalDigits: 0,
                                          ).format(
                                            state.paymentDetail.nominalTransfer,
                                          ),
                                          textAlign: TextAlign.right,
                                          style: SPTextStyles.text16W500303030,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                'Tata Cara Pembayaran',
                                style: SPTextStyles.text10W400303030,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(16),
                                  ),
                                  boxShadow: SPShadow.shadowGrey,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: state.paymentDetail.bankName ==
                                          'BRI'
                                      ? briMobileBankingGuide
                                          .map(
                                            (e) => Text(
                                              e,
                                              style:
                                                  SPTextStyles.text12W400303030,
                                            ),
                                          )
                                          .toList()
                                      : state.paymentDetail.bankName == 'BNI'
                                          ? bniGuide
                                              .map(
                                                (e) => Text(
                                                  e,
                                                  style: SPTextStyles
                                                      .text12W400303030,
                                                ),
                                              )
                                              .toList()
                                          : state.paymentDetail.bankName ==
                                                  'BCA'
                                              ? bcaMobileBankingGuide
                                                  .map(
                                                    (e) => Text(
                                                      e,
                                                      style: SPTextStyles
                                                          .text12W400303030,
                                                    ),
                                                  )
                                                  .toList()
                                              : state.paymentDetail.bankName ==
                                                      'Mandiri'
                                                  ? mandiriGuide
                                                      .map(
                                                        (e) => Text(
                                                          e,
                                                          style: SPTextStyles
                                                              .text12W400303030,
                                                        ),
                                                      )
                                                      .toList()
                                                  : [],
                                ),
                              ),
                            ],
                          );
                        }
                        if (state is GetPaymentDetailError) {
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
