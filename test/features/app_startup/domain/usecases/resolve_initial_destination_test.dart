import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/app_startup/domain/entities/app_destination.dart';
import 'package:bariq/features/app_startup/domain/repositories/app_startup_repository.dart';
import 'package:bariq/features/app_startup/domain/usecases/resolve_initial_destination.dart';
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

  test('returns the destination supplied by the repository', () async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Right(AppDestination.onboarding));

    final result = await useCase();

    expect(
      result,
      const Right<Failure, AppDestination>(AppDestination.onboarding),
    );
    verify(repository.resolveInitialDestination).called(1);
  });

  test('returns the failure supplied by the repository', () async {
    when(
      repository.resolveInitialDestination,
    ).thenAnswer((_) async => const Left(CacheFailure()));

    final result = await useCase();

    expect(result.isLeft(), isTrue);
    expect(result.getLeft().toNullable(), isA<CacheFailure>());
  });
}
