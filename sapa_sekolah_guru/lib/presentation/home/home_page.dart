import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/forgot_password/forgot_password_page.dart';
import 'package:sapa_sekolah_guru/presentation/home/widget/menu_card.dart';
import 'package:sapa_sekolah_guru/presentation/home/widget/profile_page.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/lesson_plan_page.dart';
import 'package:sapa_sekolah_guru/presentation/permission/permission_page.dart';
import 'package:sapa_sekolah_guru/presentation/report/report_page.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_guru/presentation/student_presence/student_presence_page.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PersistentTabController _controller;

  void _navigateToLessonPlan(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LessonPlanPage(),
        ),
      );

  void _navigateToReportPage(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ReportPage(),
        ),
      );

  void _navigateToForgotPasswordPage(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ForgotPasswordPage(),
        ),
      );

  void _navigateToStudentPresence(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const StudentPresencePage(),
        ),
      );

  void _navigateToSplash(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashPage(),
        ),
      );

  void _navigateToPermission(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const PermissionPage(),
        ),
      );

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: [
        Container(
          color: SPColors.colorFAFAFA,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hallo Restu Putri',
                              style: SPTextStyles.text12W400636363,
                            ),
                            Text(
                              'Good Morning',
                              style: SPTextStyles.text20W400303030,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: SPIconButton(
                          url: Assets.icon.notification.path,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(15),
                        ),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: Image.network(
                            "https://cdn.antaranews.com/cache/1200x800/2022/05/10/Screen-Shot-2022-05-09-at-10.04.13-AM_copy_1024x682.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    children: [
                      SPIconButton(
                        url: Assets.icon.filter.path,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: SPTextField(
                          hintText: 'Search',
                          suffix: SvgPicture.asset(
                            Assets.icon.searchNormal.path,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    'Absensi Guru',
                    style: SPTextStyles.text16W400303030,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        SPIconButton(
                          url: Assets.icon.edit.path,
                          color: SPColors.color6FCF97,
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Restu Putri',
                                style: SPTextStyles.text14W400303030,
                              ),
                              Text(
                                '02 Juli, 2023',
                                style: SPTextStyles.text10W400B3B3B3,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Text(
                          'Absen',
                          style: SPTextStyles.text12W4006FCF97,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pelajaran Hari Ini',
                          style: SPTextStyles.text16W400808080,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dimulai Pada',
                              style: SPTextStyles.text12W400636363,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  Assets.icon.timer.path,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  '07 : 25 AM',
                                  style: SPTextStyles.text12W400636363,
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Bahasa Inggris',
                                    style: SPTextStyles.text12W400636363,
                                  ),
                                  Text(
                                    'Kelas 7B, 02 Agu, 2023',
                                    style: SPTextStyles.text10W400B3B3B3,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Container(
            color: SPColors.colorFAFAFA,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Menu',
                    style: SPTextStyles.text18W400303030,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Expanded(
                  child: GridView.count(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    primary: false,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    crossAxisCount: 2,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => _navigateToStudentPresence(context),
                        child: MenuCard(
                          title: 'Absensi',
                          description: 'Absensi Siswa',
                          imageUrl: Assets.images.attendanceStudentImage.path,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToPermission(context),
                        child: MenuCard(
                          title: 'Izin Murid',
                          description: 'Memberikan Izin\nKepada Murid',
                          imageUrl: Assets.images.permissionImage.path,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToLessonPlan(context),
                        child: MenuCard(
                          title: 'Lesson Plan',
                          description: 'Buat Plan',
                          imageUrl: Assets.images.lessonImage.path,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToReportPage(context),
                        child: MenuCard(
                          title: 'Laporan',
                          description: 'Berisi Laporan\nPeriodik',
                          imageUrl: Assets.images.reportImage.path,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToForgotPasswordPage(context),
                        child: MenuCard(
                          title: 'Ubah Sandi',
                          description: 'Ubah Kata\nSandi',
                          imageUrl: Assets.images.forgotPasswordBackground.path,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        ProfilePage(
          onLogout: () => _navigateToSplash(context),
        ),
      ],
      items: [
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            Assets.icon.home.path,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(Assets.icon.filter.path),
          activeColorPrimary: Colors.white,
        ),
        PersistentBottomNavBarItem(
          icon: SvgPicture.asset(
            Assets.icon.profile.path,
            colorFilter: const ColorFilter.mode(
              Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(0.0),
        colorBehindNavBar: Colors.white,
      ),
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style15,
      backgroundColor: SPColors.colorFFE5C0,
    );
  }
}
