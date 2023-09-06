import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/bloc/get_daily_reports/get_daily_reports_bloc.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/model/students_response_model.dart';
import 'package:sapa_sekolah_guru/presentation/report_student/widget/report_daily.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportStudentPage extends StatefulWidget {
  final StudentModel student;
  const ReportStudentPage({
    super.key,
    required this.student,
  });

  @override
  State<ReportStudentPage> createState() => _ReportStudentPageState();
}

class _ReportStudentPageState extends State<ReportStudentPage>
    with SingleTickerProviderStateMixin {
  int index = 0;
  late TabController _tabController;

  final _tabs = [
    const Tab(text: 'Harian'),
    const Tab(text: 'Bulanan'),
    const Tab(text: 'Semester'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            padding: const EdgeInsets.all(16),
            child: Column(
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
                      'Laporan Siswa',
                      style: SPTextStyles.text18W400303030,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                Container(
                  height: kToolbarHeight - 8.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: SPColors.colorFFE5C0,
                    ),
                    unselectedLabelColor: SPColors.colorB3B3B3,
                    labelStyle: SPTextStyles.text12W400636363,
                    unselectedLabelStyle: SPTextStyles.text12W400B3B3B3,
                    tabs: _tabs,
                    onTap: (value) => setState(() {
                      index = value;
                    }),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Column(
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: IndexedStack(
                    index: index,
                    children: [
                      BlocProvider(
                        create: (context) => GetIt.instance
                            .get<GetDailyReportsBloc>()
                          ..add(
                            GetDailyReportsEvent(
                              studentId: widget.student.studentId.toString(),
                            ),
                          ),
                        child: ReportDaily(
                          student: widget.student,
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Laporan Bulanan\nAkan Datang',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Center(
                        child: Text(
                          'Laporan Montessori\nAkan Datang',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
