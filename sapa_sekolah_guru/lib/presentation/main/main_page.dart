import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/forgot_password/forgot_password_page.dart';
import 'package:sapa_sekolah_guru/presentation/home/home_page.dart';
import 'package:sapa_sekolah_guru/presentation/main/widget/menu_card.dart';
import 'package:sapa_sekolah_guru/presentation/main/widget/profile_page.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/lesson_plan_page.dart';
import 'package:sapa_sekolah_guru/presentation/permission/permission_page.dart';
import 'package:sapa_sekolah_guru/presentation/report/report_page.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_guru/presentation/student_presence/student_presence_page.dart';
import 'package:sapa_sekolah_guru/shared/component/form/sp_text_field.dart';
import 'package:sapa_sekolah_guru/shared/component/other/sp_icon_button.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_colors.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          const HomePage(),
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
                            imageUrl:
                                Assets.images.forgotPasswordBackground.path,
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
      ),
    );
  }
}
