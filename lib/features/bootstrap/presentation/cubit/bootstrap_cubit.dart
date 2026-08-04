import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/domain/usecases/resolve_initial_destination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'bootstrap_cubit.freezed.dart';

class BootstrapCubit extends Cubit<BootstrapState> {
  BootstrapCubit(this._resolveInitialDestination)
    : super(const BootstrapState.initial());

  final ResolveInitialDestination _resolveInitialDestination;

  Future<void> initialize() async {
    emit(const BootstrapState.loading());
    final result = await _resolveInitialDestination();
    result.match(
      (failure) => emit(BootstrapState.failure(failure)),
      (destination) => emit(BootstrapState.ready(destination)),
    );
  }
}

@freezed
sealed class BootstrapState with _$BootstrapState {
  const factory BootstrapState.initial() = BootstrapInitial;
  const factory BootstrapState.loading() = BootstrapLoading;
  const factory BootstrapState.ready(AppDestination destination) =
      BootstrapReady;
  const factory BootstrapState.failure(Failure failure) = BootstrapFailure;
}
