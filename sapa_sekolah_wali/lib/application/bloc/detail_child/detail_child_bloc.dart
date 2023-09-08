import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/child/detail_child_model.dart';
import 'package:sapa_sekolah_wali/repositories/child/child_repository.dart';

part 'detail_child_event.dart';
part 'detail_child_state.dart';
part 'detail_child_bloc.freezed.dart';

@injectable
class DetailChildBloc extends Bloc<DetailChildEvent, DetailChildState> {
  ChildRepository repository;

  DetailChildBloc(this.repository) : super(const _Initial()) {
    on<DetailChildEvent>((event, emit) async {
      await event.map(
        started: (started) {},
        load: (load) async {
          final response = await repository.getDetailChild(load.studentId);

          response.fold(
            (l) {
              emit(DetailChildState.failure(l.message));
            },
            (r) {
              emit(DetailChildState.success(r));
            },
          );
        },
      );
    });
  }
}
