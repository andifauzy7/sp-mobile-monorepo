import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/detail_payment/detail_payment_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/utils/constant/app_constant.dart';

class DetailBillPage extends StatefulWidget {
  const DetailBillPage({
    Key? key,
    required this.studentId,
    required this.paymentId,
  }) : super(key: key);

  final String studentId;
  final String paymentId;

  @override
  State<DetailBillPage> createState() => _DetailBillPageState();
}

class _DetailBillPageState extends State<DetailBillPage> {
  final DetailPaymentBloc bloc = getIt<DetailPaymentBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(DetailPaymentEvent.load(widget.studentId, widget.paymentId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailPaymentBloc>(
      create: (context) => bloc,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffe16cb3),
                Color(0xfff2bfbf),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SafeArea(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Invoice',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xffe16cb3).withOpacity(0.6),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.description,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                BlocBuilder<DetailPaymentBloc, DetailPaymentState>(
                  builder: (context, state) {
                    return state.map(
                      initial: (value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                      loading: (value) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      },
                      failure: (failure) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Lottie.asset(
                                'assets/others/lottie_error.json',
                                height: 175,
                                width: 175,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(height: 12),
                              SelectableText(failure.message,
                                  textAlign: TextAlign.center)
                            ],
                          ),
                        );
                      },
                      success: (success) {
                        return Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      success.payload.paymentStatus == "Lunas"
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'LUNAS',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                          : Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                horizontal: 8,
                                                vertical: 4,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              child: const Text(
                                                'BELUM LUNAS',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            )
                                    ],
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff4CAF50),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(12),
                                          ),
                                        ),
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 12,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              success.payload.paymentTitle ??
                                                  '',
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Expanded(
                                        child: Text(
                                          'Metode',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        'Virtual Account ${success.payload.bankName}',
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'No. Rekening',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        success.payload.virtualAccount ?? '-',
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Jatuh Tempo',
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        success.payload.dueDate ?? '-',
                                        maxLines: 1,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      NumberFormat.currency(
                                        locale: 'id',
                                        decimalDigits: 0,
                                      ).format(
                                        success.payload.nominalTransfer,
                                      ),
                                      textAlign: TextAlign.right,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.all(16),
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(16),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Tata Cara',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            'Pembayaran',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Icon(
                                        Icons.info_outline,
                                        color: Colors.blueGrey,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  if (success.payload.bankName == 'Mandiri')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: mandiriGuide
                                          .map(
                                            (e) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectableText(e),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  else if (success.payload.bankName == 'BCA')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: bacMobileBankingGuide
                                          .map(
                                            (e) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectableText(e),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  else if (success.payload.bankName == 'BRI')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: briMobileBankingGuide
                                          .map(
                                            (e) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectableText(e),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  else if (success.payload.bankName == 'BNI')
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: bniGuide
                                          .map(
                                            (e) => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SelectableText(e),
                                                const SizedBox(height: 12),
                                              ],
                                            ),
                                          )
                                          .toList(),
                                    )
                                  else
                                    Container()
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
