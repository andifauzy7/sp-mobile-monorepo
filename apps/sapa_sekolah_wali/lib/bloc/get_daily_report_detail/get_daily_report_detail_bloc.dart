import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/daily_report_detail_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/report_repository.dart';

part 'get_daily_report_detail_event.dart';
part 'get_daily_report_detail_state.dart';

@injectable
class GetDailyReportDetailBloc
    extends Bloc<GetDailyReportDetailEvent, GetDailyReportDetailState> {
  final ReportRepository reportRepository;
  GetDailyReportDetailBloc({
    required this.reportRepository,
  }) : super(GetDailyReportDetailInitial()) {
    on<GetDailyReportDetailEvent>((event, emit) async {
      emit(GetDailyReportDetailLoading());
      final result = await reportRepository.getDailyReportDetail(
        event.reportId,
      );
      result.fold(
        (failure) => emit(GetDailyReportDetailError(
          message: failure.toString(),
        )),
        (report) => emit(GetDailyReportDetailSuccess(
          report: report,
        )),
      );
    });
  }
}
