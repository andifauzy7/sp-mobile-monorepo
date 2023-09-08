import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sapa_sekolah_wali/dependency.dart';
import 'package:sapa_sekolah_wali/presentation/utils/routes/route_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sapa Sekolah',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      onGenerateRoute: RouterUtils.onGenerateRoute,
    );
  }
}
