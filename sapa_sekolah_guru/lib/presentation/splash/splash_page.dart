import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sapa_sekolah_guru/gen/assets.gen.dart';
import 'package:sapa_sekolah_guru/presentation/home/home_page.dart';
import 'package:sapa_sekolah_guru/presentation/login/login_page.dart';
import 'package:sapa_sekolah_guru/presentation/splash/cubit/splash_cubit.dart';
import 'package:sapa_sekolah_guru/shared/component/styles/sp_text_styles.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  void _navigateToLogin(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const LoginPage(),
        ),
      );

  void _navigateToHome(
    BuildContext context,
  ) =>
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.instance.get<SplashCubit>()..checkSession(),
      child: BlocListener<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashSuccess) {
            _navigateToHome(context);
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
                      Assets.images.splashBackground.path,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(64),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      Assets.images.splashOrnament.path,
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
                            Assets.images.splashWelcome.path,
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
