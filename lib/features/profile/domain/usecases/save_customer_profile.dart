import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/core/errors/result.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/egypt_governorates.dart';
import 'package:bariq/features/profile/domain/entities/egyptian_mobile_number.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/repositories/profile_repository.dart';
import 'package:fpdart/fpdart.dart';

/// Validates and saves customer profile-completion input.
final class SaveCustomerProfile {
  const SaveCustomerProfile(this._repository);

  final ProfileRepository _repository;

  /// Returns a safe validation failure or the server-owned saved profile.
  ResultFuture<CustomerProfile> call(ProfileInput input) {
    final validation = _validate(input);
    return validation.match(
      (failure) async => Left(failure),
      (_) => _repository.saveCurrentProfile(input),
    );
  }

  Either<ValidationFailure, Unit> _validate(ProfileInput input) {
    final fullName = input.fullName.trim();
    if (fullName.length < 2 || fullName.length > 100) {
      return const Left(
        ValidationFailure(
          code: 'INVALID_FULL_NAME',
          message: 'اكتب اسمك بالكامل من حرفين على الأقل.',
        ),
      );
    }

    final phone = input.phone.trim();
    if (phone.isNotEmpty && EgyptianMobileNumber.tryNormalize(phone) == null) {
      return const Left(
        ValidationFailure(
          code: 'INVALID_PHONE',
          message: 'اكتب رقم موبايل مصري صحيح، مثال: 01012345678.',
        ),
      );
    }

    final governorate = input.city.trim();
    if (governorate.isNotEmpty && !EgyptGovernorates.contains(governorate)) {
      return const Left(
        ValidationFailure(
          code: 'INVALID_GOVERNORATE',
          message: 'اختَر محافظة مصرية من القائمة.',
        ),
      );
    }

    final area = input.area.trim();
    if (area.isNotEmpty && (area.length < 2 || area.length > 80)) {
      return const Left(
        ValidationFailure(
          code: 'INVALID_LOCATION_TEXT',
          message: 'اكتب المنطقة من حرفين على الأقل.',
        ),
      );
    }

    if (!input.acceptedTerms) {
      return const Left(
        ValidationFailure(
          code: 'TERMS_NOT_ACCEPTED',
          message: 'لازم تقرأ وتوافق على الشروط وسياسة الخصوصية للمتابعة.',
        ),
      );
    }

    final avatar = input.avatar;
    if (avatar != null &&
        avatar.bytes.lengthInBytes > ProfileAvatarRules.maxBytes) {
      return const Left(
        ValidationFailure(
          code: 'AVATAR_TOO_LARGE',
          message: 'حجم الصورة لازم يكون أقل من 2 ميجابايت.',
        ),
      );
    }

    if (avatar != null &&
        ProfileAvatarRules.supportedTypes[avatar.extension] !=
            avatar.contentType) {
      return const Left(
        ValidationFailure(
          code: 'UNSUPPORTED_AVATAR',
          message: 'اختَر صورة JPG أو PNG أو WebP.',
        ),
      );
    }

    return const Right(unit);
  }
}
