import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/app_startup/presentation/cubit/app_startup_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockAppStartupRepository extends Mock implements AppStartupRepository {}

void main() {
  late MockAppStartupRepository repository;
  late ResolveInitialDestination useCase;

  setUp(() {
    repository = MockAppStartupRepository();
    useCase = ResolveInitialDestination(repository);
  });

  blocTest<AppStartupCubit, AppStartupState>(
    'emits loading then ready when resolution succeeds',
    setUp: () {
      when(
        repository.resolveInitialDestination,
      ).thenAnswer((_) async => const Right(AppDestination.onboarding));
    },
    build: () => AppStartupCubit(useCase),
    act: (cubit) => cubit.initialize(),
    expect: () => const [
      AppStartupState.loading(),
      AppStartupState.ready(AppDestination.onboarding),
    ],
  );

  blocTest<AppStartupCubit, AppStartupState>(
    'emits loading then failure when resolution fails',
    setUp: () {
      when(
        repository.resolveInitialDestination,
      ).thenAnswer((_) async => const Left(CacheFailure()));
    },
    build: () => AppStartupCubit(useCase),
    act: (cubit) => cubit.initialize(),
    expect: () => const [
      AppStartupState.loading(),
      AppStartupState.failure(CacheFailure()),
    ],
  );
}
