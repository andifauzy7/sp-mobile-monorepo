import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/injection/injection.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  initializeDateFormatting();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: MaterialApp(
        title: 'SAPA Guru',
        navigatorKey: GetIt.instance.get<Alice>().getNavigatorKey(),
        theme: ThemeData(
          primarySwatch: getMaterialColor(
            SPColors.colorFFE5C0,
          ),
        ),
        home: const SplashPage(),
      ),
    );
  }
}