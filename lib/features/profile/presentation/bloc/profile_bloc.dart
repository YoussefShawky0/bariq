import 'package:bariq/core/errors/failures.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:bariq/features/profile/domain/entities/profile_input.dart';
import 'package:bariq/features/profile/domain/usecases/load_customer_profile.dart';
import 'package:bariq/features/profile/domain/usecases/save_customer_profile.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this._loadCustomerProfile, this._saveCustomerProfile)
    : super(const ProfileState.initial()) {
    on<ProfileStarted>(_onStarted);
    on<ProfileSubmitted>(_onSubmitted);
  }

  final LoadCustomerProfile _loadCustomerProfile;
  final SaveCustomerProfile _saveCustomerProfile;

  Future<void> _onStarted(
    ProfileStarted event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const ProfileState.loading());
    final result = await _loadCustomerProfile();
    result.match(
      (failure) => emit(ProfileState.loadFailure(failure)),
      (profile) => emit(ProfileState.ready(profile)),
    );
  }

  Future<void> _onSubmitted(
    ProfileSubmitted event,
    Emitter<ProfileState> emit,
  ) async {
    final profile = state.maybeWhen(
      ready: (value) => value,
      failure: (value, _) => value,
      orElse: () => null,
    );
    if (profile == null) {
      return;
    }

    emit(ProfileState.submitting(profile));
    final result = await _saveCustomerProfile(
      ProfileInput(
        fullName: event.fullName,
        phone: event.phone,
        city: event.city,
        area: event.area,
        acceptedTerms: event.acceptedTerms,
        avatar: event.avatar,
      ),
    );
    result.match(
      (failure) => emit(ProfileState.failure(profile, failure)),
      (saved) => emit(ProfileState.completed(saved)),
    );
  }
}

@freezed
sealed class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = ProfileStarted;

  const factory ProfileEvent.submitted({
    required String fullName,
    required String phone,
    required String city,
    required String area,
    required bool acceptedTerms,
    ProfileAvatar? avatar,
  }) = ProfileSubmitted;
}

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState.initial() = ProfileInitial;
  const factory ProfileState.loading() = ProfileLoading;
  const factory ProfileState.ready(CustomerProfile profile) = ProfileReady;
  const factory ProfileState.submitting(CustomerProfile profile) =
      ProfileSubmitting;
  const factory ProfileState.completed(CustomerProfile profile) =
      ProfileCompleted;
  const factory ProfileState.loadFailure(Failure failure) = ProfileLoadFailure;
  const factory ProfileState.failure(CustomerProfile profile, Failure failure) =
      ProfileFailure;
}
