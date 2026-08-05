import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/utils/app_logger.dart';
import 'package:bariq/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:bariq/features/profile/data/models/customer_profile_model.dart';
import 'package:bariq/features/profile/data/models/profile_update_model.dart';
import 'package:bariq/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockProfileRemoteDataSource extends Mock
    implements ProfileRemoteDataSource {}

class MockAppLogger extends Mock implements AppLogger {}

void main() {
  late MockProfileRemoteDataSource remoteDataSource;
  late MockAppLogger logger;
  late ProfileRepositoryImpl repository;

  setUpAll(() {
    registerFallbackValue(
      const ProfileUpdateModel(
        id: 'customer-id',
        fullName: 'يوسف شوقي',
        phone: null,
        city: null,
        area: null,
        existingAvatarPath: null,
      ),
    );
  });

  setUp(() {
    remoteDataSource = MockProfileRemoteDataSource();
    logger = MockAppLogger();
    repository = ProfileRepositoryImpl(remoteDataSource, logger);
  });

  test('maps the remote model into a domain profile', () async {
    when(remoteDataSource.loadCurrentProfile).thenAnswer((_) async => _model());

    final result = await repository.loadCurrentProfile();

    expect(result.getRight().toNullable()?.id, 'customer-id');
    expect(result.getRight().toNullable()?.email, 'customer@example.com');
  });

  test('uses the server-loaded owner and maps the saved profile', () async {
    when(remoteDataSource.loadCurrentProfile).thenAnswer((_) async => _model());
    when(
      () => remoteDataSource.saveCurrentProfile(
        update: any(named: 'update'),
        avatar: null,
      ),
    ).thenAnswer((_) async => _model(completed: true));

    final result = await repository.saveCurrentProfile(_input());

    expect(result.getRight().toNullable()?.isComplete, isTrue);
    final captured =
        verify(
              () => remoteDataSource.saveCurrentProfile(
                update: captureAny(named: 'update'),
                avatar: null,
              ),
            ).captured.single
            as ProfileUpdateModel;
    expect(captured.id, 'customer-id');
    expect(captured.phone, '+201112345678');
    expect(captured.city, 'القاهرة');
  });

  test('maps provider details to a safe backend failure', () async {
    when(remoteDataSource.loadCurrentProfile).thenThrow(
      const PostgrestException(message: 'sensitive detail', code: '42501'),
    );
    when(
      () => logger.error(
        any(),
        error: any(named: 'error'),
        stackTrace: any(named: 'stackTrace'),
      ),
    ).thenReturn(null);

    final result = await repository.loadCurrentProfile();
    final failure = result.getLeft().toNullable();

    expect(failure, isA<BackendFailure>());
    expect(failure?.message, isNot(contains('sensitive detail')));
  });
}

CustomerProfileModel _model({bool completed = false}) => CustomerProfileModel(
  id: 'customer-id',
  email: 'customer@example.com',
  fullName: 'يوسف شوقي',
  phone: null,
  city: null,
  area: null,
  avatarPath: null,
  avatarUrl: null,
  preferredLanguage: 'ar',
  termsVersion: '2026-08',
  termsAcceptedAt: DateTime.utc(2026, 8, 4),
  completedAt: completed ? DateTime.utc(2026, 8, 4) : null,
);

ProfileInput _input() => const ProfileInput(
  fullName: 'يوسف شوقي',
  phone: '01112345678',
  city: 'القاهرة',
  area: '',
  acceptedTerms: true,
);
