import 'package:flutter/material.dart';
import 'package:sapa_component/app_bar/sp_app_bar.dart';
import 'package:sapa_component/card/card_name.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/other/sp_container_image.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_shadow.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/bloc/get_daily_reports/get_daily_reports_bloc.dart';
import 'package:sapa_sekolah_wali/bloc/get_monthly_reports/get_monthly_reports_bloc.dart';
import 'package:sapa_sekolah_wali/model/students_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/report/widget/report_monthly.dart';

import 'widget/report_daily.dart';

class ReportPage extends StatefulWidget {
  final StudentModel student;
  const ReportPage({super.key, required this.student});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>
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
      backgroundColor: SPColors.colorFAFAFA,
      body: SPContainerImage(
        imageUrl: SPAssets.images.circleBackground.path,
        package: spComponentPackage,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SPAppBar(title: 'Laporan'),
                const SizedBox(height: 24),
                Container(
                  height: kToolbarHeight - 8.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: SPShadow.shadowGrey,
                  ),
                  child: TabBar(
                    controller: _tabController,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: SPColors.colorC8A8DA,
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
                const SizedBox(height: 16),
                CardName(
                  name: widget.student.studentName ?? '-',
                ),
                const SizedBox(height: 16),
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
                      BlocProvider(
                        create: (context) => GetIt.instance
                            .get<GetMonthlyReportsBloc>()
                          ..add(
                            GetMonthlyReportsEvent(
                              studentId: widget.student.studentId.toString(),
                            ),
                          ),
                        child: ReportMonthly(
                          student: widget.student,
                        ),
                      ),
                      Center(
                        child: Text(
                          'Laporan Montessori\nAkan Datang',
                          textAlign: TextAlign.center,
                          style: SPTextStyles.text14W400B3B3B3,
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
