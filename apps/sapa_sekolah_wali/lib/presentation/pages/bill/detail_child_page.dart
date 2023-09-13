import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:sapa_sekolah_wali/application/bloc/detail_child/detail_child_bloc.dart';
import 'package:sapa_sekolah_wali/dependency.dart';

class DetailChildPage extends StatefulWidget {
  const DetailChildPage({Key? key, required this.studentId}) : super(key: key);

  final int studentId;

  @override
  State<DetailChildPage> createState() => _DetailChildPageState();
}

class _DetailChildPageState extends State<DetailChildPage> {
  final bloc = getIt<DetailChildBloc>();

  @override
  void initState() {
    super.initState();
    bloc.add(DetailChildEvent.load(widget.studentId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.black),
          ),
          title:
              const Text('Data Siswa', style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: BlocBuilder<DetailChildBloc, DetailChildState>(
              builder: (context, state) {
                return state.map(
                  initial: (_) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff4CAF50),
                      ),
                    );
                  },
                  loading: (_) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff4CAF50),
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
                          const SizedBox(height: 14),
                          Text(failure.message, textAlign: TextAlign.center)
                        ],
                      ),
                    );
                  },
                  success: (succcess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                  succcess.payload.studentPhoto ??
                                      'https://almuttaqin.sapaponpes.com/assets/images/user/sdit.png',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Center(
                          child: SelectableText(
                            succcess.payload.studentName ?? '',
                            style: const TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const Text('NIPD',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.nipd ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('NISN',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.nisn.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('Jenis Kelamin',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.gender ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('Tempat Lahir',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.tempatLahir ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('Tanggal Lahir',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.tanggalLahir ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('NIK',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.nik.toString(),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text('Alamat',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 4),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: SelectableText(
                            succcess.payload.address ?? '',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
