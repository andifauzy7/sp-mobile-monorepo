import 'package:flutter/material.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';
import 'package:sapa_sekolah_wali/repositories/auth/session_repository.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final sessionRepository = getIt<SessionRepository>();

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    final isLoged = await sessionRepository.checkSession();
    // ignore: use_build_context_synchronously
    if (isLoged) Navigator.pushReplacementNamed(context, RouteName.home);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xfff2bfbf),
            Color(0xffe16cb3),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 265,
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(child: Container()),
              Text(
                'Sapa Sekolah',
                style: TextStyle(
                    fontSize: 16, color: Colors.white.withOpacity(0.7)),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RouteName.login);
                },
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Center(
                child: Icon(
                  Icons.keyboard_arrow_up_sharp,
                  color: Colors.white.withOpacity(0.7),
                  size: 48,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
