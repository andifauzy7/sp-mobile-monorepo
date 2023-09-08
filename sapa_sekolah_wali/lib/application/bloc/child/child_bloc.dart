import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:sapa_sekolah_wali/model/child/child_model.dart';
import 'package:sapa_sekolah_wali/repositories/child/child_repository.dart';

part 'child_event.dart';
part 'child_state.dart';
part 'child_bloc.freezed.dart';

@injectable
class ChildBloc extends Bloc<ChildEvent, ChildState> {
  ChildRepository repository;

  ChildBloc(this.repository) : super(const _Initial()) {
    on<ChildEvent>((event, emit) async {
      await event.map(
        started: (_) {},
        load: (_) async {
          emit(const ChildState.loading());

          final result = await repository.getListChild();

          result.fold(
            (l) {
              emit(ChildState.failure(l.message));
            },
            (r) {
              emit(ChildState.success(r));
            },
          );
        },
      );
    });
  }
}
