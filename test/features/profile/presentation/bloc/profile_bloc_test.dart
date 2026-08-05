import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/customer_profile_test_data.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(
      const ProfileInput(
        fullName: 'يوسف شوقي',
        phone: '',
        city: '',
        area: '',
        acceptedTerms: true,
      ),
    );
  });

  setUp(() {
    repository = MockProfileRepository();
  });

  ProfileBloc buildBloc() => ProfileBloc(
    LoadCustomerProfile(repository),
    SaveCustomerProfile(repository),
  );

  blocTest<ProfileBloc, ProfileState>(
    'loads an empty or existing customer profile',
    build: () {
      when(
        repository.loadCurrentProfile,
      ).thenAnswer((_) async => Right(customerProfile()));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const ProfileEvent.started()),
    expect: () => [isA<ProfileLoading>(), isA<ProfileReady>()],
  );

  blocTest<ProfileBloc, ProfileState>(
    'preserves a safe load failure state',
    build: () {
      when(
        repository.loadCurrentProfile,
      ).thenAnswer((_) async => const Left(NetworkFailure()));
      return buildBloc();
    },
    act: (bloc) => bloc.add(const ProfileEvent.started()),
    expect: () => [isA<ProfileLoading>(), isA<ProfileLoadFailure>()],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits submitting then completed for valid input',
    build: () {
      when(() => repository.saveCurrentProfile(any())).thenAnswer(
        (_) async =>
            Right(customerProfile(fullName: 'يوسف شوقي', completed: true)),
      );
      return buildBloc();
    },
    seed: () => ProfileState.ready(customerProfile()),
    act: (bloc) => bloc.add(
      const ProfileEvent.submitted(
        fullName: 'يوسف شوقي',
        phone: '',
        city: '',
        area: '',
        acceptedTerms: true,
      ),
    ),
    expect: () => [isA<ProfileSubmitting>(), isA<ProfileCompleted>()],
  );

  blocTest<ProfileBloc, ProfileState>(
    'keeps the profile available when domain validation fails',
    build: buildBloc,
    seed: () => ProfileState.ready(customerProfile()),
    act: (bloc) => bloc.add(
      const ProfileEvent.submitted(
        fullName: '',
        phone: '',
        city: '',
        area: '',
        acceptedTerms: false,
      ),
    ),
    expect: () => [isA<ProfileSubmitting>(), isA<ProfileFailure>()],
    verify: (_) => verifyNever(() => repository.saveCurrentProfile(any())),
  );
}
