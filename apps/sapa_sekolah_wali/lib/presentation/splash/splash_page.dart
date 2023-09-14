import 'package:flutter/material.dart';
import 'package:sapa_component/gen/assets.gen.dart';
import 'package:sapa_component/styles/sp_text_styles.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/presentation/login/login_page.dart';
import 'package:sapa_sekolah_wali/presentation/main/main_page.dart';
import 'package:sapa_sekolah_wali/presentation/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  void _navigateToLogin(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );

  void _navigateToMain(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const MainPage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<SplashCubit>()..checkSession(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            _navigateToMain(context);
          }

          if (state is SplashError) {
            _navigateToLogin(context);
          }
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(
                      SPAssets.images.splashBackground.path,
                      package: spComponentPackage,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(64),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      SPAssets.images.splashOrnament.path,
                      package: spComponentPackage,
                    ),
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 172,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 32,
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            SPAssets.images.splashWelcome.path,
                            package: spComponentPackage,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Selamat Datang di\nAplikasi SAPA Sekolah',
                      textAlign: TextAlign.center,
                      style: SPTextStyles.text16W400303030,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
