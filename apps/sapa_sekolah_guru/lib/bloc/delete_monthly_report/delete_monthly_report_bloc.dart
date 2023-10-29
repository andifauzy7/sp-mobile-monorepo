import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/report_repository.dart';

part 'delete_monthly_report_event.dart';
part 'delete_monthly_report_state.dart';

@injectable
class DeleteMonthlyReportBloc
    extends Bloc<DeleteMonthlyReportEvent, DeleteMonthlyReportState> {
  final ReportRepository reportRepository;
  DeleteMonthlyReportBloc({
    required this.reportRepository,
  }) : super(DeleteMonthlyReportInitial()) {
    on<DeleteMonthlyReportEvent>((event, emit) async {
      emit(DeleteMonthlyReportLoading());
      final result = await reportRepository.deleteMonthlyReport(
        event.reportId,
      );
      result.fold(
        (failure) => emit(DeleteMonthlyReportError(
          message: failure.toString(),
        )),
        (_) => emit(DeleteMonthlyReportSuccess()),
      );
    });
  }
}
