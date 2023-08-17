import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
