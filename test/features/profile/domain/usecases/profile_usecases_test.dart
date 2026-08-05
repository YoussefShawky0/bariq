import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/profile/domain/entities/egyptian_mobile_number.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/customer_profile_test_data.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late MockProfileRepository repository;

  setUpAll(() {
    registerFallbackValue(_input());
  });

  setUp(() {
    repository = MockProfileRepository();
  });

  test('load delegates to the profile repository', () async {
    final profile = customerProfile();
    when(repository.loadCurrentProfile).thenAnswer((_) async => Right(profile));

    final result = await LoadCustomerProfile(repository)();

    expect(result.getRight().toNullable(), same(profile));
  });

  test('save accepts minimum valid profile completion data', () async {
    final saved = customerProfile(fullName: 'يوسف شوقي', completed: true);
    when(
      () => repository.saveCurrentProfile(any()),
    ).thenAnswer((_) async => Right(saved));

    final result = await SaveCustomerProfile(repository)(_input());

    expect(result.getRight().toNullable(), same(saved));
    verify(() => repository.saveCurrentProfile(any())).called(1);
  });

  for (final testCase in {
    'invalid full name': (
      input: _input(fullName: 'ي'),
      code: 'INVALID_FULL_NAME',
    ),
    'invalid phone': (
      input: _input(phone: '01312345678'),
      code: 'INVALID_PHONE',
    ),
    'terms not accepted': (
      input: _input(acceptedTerms: false),
      code: 'TERMS_NOT_ACCEPTED',
    ),
  }.entries) {
    test('returns validation failure for ${testCase.key}', () async {
      final result = await SaveCustomerProfile(repository)(
        testCase.value.input,
      );

      final failure = result.getLeft().toNullable();
      expect(failure, isA<ValidationFailure>());
      expect(failure?.code, testCase.value.code);
      verifyNever(() => repository.saveCurrentProfile(any()));
    });
  }

  test('normalizes Egyptian mobile input with or without the local zero', () {
    expect(EgyptianMobileNumber.tryNormalize('01112345678'), '+201112345678');
    expect(EgyptianMobileNumber.tryNormalize('1112345678'), '+201112345678');
    expect(EgyptianMobileNumber.tryNormalize('phone01112345678'), isNull);
  });
}

ProfileInput _input({
  String fullName = 'يوسف شوقي',
  String phone = '',
  bool acceptedTerms = true,
}) => ProfileInput(
  fullName: fullName,
  phone: phone,
  city: '',
  area: '',
  acceptedTerms: acceptedTerms,
);
