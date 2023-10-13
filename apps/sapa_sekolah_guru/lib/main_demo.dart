import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sapa_component/sapa_component.dart';
import 'package:sapa_component/styles/sp_colors.dart';
import 'package:sapa_component/utils/utils.dart';
import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/injection/injection.dart';
import 'package:sapa_sekolah_guru/presentation/splash/splash_page.dart';
import 'package:sapa_sekolah_guru/shared/constant/core_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlavorConfig(
    name: CoreConstant.demo,
    variables: {
      CoreConstant.keyBaseUrl: CoreConstant.demoBaseUrl,
    },
  );
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
      child: FlavorBanner(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Guru Demo',
          navigatorKey: GetIt.instance.get<Alice>().getNavigatorKey(),
          theme: ThemeData(
            primarySwatch: getMaterialColor(
              SPColors.colorFFE5C0,
            ),
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
