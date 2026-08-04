import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/bootstrap/domain/entities/app_destination.dart';
import 'package:bariq/features/bootstrap/domain/repositories/bootstrap_repository.dart';
import 'package:bariq/features/bootstrap/domain/usecases/resolve_initial_destination.dart';
import 'package:bariq/features/bootstrap/presentation/cubit/bootstrap_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

class MockBootstrapRepository extends Mock implements BootstrapRepository {}

void main() {
  late MockBootstrapRepository repository;
  late ResolveInitialDestination useCase;

  setUp(() {
    repository = MockBootstrapRepository();
    useCase = ResolveInitialDestination(repository);
  });

  blocTest<BootstrapCubit, BootstrapState>(
    'emits loading then ready when resolution succeeds',
    setUp: () {
      when(
        repository.resolveInitialDestination,
      ).thenAnswer((_) async => const Right(AppDestination.onboarding));
    },
    build: () => BootstrapCubit(useCase),
    act: (cubit) => cubit.initialize(),
    expect: () => const [
      BootstrapState.loading(),
      BootstrapState.ready(AppDestination.onboarding),
    ],
  );

  blocTest<BootstrapCubit, BootstrapState>(
    'emits loading then failure when resolution fails',
    setUp: () {
      when(
        repository.resolveInitialDestination,
      ).thenAnswer((_) async => const Left(CacheFailure()));
    },
    build: () => BootstrapCubit(useCase),
    act: (cubit) => cubit.initialize(),
    expect: () => const [
      BootstrapState.loading(),
      BootstrapState.failure(CacheFailure()),
    ],
  );
}
