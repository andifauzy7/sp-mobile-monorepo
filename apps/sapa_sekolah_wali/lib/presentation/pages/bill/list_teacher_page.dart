import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/application/bloc/teacher/teacher_bloc.dart';
import 'package:sapa_sekolah_wali/injection/injection.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/shimmer_grid.dart';
import 'package:sapa_sekolah_wali/presentation/components/global/card/teacher_card.dart';

class ListTeacherPage extends StatefulWidget {
  const ListTeacherPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ListTeacherPage> createState() => _ListTeacherPageState();
}

class _ListTeacherPageState extends State<ListTeacherPage> {
  final bloc = getIt<TeacherBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(const TeacherEvent.load());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TeacherBloc>(
      create: (_) => bloc,
      child: Scaffold(
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              Container(
                height: (MediaQuery.of(context).size.height * 0.14) + 16,
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
                      height: (MediaQuery.of(context).size.height * 0.14),
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
                                  'Pilih Guru',
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
                  height: MediaQuery.of(context).size.height * 0.86,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    child: BlocBuilder<TeacherBloc, TeacherState>(
                        builder: (context, state) {
                      return state.map(
                        initial: (initial) {
                          return GridView.count(
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1.3),
                            shrinkWrap: true,
                            children: List.generate(4, (index) {
                              return const ShimmerGrid();
                            }),
                          );
                        },
                        loading: (loading) {
                          return GridView.count(
                            physics: const BouncingScrollPhysics(),
                            crossAxisCount: 2,
                            childAspectRatio: (1 / 1.3),
                            shrinkWrap: true,
                            children: List.generate(4, (index) {
                              return const ShimmerGrid();
                            }),
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
                                    'Data belum tersedia',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            );
                          } else {
                            return GridView.count(
                              physics: const BouncingScrollPhysics(),
                              crossAxisCount: 2,
                              childAspectRatio: (1 / 1.3),
                              shrinkWrap: true,
                              children: List.generate(success.payload.length,
                                  (index) {
                                return GestureDetector(
                                  onTap: () => {},
                                  child: TeacherCard(
                                    imageUrl:
                                        success.payload[index].employeePhoto ??
                                            '',
                                    name: success.payload[index].employeeName ??
                                        '',
                                  ),
                                );
                              }),
                            );
                          }
                        },
                      );
                    }),
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
