import 'package:flutter/material.dart';
import 'package:sapa_sekolah_wali/presentation/pages/auth/change_password_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/auth/login_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/detail_bill_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/detail_child_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/detail_teacher_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/list_bill_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/list_child_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/bill/list_teacher_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/global/onboarding_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/global/splash_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/home/home_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/report/add_parent_opinion_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/report/daily_report_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/report/monthly_report_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/report/semester_report_page.dart';
import 'package:sapa_sekolah_wali/presentation/pages/schedule/study_schedule_page.dart';

import '../../../repositories/auth/session_repository.dart';
import '../../pages/global/not_found_page.dart';

class RouteName {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String home = '/home';
  static const String studySchedule = '/study-schedule';
  static const String listBill = '/list-bill';
  static const String listChild = '/list-child';
  static const String listTeacher = '/list-teacher';
  static const String detailBill = '/detail-bill';
  static const String detailChild = '/detail-child';
  static const String detailTeacher = '/detail-teacher';
  static const String changePassword = '/change-password';
  static const String addParentOpinion = '/parent-opinion';
  static const String reportDaily = '/report-daily';
  static const String reportMonthly = '/report-monthly';
  static const String reportSemester = '/report-semester';
}

class RouterUtils {
  static bool currentSession = false;

  static const List<String> guarded = [];

  static Map<String, Widget Function(Object?)> mapRoutes = {
    RouteName.splash: (arguments) => const SplashPage(),
    RouteName.onboarding: (arguments) => const OnboardingPage(),
    RouteName.login: (arguments) => const LoginPage(),
    RouteName.home: (argumenst) => const HomePage(),
    RouteName.studySchedule: (arguments) => const StudySchedulePage(),
    RouteName.listChild: (arguments) =>
        ListChildPage(direction: (arguments as String?)),
    RouteName.listTeacher: (arguments) => const ListTeacherPage(),
    RouteName.listBill: (arguments) =>
        ListBillPage(studentId: (arguments as int?)),
    RouteName.detailChild: (arguments) =>
        DetailChildPage(studentId: (arguments as int)),
    RouteName.detailTeacher: (arguments) => const DetailTeacherPage(),
    RouteName.detailBill: (arguments) {
      final payload = (arguments as Map);
      return DetailBillPage(
        studentId: payload['student_id'],
        paymentId: payload['payment_id'],
      );
    },
    RouteName.changePassword: (arguments) => ChangePasswordPage(),
    RouteName.reportDaily: (arguments) => const DailyReportPage(),
    RouteName.reportMonthly: (arguments) => const MonthlyReportPage(),
    RouteName.addParentOpinion: (arguments) => const AddParentOpinionPage(),
    RouteName.reportSemester: (arguments) => const SemesterReportPage(),
  };

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    if (guarded.contains(settings.name)) {
      SessionRepository().checkSession().then((data) {
        currentSession = data;
      });

      return MaterialPageRoute(
        builder: (context) => currentSession
            ? mapRoutes[settings.name]!(settings.arguments)
            : mapRoutes[RouteName.login]!(settings.arguments),
      );
    } else {
      return MaterialPageRoute(
        builder: (context) => generateWidget(
            routeName: settings.name, arguments: settings.arguments),
      );
    }
  }

  static Widget generateWidget({String? routeName, Object? arguments}) {
    return mapRoutes[routeName] != null
        ? mapRoutes[routeName]!(arguments)
        : const NotFoundPage();
  }
}
