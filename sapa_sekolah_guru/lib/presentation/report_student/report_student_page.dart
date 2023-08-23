import 'package:flutter/material.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/report_student/widget/report_daily.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class ReportStudentPage extends StatefulWidget {
  const ReportStudentPage({super.key});

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
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama',
                              style: SPTextStyles.text12W400B3B3B3,
                            ),
                            Text(
                              'Fernai Bitly',
                              style: SPTextStyles.text14W400303030,
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'Kelas 7B',
                        style: SPTextStyles.text12W400B3B3B3,
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
                    children: const [
                      ReportDaily(),
                      Center(
                        child: Text(
                          'Laporan Bulanan\nAkan Datang',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
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
