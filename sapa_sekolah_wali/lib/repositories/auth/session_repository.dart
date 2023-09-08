import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:injectable/injectable.dart';

@injectable
class SessionRepository {
  Future<bool> checkSession() async {
    EncryptedSharedPreferences esp = EncryptedSharedPreferences();
    final sp = await esp.getInstance();
    return sp.getString('token') != null;
  }

}
