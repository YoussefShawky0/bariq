import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_startup_cubit.freezed.dart';

class AppStartupCubit extends Cubit<AppStartupState> {
  AppStartupCubit(this._resolveInitialDestination)
    : super(const AppStartupState.initial());

  final ResolveInitialDestination _resolveInitialDestination;

  Future<void> initialize() async {
    emit(const AppStartupState.loading());
    final result = await _resolveInitialDestination();
    result.match(
      (failure) => emit(AppStartupState.failure(failure)),
      (destination) => emit(AppStartupState.ready(destination)),
    );
  }
}

@freezed
sealed class AppStartupState with _$AppStartupState {
  const factory AppStartupState.initial() = AppStartupInitial;
  const factory AppStartupState.loading() = AppStartupLoading;
  const factory AppStartupState.ready(AppDestination destination) =
      AppStartupReady;
  const factory AppStartupState.failure(Failure failure) = AppStartupFailure;
}
