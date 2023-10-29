import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/model/monthly_report_detail_response_model.dart';
import 'package:sapa_sekolah_wali/repositories/report_repository.dart';

part 'get_monthly_report_detail_event.dart';
part 'get_monthly_report_detail_state.dart';

@injectable
class GetMonthlyReportDetailBloc
    extends Bloc<GetMonthlyReportDetailEvent, GetMonthlyReportDetailState> {
  final ReportRepository reportRepository;
  GetMonthlyReportDetailBloc({required this.reportRepository})
      : super(GetMonthlyReportDetailInitial()) {
    on<GetMonthlyReportDetailEvent>((event, emit) async {
      emit(GetMonthlyReportDetailLoading());
      final result = await reportRepository.getMonthlyReportDetail(
        event.reportId,
        event.studentId,
      );
      result.fold(
        (failure) => emit(GetMonthlyReportDetailError(
          message: failure.toString(),
        )),
        (report) => emit(GetMonthlyReportDetailSuccess(
          report: report,
        )),
      );
    });
  }
}
