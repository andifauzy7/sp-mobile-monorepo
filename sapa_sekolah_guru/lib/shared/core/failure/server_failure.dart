import 'package:sapa_sekolah_guru/shared/core/failure/failure.dart';

class ServerFailure extends Failure {
  final String? message;
  final int? statusCode;

  ServerFailure({
    this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return message ?? super.toString();
  }
}
