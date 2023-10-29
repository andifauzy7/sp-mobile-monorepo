import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/report_repository.dart';

part 'update_monthly_report_event.dart';
part 'update_monthly_report_state.dart';

@injectable
class UpdateMonthlyReportBloc
    extends Bloc<UpdateMonthlyReportEvent, UpdateMonthlyReportState> {
  final ReportRepository reportRepository;
  UpdateMonthlyReportBloc({
    required this.reportRepository,
  }) : super(UpdateMonthlyReportInitial()) {
    on<UpdateMonthlyReportEvent>((event, emit) async {
      emit(UpdateMonthlyReportLoading());
      final result = await reportRepository.updateMonthlyReport(
        event.reportMonthlyId,
        event.reportDate,
        event.studentId,
        event.reportMonthly,
      );
      result.fold(
        (failure) => emit(UpdateMonthlyReportError(
          message: failure.toString(),
        )),
        (_) => emit(UpdateMonthlyReportSuccess()),
      );
    });
  }
}
