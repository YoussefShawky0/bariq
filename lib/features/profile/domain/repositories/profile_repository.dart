import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';

/// Contract for customer-owned profile operations.
abstract interface class ProfileRepository {
  /// Loads the active customer's profile or an empty customer-owned draft.
  ResultFuture<CustomerProfile> loadCurrentProfile();

  /// Validates, uploads optional media, and saves the active profile.
  ResultFuture<CustomerProfile> saveCurrentProfile(ProfileInput input);
}
