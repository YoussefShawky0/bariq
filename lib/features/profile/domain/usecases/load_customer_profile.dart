import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';

/// Loads the active customer profile for completion or editing.
final class LoadCustomerProfile {
  const LoadCustomerProfile(this._repository);

  final ProfileRepository _repository;

  /// Returns customer-owned profile data without exposing Supabase details.
  ResultFuture<CustomerProfile> call() => _repository.loadCurrentProfile();
}
