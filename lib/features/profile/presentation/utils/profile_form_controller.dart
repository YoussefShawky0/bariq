import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/egypt_governorates.dart';
import 'package:bariq/features/profile/domain/entities/egyptian_mobile_number.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:bariq/features/profile/domain/entities/profile_terms.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter/widgets.dart';

final class ProfileFormController {
  final fullName = TextEditingController();
  final phone = TextEditingController();
  final area = TextEditingController();

  bool acceptedTerms = false;
  String? governorate;
  ProfileAvatar? avatar;
  String? localError;
  bool _initialized = false;

  void initialize(CustomerProfile profile) {
    if (_initialized) {
      return;
    }
    fullName.text = profile.fullName ?? '';
    phone.text = EgyptianMobileNumber.toLocalInput(profile.phone);
    governorate =
        profile.city != null && EgyptGovernorates.contains(profile.city!)
        ? profile.city
        : null;
    area.text = profile.area ?? '';
    acceptedTerms = profile.termsVersion == ProfileTerms.currentVersion;
    _initialized = true;
  }

  void setTerms(bool value) {
    acceptedTerms = value;
    localError = null;
  }

  void setAvatar(ProfileAvatar value) {
    avatar = value;
    localError = null;
  }

  void setGovernorate(String? value) {
    governorate = value;
    localError = null;
  }

  ProfileEvent submission() => ProfileEvent.submitted(
    fullName: fullName.text,
    phone: phone.text,
    city: governorate ?? '',
    area: area.text,
    acceptedTerms: acceptedTerms,
    avatar: avatar,
  );

  void dispose() {
    fullName.dispose();
    phone.dispose();
    area.dispose();
  }
}
