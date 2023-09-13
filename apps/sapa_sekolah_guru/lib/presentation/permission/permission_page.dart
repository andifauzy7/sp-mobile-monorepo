import 'package:flutter/material.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/other/sp_icon_button.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/add_permit/add_permit_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_permit_type/get_permit_type_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_student_permits/get_student_permits_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/get_students/get_students_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/permission/widget/create_permission.dart';

class PermissionPage extends StatelessWidget {
  const PermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<GetStudentPermitsBloc>()
        ..add(
          GetStudentPermitsEvent(),
        ),
      child: const _PermissionPageBody(),
    );
  }
}

class _PermissionPageBody extends StatelessWidget {
  const _PermissionPageBody();

  void _createPermissionDialog(BuildContext context) async =>
      await SPDialog.showDefault(
        context,
        children: [
          MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => GetIt.instance.get<GetStudentsBloc>()
                  ..add(
                    GetStudentsEvent(),
                  ),
              ),
              BlocProvider(
                create: (_) => GetIt.instance.get<GetPermitTypeBloc>()
                  ..add(
                    GetPermitTypeEvent(),
                  ),
              ),
              BlocProvider(
                create: (_) => GetIt.instance.get<AddPermitBloc>(),
              ),
            ],
            child: CreatePermission(
              onSuccess: () =>
                  BlocProvider.of<GetStudentPermitsBloc>(context).add(
                GetStudentPermitsEvent(),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        BlocProvider.of<GetStudentPermitsBloc>(context).add(
          GetStudentPermitsEvent(),
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
                Assets.images.lessonPlanBackground.path,
              ),
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SPIconButton(
                        url: Assets.icon.arrowLeft.path,
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        'Izin Siswa',
                        style: SPTextStyles.text18W400303030,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(16),
                        ),
                      ),
                      child: BlocBuilder<GetStudentPermitsBloc,
                          GetStudentPermitsState>(
                        builder: (context, state) {
                          if (state is GetStudentPermitsError) {
                            return SPFailureWidget(message: state.message);
                          }

                          if (state is GetStudentPermitsSuccess) {
                            return ListView.separated(
                              physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              itemCount: state.permits.length,
                              separatorBuilder: (_, __) => const SizedBox(
                                height: 16,
                              ),
                              itemBuilder: (context, index) => Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              state.permits[index]
                                                      .studentName ??
                                                  '',
                                              style:
                                                  SPTextStyles.text14W400303030,
                                            ),
                                            Text(
                                              'Siswa',
                                              style:
                                                  SPTextStyles.text10W400B3B3B3,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Text(
                                            state.permits[index]
                                                    .studentLeaveName ??
                                                '',
                                            style:
                                                SPTextStyles.text12W400303030,
                                          ),
                                          Text(
                                            state.permits[index].startDate ==
                                                    state.permits[index].endDate
                                                ? DateFormat("dd MMM yyyy")
                                                    .format(DateTime.parse(state
                                                            .permits[index]
                                                            .startDate ??
                                                        ''))
                                                : '${DateFormat("dd MMM yyyy").format(DateTime.parse(state.permits[index].startDate ?? ''))} - ${DateFormat("dd MMM yyyy").format(DateTime.parse(state.permits[index].endDate ?? ''))}',
                                            style:
                                                SPTextStyles.text10W400B3B3B3,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }

                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ),
                  /*
                  Expanded(
                    child: ListView(
                      physics: const BouncingScrollPhysics(),
                      children: [
                        Container(
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Data Izin Siswa',
                                    style: SPTextStyles.text16W400303030,
                                  ),
                                  Text(
                                    'View Detail',
                                    style: SPTextStyles.text12W400B3B3B3,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15),
                                    ),
                                    child: SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Image.network(
                                        'https://www.timeshighereducation.com/sites/default/files/styles/article_teaser/public/shutterstock_508251865_resize.jpg?itok=4R835hL_',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Dani Carvajal',
                                          style: SPTextStyles.text14W400303030,
                                        ),
                                        Text(
                                          'Siswa, Kelas 7B',
                                          style: SPTextStyles.text10W400B3B3B3,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Sakit',
                                        style: SPTextStyles.text12W400303030,
                                      ),
                                      Text(
                                        '10 Aug 2023',
                                        style: SPTextStyles.text10W400B3B3B3,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                  ),*/
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: SPElevatedButton(
                      text: 'Tambah Data Izin',
                      onPressed: () => _createPermissionDialog(context),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
