import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/application/bloc/child/child_bloc.dart';
import 'package:sapa_sekolah_wali/injection/injection.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/child_card.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/shimmer_card.dart';

class ListChildPage extends StatefulWidget {
  const ListChildPage({Key? key, this.direction = 'payment'}) : super(key: key);

  final String? direction;

  @override
  State<ListChildPage> createState() => _ListChildPageState();
}

class _ListChildPageState extends State<ListChildPage> {
  final bloc = getIt<ChildBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(const ChildEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ChildBloc>(
      create: (_) => bloc,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 0.4) + 16,
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
                child: Column(
                  children: [
                    SizedBox(
                      height: (MediaQuery.of(context).size.height * 0.4),
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
                                const Text(
                                  'Pilih Siswa',
                                  style: TextStyle(color: Colors.white),
                                ),
                                const Spacer(),
                                IconButton(
                                  onPressed: () => Navigator.pop(context),
                                  icon: const Icon(
                                    Icons.info_outline,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                'assets/images/logo.png',
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: BlocBuilder<ChildBloc, ChildState>(
                          builder: (context, state) {
                        return state.map(
                          initial: (initial) {
                            return Column(
                              children: const [
                                ShimmerCard(),
                                ShimmerCard(),
                                ShimmerCard(),
                              ],
                            );
                          },
                          loading: (loading) {
                            return Column(
                              children: const [
                                ShimmerCard(),
                                ShimmerCard(),
                                ShimmerCard(),
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
                                  Text(failure.message,
                                      textAlign: TextAlign.center)
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
                                    const Text('Data pembayaran belum tersedia',
                                        textAlign: TextAlign.center)
                                  ],
                                ),
                              );
                            } else {
                              return Column(
                                children: success.payload
                                    .map(
                                      (e) => ChildCard(
                                        childModel: e,
                                        onTap: () {},
                                      ),
                                    )
                                    .toList(),
                              );
                            }
                          },
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
