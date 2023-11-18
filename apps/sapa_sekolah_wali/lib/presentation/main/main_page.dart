import 'package:flutter/material.dart';
import 'package:sapa_component/dialog/sp_dialog.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/image/sp_cached_network_image.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_sekolah_wali/model/news_response_model.dart';
import 'package:sapa_sekolah_wali/presentation/consultations/consultations_page.dart';
import 'package:sapa_sekolah_wali/presentation/forgot_password/forgot_password_page.dart';
import 'package:sapa_sekolah_wali/presentation/home/home_page.dart';
import 'package:sapa_sekolah_wali/presentation/menu/menu_page.dart';
import 'package:sapa_sekolah_wali/presentation/news/news_page.dart';
import 'package:sapa_sekolah_wali/presentation/news_detail/news_detail_page.dart';
import 'package:sapa_sekolah_wali/presentation/profile/profile_page.dart';
import 'package:sapa_sekolah_wali/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_wali/presentation/students/students_page.dart';
import 'package:sapa_sekolah_wali/presentation/teachers/teachers_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late PersistentTabController _controller;

  @override
  void initState() {
    _controller = PersistentTabController(initialIndex: 0);
    super.initState();
  }

  void _navigateToSplash(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SplashPage(),
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

  void _navigateToStudentsPage(
    BuildContext context, {
    required StudentsPagePurpose pagePurpose,
  }) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => StudentsPage(
            pagePurpose: pagePurpose,
          ),
        ),
      );

  void _navigateToTeachersPage(
    BuildContext context,
  ) =>
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const TeachersPage(),
        ),
      );

  Future<void> _navigateToNews(
    BuildContext context, {
    required List<NewsModel> news,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NewsPage(
          news: news,
        ),
      ),
    );
  }

  Future<void> _navigateToNewsDetail(
    BuildContext context, {
    required NewsModel news,
  }) async {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => NewsDetailPage(
          news: news,
        ),
      ),
    );
  }

  Future<void> _showNewsDetail(
    BuildContext context, {
    required NewsModel news,
  }) async {
    SPDialog.showDefault(
      context,
      children: [
        Text(
          'Detail Informasi',
          style: SPTextStyles.text14W400636363,
        ),
        const SizedBox(height: 16),
        SPCachedNetworkImage(
          imageUrl: news.newsImage ?? '',
          width: double.infinity,
          height: MediaQuery.of(context).size.width * 0.3,
        ),
        const SizedBox(height: 16),
        Text(
          news.newsTitle ?? '-',
          style: SPTextStyles.text12W400303030,
        ),
        const SizedBox(height: 8),
        Text(
          "-",
          style: SPTextStyles.text12W400B3B3B3,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          HomePage(
            onViewAll: (news) => _navigateToNews(
              context,
              news: news,
            ),
            onDetail: (news) => _showNewsDetail(
              context,
              news: news,
            ),
          ),
          MenuPage(
            onChildrenData: () => _navigateToStudentsPage(
              context,
              pagePurpose: StudentsPagePurpose.childrenData,
            ),
            onTeacherData: () => _navigateToTeachersPage(
              context,
            ),
            onPaymentData: () => _navigateToStudentsPage(
              context,
              pagePurpose: StudentsPagePurpose.paymentData,
            ),
            onReportData: () => _navigateToStudentsPage(
              context,
              pagePurpose: StudentsPagePurpose.reportData,
            ),
            onAttendance: () => _navigateToStudentsPage(
              context,
              pagePurpose: StudentsPagePurpose.attendanceData,
            ),
            onLessonPlan: () => _navigateToStudentsPage(
              context,
              pagePurpose: StudentsPagePurpose.lessonPlan,
            ),
            onConsultation: () => _navigateToConsultation(context),
          ),
          ProfilePage(
            onLogout: () => _navigateToSplash(
              context,
            ),
            onChangePassword: () => _navigateToForgotPasswordPage(
              context,
            ),
          ),
        ],
        items: [
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.home.path,
              package: 'sapa_component',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
            ),
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.filter.path,
              package: 'sapa_component',
            ),
            activeColorPrimary: Colors.white,
          ),
          PersistentBottomNavBarItem(
            icon: SvgPicture.asset(
              SPAssets.icon.profile.path,
              package: 'sapa_component',
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
        backgroundColor: SPColors.colorC8A8DA,
      ),
    );
  }
}
