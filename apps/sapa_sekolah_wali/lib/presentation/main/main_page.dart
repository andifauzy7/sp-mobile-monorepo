import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_sekolah_wali/presentation/forgot_password/forgot_password_page.dart';
import 'package:sapa_sekolah_wali/presentation/home/home_page.dart';
import 'package:sapa_sekolah_wali/presentation/menu/menu_page.dart';
import 'package:sapa_sekolah_wali/presentation/profile/profile_page.dart';
import 'package:sapa_sekolah_wali/presentation/splash/splash_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: [
          const HomePage(),
          const MenuPage(),
          ProfilePage(
            onLogout: () => _navigateToSplash(context),
            onChangePassword: () => _navigateToForgotPasswordPage(context),
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