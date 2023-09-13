import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/repositories/report_repository.dart';

part 'update_daily_report_event.dart';
part 'update_daily_report_state.dart';

@injectable
class UpdateDailyReportBloc
    extends Bloc<UpdateDailyReportEvent, UpdateDailyReportState> {
  final ReportRepository reportRepository;
  UpdateDailyReportBloc({
    required this.reportRepository,
  }) : super(UpdateDailyReportInitial()) {
    on<UpdateDailyReportEvent>((event, emit) async {
      emit(UpdateDailyReportLoading());
      final result = await reportRepository.updateDailyReport(
        event.reportDailyId,
        event.reportDate,
        event.studentId,
        event.completeWork,
        event.qualityWork,
        event.needToWork,
        event.behaviorSchool,
        event.improvement,
      );
      result.fold(
        (failure) => emit(UpdateDailyReportError(
          message: failure.toString(),
        )),
        (_) => emit(UpdateDailyReportSuccess()),
      );
    });
  }
}
