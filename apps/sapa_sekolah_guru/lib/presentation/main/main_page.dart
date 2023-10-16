import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_sekolah_guru/presentation/consultations/consultations_page.dart';
import 'package:sapa_sekolah_guru/presentation/forgot_password/forgot_password_page.dart';
import 'package:sapa_sekolah_guru/presentation/home/home_page.dart';
import 'package:sapa_sekolah_guru/presentation/menu/menu_page.dart';
import 'package:sapa_sekolah_guru/presentation/profile/profile_page.dart';
import 'package:sapa_sekolah_guru/presentation/lesson_plan/lesson_plan_page.dart';
import 'package:sapa_sekolah_guru/presentation/permission/permission_page.dart';
import 'package:sapa_sekolah_guru/presentation/report/report_page.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_guru/presentation/student_presence/student_presence_page.dart';

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

  void _navigateToConsultation(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const ConsultationsPage(),
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
          MenuPage(
            onPresence: () => _navigateToStudentPresence(context),
            onPermit: () => _navigateToPermission(context),
            onLessonPlan: () => _navigateToLessonPlan(context),
            onReport: () => _navigateToReportPage(context),
            onConsultation: () => _navigateToConsultation(context),
          ),
          ProfilePage(
            onLogout: () => _navigateToSplash(context),
            onChangePassword: () => _navigateToForgotPasswordPage(context),
          ),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.home.path,
              package: spComponentPackage,
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.filter.path,
              package: spComponentPackage,
            ),
            activeColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.profile.path,
              package: spComponentPackage,
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
