import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/daily_reports_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/report_repository.dart';

part 'get_daily_reports_event.dart';
part 'get_daily_reports_state.dart';

@injectable
class GetDailyReportsBloc
    extends Bloc<GetDailyReportsEvent, GetDailyReportsState> {
  final ReportRepository reportRepository;
  GetDailyReportsBloc({
    required this.reportRepository,
  }) : super(GetDailyReportsInitial()) {
    on<GetDailyReportsEvent>((event, emit) async {
      emit(GetDailyReportsLoading());
      final result = await reportRepository.getDailyReports(
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetDailyReportsError(
          message: failure.toString(),
        )),
        (reports) => emit(GetDailyReportsSuccess(
          reports: reports,
        )),
      );
    });
  }
}
