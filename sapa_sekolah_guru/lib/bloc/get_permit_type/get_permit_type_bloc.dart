import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_guru/model/permit_type_response_model.dart';
import 'package:sapa_sekolah_guru/repositories/permit_repository.dart';

part 'get_permit_type_event.dart';
part 'get_permit_type_state.dart';

@injectable
class GetPermitTypeBloc extends Bloc<GetPermitTypeEvent, GetPermitTypeState> {
  final PermitRepository permitRepository;
  GetPermitTypeBloc({
    required this.permitRepository,
  }) : super(GetPermitTypeInitial()) {
    on<GetPermitTypeEvent>((event, emit) async {
      emit(GetPermitTypeLoading());
      final result = await permitRepository.getPermitType();
      result.fold(
        (failure) => emit(GetPermitTypeError(
          message: failure.toString(),
        )),
        (permit) => emit(GetPermitTypeSuccess(
          permit: permit,
        )),
      );
    });
  }
}
