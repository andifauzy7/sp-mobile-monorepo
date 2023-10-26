import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/monthly_reports_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/report_repository.dart';

part 'get_monthly_reports_event.dart';
part 'get_monthly_reports_state.dart';

@injectable
class GetMonthlyReportsBloc
    extends Bloc<GetMonthlyReportsEvent, GetMonthlyReportsState> {
  final ReportRepository reportRepository;
  GetMonthlyReportsBloc({
    required this.reportRepository,
  }) : super(GetMonthlyReportsInitial()) {
    on<GetMonthlyReportsEvent>((event, emit) async {
      emit(GetMonthlyReportsLoading());
      final result = await reportRepository.getMonthlyReports(
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetMonthlyReportsError(
          message: failure.toString(),
        )),
        (reports) => emit(GetMonthlyReportsSuccess(
          reports: reports,
        )),
      );
    });
  }
}
