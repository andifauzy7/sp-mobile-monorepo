import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/list_payment/list_payment_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/bill_card.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/shimmer_card.dart';

class ListBillPage extends StatefulWidget {
  const ListBillPage({Key? key, this.studentId}) : super(key: key);

  final int? studentId;

  @override
  State<ListBillPage> createState() => _ListBillPageState();
}

class _ListBillPageState extends State<ListBillPage> {
  final bloc = getIt<ListPaymentBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(ListPaymentEvent.load(widget.studentId!));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ListPaymentBloc>(
      create: (context) => bloc,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
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
                        'My Invoice\nRecord',
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
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: BlocBuilder<ListPaymentBloc, ListPaymentState>(
                    builder: (context, state) {
                      return state.map(
                        initial: (initial) {
                          return Column(
                            children: const [
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                            ],
                          );
                        },
                        loading: (loading) {
                          return Column(
                            children: const [
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                              ShimmerCard(height: 150),
                            ],
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
                                Text(
                                  failure.message,
                                  textAlign: TextAlign.center,
                                )
                              ],
                            ),
                          );
                        },
                        success: (success) {
                          if (success.payload.isEmpty) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                    'assets/others/lottie_empty.json',
                                    height: 175,
                                    width: 175,
                                    fit: BoxFit.cover,
                                  ),
                                  const SizedBox(height: 12),
                                  const Text(
                                    'Data pembayaran belum tersedia',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Column(
                              children: success.payload
                                  .map(
                                    (e) => BillCard(
                                      model: e,
                                      studentId: widget.studentId!,
                                    ),
                                  )
                                  .toList(),
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
