import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/injection/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();
