import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_student_detail/get_student_detail_bloc.dart';

class StudentDetailPage extends StatelessWidget {
  final String studentId;
  const StudentDetailPage({
    super.key,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetStudentDetailBloc>()
        ..add(
          GetStudentDetailEvent(
            studentId: studentId,
          ),
        ),
      child: const _StudentDetailPageBody(),
    );
  }
}

class _StudentDetailPageBody extends StatefulWidget {
  const _StudentDetailPageBody();

  @override
  State<_StudentDetailPageBody> createState() => __StudentDetailPageBodyState();
}

class __StudentDetailPageBodyState extends State<_StudentDetailPageBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SPColors.colorFAFAFA,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
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
                      'Detail Siswa',
                      style: SPTextStyles.text18W400303030,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: BlocBuilder<GetStudentDetailBloc, GetStudentDetailState>(
                  builder: (context, state) {
                    if (state is GetStudentDetailSuccess) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(16),
                            ),
                            child: Container(
                              width: 94,
                              height: 94,
                              color: SPColors.colorC8A8DA.withOpacity(0.2),
                              child: CachedNetworkImage(
                                imageUrl:
                                    state.studentDetail.studentPhoto ?? '',
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                errorWidget: (_, __, ___) => const Icon(
                                  Icons.image_not_supported,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            state.studentDetail.studentName ?? '-',
                            style: SPTextStyles.text14W400303030,
                          ),
                          const SizedBox(height: 24),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                              ),
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    const SizedBox(height: 8),
                                    Text(
                                      'Biodata Siswa',
                                      style: SPTextStyles.text14W400303030,
                                    ),
                                    const SizedBox(height: 16),
                                    _DataTile(
                                      label: 'Nama Lengkap',
                                      value: state.studentDetail.studentName ??
                                          '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'NIPD',
                                      value: state.studentDetail.nipd ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'NISN',
                                      value: state.studentDetail.nisn ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'Gender',
                                      value: state.studentDetail.gender ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'Tempat Lahir',
                                      value: state.studentDetail.tempatLahir ??
                                          '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'Tanggal Lahir',
                                      value: state.studentDetail.tanggalLahir ??
                                          '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'NIK',
                                      value: state.studentDetail.nik ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'Religion',
                                      value:
                                          state.studentDetail.religion ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                    _DataTile(
                                      label: 'Religion',
                                      value: state.studentDetail.address ?? '-',
                                    ),
                                    const SizedBox(height: 8),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      );
                    }

                    if (state is GetStudentDetailError) {
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
    );
  }
}

class _DataTile extends StatelessWidget {
  final String label;
  final String value;
  const _DataTile({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: SPColors.colorF0F0F0,
        ),
      ),
      child: Row(
        children: [
          Text(
            label,
            style: SPTextStyles.text10W400B3B3B3,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              style: SPTextStyles.text10W400333333,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
