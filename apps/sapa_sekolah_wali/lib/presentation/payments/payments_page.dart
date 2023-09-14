import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_payments/get_payments_bloc.dart';
import 'package:sapa_sekolah_wali/presentation/payment_detail/payment_detail_page.dart';
import 'package:sapa_sekolah_wali/presentation/payments/widget/payment_card.dart';

class PaymentsPage extends StatelessWidget {
  final String studentId;
  const PaymentsPage({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetPaymentsBloc>()
        ..add(
          GetPaymentsEvent(
            studentId: studentId,
          ),
        ),
      child: _PaymentsPageBody(studentId),
    );
  }
}

class _PaymentsPageBody extends StatefulWidget {
  final String studentId;
  const _PaymentsPageBody(this.studentId);

  @override
  State<_PaymentsPageBody> createState() => __PaymentsPageBodyState();
}

class __PaymentsPageBodyState extends State<_PaymentsPageBody> {
  Future<void> _navigateToPaymentDetailPage(
    BuildContext context, {
    required String paymentId,
    required String studentId,
  }) async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => PaymentDetailPage(
          paymentId: paymentId,
          studentId: studentId,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetPaymentsBloc>(context).add(
          GetPaymentsEvent(
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
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const SPAppBar(title: 'Pembayaran'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetPaymentsBloc, GetPaymentsState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );
                        if (state is GetPaymentsSuccess) {
                          if (state.payments.isEmpty) {
                            renderWidget = const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          } else {
                            renderWidget = ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.payments.length,
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 12,
                              ),
                              itemBuilder: (_, index) => GestureDetector(
                                onTap: () => _navigateToPaymentDetailPage(
                                  context,
                                  paymentId: state.payments[index].paymentId
                                      .toString(),
                                  studentId: widget.studentId,
                                ),
                                child: PaymentCard(
                                  payment: state.payments[index],
                                ),
                              ),
                            );
                          }
                        }

                        if (state is GetPaymentsError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(
                          child: renderWidget,
                        );
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
