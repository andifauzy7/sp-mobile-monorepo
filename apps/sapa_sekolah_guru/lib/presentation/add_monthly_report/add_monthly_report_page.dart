import 'package:flutter/material.dart';
import 'package:sapa_component/animation/sp_switcher_animation.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/button/sp_elevated_button.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/form/sp_text_field.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/other/sp_failure_widget.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/bloc/get_monthly_report_component/get_monthly_report_component_bloc.dart';
import 'package:sapa_sekolah_guru/bloc/update_monthly_report/update_monthly_report_bloc.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';

class AddMonthlyReportPage extends StatelessWidget {
  final StudentModel student;
  const AddMonthlyReportPage({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              GetIt.instance.get<GetMonthlyReportComponentBloc>()
                ..add(
                  GetMonthlyReportComponentEvent(),
                ),
        ),
        BlocProvider(
          create: (context) => GetIt.instance.get<UpdateMonthlyReportBloc>(),
        ),
      ],
      child: _AddMonthlyReportPageBody(student),
    );
  }
}

class _AddMonthlyReportPageBody extends StatefulWidget {
  final StudentModel student;
  const _AddMonthlyReportPageBody(this.student);

  @override
  State<_AddMonthlyReportPageBody> createState() =>
      _AddMonthlyReportPageBodyState();
}

class _AddMonthlyReportPageBodyState extends State<_AddMonthlyReportPageBody> {
  DateTime dateTime = DateTime.now();
  List<TextEditingController> controllers = [];
  static List<Color> colors = [
    SPColors.color8CC2F0,
    SPColors.color6FCF97,
    SPColors.colorEB5757,
    SPColors.colorF942A5,
  ];

  Future<void> _confirmCreate(
    BuildContext context, {
    required String studentId,
    required String reportDate,
    required List<Map<String, String>> reportMonthly,
  }) async {
    await SPDialog.showDefault(
      context,
      children: [
        Text(
          'Yakin untuk membuat laporan bulanan?',
          textAlign: TextAlign.center,
          style: SPTextStyles.text14W400636363,
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Expanded(
              child: SPElevatedButton(
                text: 'Kembali',
                type: SPElevatedButtonType.secondary,
                onPressed: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: SPElevatedButton(
                text: 'Yakin',
                onPressed: () {
                  BlocProvider.of<UpdateMonthlyReportBloc>(context).add(
                    UpdateMonthlyReportEvent(
                      reportDate: reportDate,
                      studentId: studentId,
                      reportMonthly: reportMonthly,
                    ),
                  );
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateMonthlyReportBloc, UpdateMonthlyReportState>(
      listener: (context, state) async {
        if (state is UpdateMonthlyReportLoading) {
          SPDialog.showDefaultLoading(context);
        }

        if (state is UpdateMonthlyReportError) {
          Navigator.pop(context);
          SPDialog.showFailure(
            context,
            message: state.message,
          );
        }

        if (state is UpdateMonthlyReportSuccess) {
          Navigator.pop(context);
          await SPDialog.showSuccess(
            context,
            message: 'Yeay! Anda berhasil membuat laporan bulanan',
          ).then(
            (value) => Navigator.pop(context, true),
          );
        }
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
                  const SPAppBar(title: 'Laporan Bulanan'),
                  const SizedBox(height: 16),
                  Expanded(
                    child: BlocBuilder<GetMonthlyReportComponentBloc,
                        GetMonthlyReportComponentState>(
                      builder: (context, state) {
                        Widget renderWidget = const Center(
                          child: CircularProgressIndicator(),
                        );

                        if (state is GetMonthlyReportComponentSuccess) {
                          for (int i = 0; i < state.components.length; i++) {
                            controllers.add(TextEditingController());
                          }

                          renderWidget = ListView(
                            physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
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
                                    Text(
                                      'Nama',
                                      style: SPTextStyles.text12W400B3B3B3,
                                    ),
                                    Text(
                                      widget.student.studentName ?? '-',
                                      style: SPTextStyles.text14W400303030,
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              Container(
                                padding: const EdgeInsets.all(16),
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
                                    Text(
                                      'Tanggal',
                                      style: SPTextStyles.text12W400B3B3B3,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        DateTime? result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime.utc(2010, 10, 16),
                                          lastDate: DateTime.now(),
                                        );

                                        if (result != null) {
                                          setState(() {
                                            dateTime = result;
                                          });
                                        }
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            DateFormat('d MMMM y', 'id_ID')
                                                .format(
                                              dateTime,
                                            ),
                                            style:
                                                SPTextStyles.text14W400303030,
                                          ),
                                          SvgPicture.asset(
                                            SPAssets.icon.calendarPicker.path,
                                            package: spComponentPackage,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount: state.components.length,
                                separatorBuilder: (context, index) =>
                                    const SizedBox(height: 12),
                                itemBuilder: (context, index) => Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    boxShadow: SPShadow.shadowGrey,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.components[index]
                                                .reportMonthlyDetail ??
                                            '-',
                                        style: SPTextStyles.text12W400B3B3B3
                                            .copyWith(
                                          color: colors[index % colors.length],
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SPTextField(
                                        maxLines: 3,
                                        controller: controllers[index],
                                        hintText: 'Tulis penilaian ...',
                                        onChanged: (value) => {},
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          );
                        }

                        if (state is GetMonthlyReportComponentError) {
                          renderWidget = SPFailureWidget(
                            message: state.message,
                          );
                        }
                        return SPSwitcherAnimation(child: renderWidget);
                      },
                    ),
                  ),
                  BlocBuilder<GetMonthlyReportComponentBloc,
                      GetMonthlyReportComponentState>(
                    builder: (context, state) {
                      if (state is GetMonthlyReportComponentSuccess) {
                        return Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(top: 12),
                          child: SPElevatedButton(
                            onPressed: () {
                              List<Map<String, String>> reportMonthly = [];

                              for (int i = 0; i < controllers.length; i++) {
                                reportMonthly.add(
                                  {
                                    "component_id": state
                                        .components[i].cfgreportMonthlyId
                                        .toString(),
                                    "report_text": controllers[i].text,
                                  },
                                );
                              }

                              _confirmCreate(
                                context,
                                studentId: widget.student.studentId.toString(),
                                reportDate:
                                    DateFormat("yyyy-MM-dd").format(dateTime),
                                reportMonthly: reportMonthly,
                              );
                            },
                            text: 'Buat Laporan',
                          ),
                        );
                      }

                      return const SizedBox.shrink();
                    },
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
