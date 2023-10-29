import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_wali/repositories/report_repository.dart';

part 'add_monthly_report_response_event.dart';
part 'add_monthly_report_response_state.dart';

@injectable
class AddMonthlyReportResponseBloc
    extends Bloc<AddMonthlyReportResponseEvent, AddMonthlyReportResponseState> {
  final ReportRepository reportRepository;
  AddMonthlyReportResponseBloc({
    required this.reportRepository,
  }) : super(AddMonthlyReportResponseInitial()) {
    on<AddMonthlyReportResponseEvent>((event, emit) async {
      emit(AddMonthlyReportResponseLoading());
      final result = await reportRepository.addMonthlyReportResponse(
        event.reportId,
        event.studentId,
        event.message,
      );
      result.fold(
        (failure) => emit(AddMonthlyReportResponseError(
          message: failure.toString(),
        )),
        (_) => emit(AddMonthlyReportResponseSuccess()),
      );
    });
  }
}
