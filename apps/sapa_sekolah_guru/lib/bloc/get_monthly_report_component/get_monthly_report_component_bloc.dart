import 'package:sapa_core/sapa_core.dart';
import 'package:sapa_sekolah_guru/model/monthly_report_component_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/report_repository.dart';

part 'get_monthly_report_component_event.dart';
part 'get_monthly_report_component_state.dart';

@injectable
class GetMonthlyReportComponentBloc extends Bloc<GetMonthlyReportComponentEvent,
    GetMonthlyReportComponentState> {
  final ReportRepository reportRepository;
  GetMonthlyReportComponentBloc({
    required this.reportRepository,
  }) : super(GetMonthlyReportComponentInitial()) {
    on<GetMonthlyReportComponentEvent>((event, emit) async {
      emit(GetMonthlyReportComponentLoading());
      final result = await reportRepository.getMonthlyReportComponent();
      result.fold(
        (failure) => emit(GetMonthlyReportComponentError(
          message: failure.toString(),
        )),
        (result) => emit(GetMonthlyReportComponentSuccess(
          components: result,
        )),
      );
    });
  }
}
