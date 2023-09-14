import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_payments/get_payments_bloc.dart';
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
        resizeToAvoidBottomInset: false,
        backgroundColor: SPColors.colorFAFAFA,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                SPAssets.images.lessonPlanBackground.path,
                package: 'sapa_component',
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SPIconButton(
                        url: SPAssets.icon.arrowLeft.path,
                        color: SPColors.colorC8A8DA,
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Pembayaran',
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: BlocBuilder<GetPaymentsBloc, GetPaymentsState>(
                      builder: (context, state) {
                        if (state is GetPaymentsSuccess) {
                          if (state.payments.isEmpty) {
                            return const SPFailureWidget(
                              message: 'Data kosong',
                            );
                          }
                          return ListView.separated(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            itemCount: state.payments.length,
                            separatorBuilder: (_, __) => const SizedBox(
                              height: 12,
                            ),
                            itemBuilder: (_, index) => PaymentCard(
                              payment: state.payments[index],
                            ),
                          );
                        }

                        if (state is GetPaymentsError) {
                          return SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(),
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
