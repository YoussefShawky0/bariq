// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent()';
}


}

/// @nodoc
class $ProfileEventCopyWith<$Res>  {
$ProfileEventCopyWith(ProfileEvent _, $Res Function(ProfileEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEvent].
extension ProfileEventPatterns on ProfileEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileStarted value)?  started,TResult Function( ProfileSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started(_that);case ProfileSubmitted() when submitted != null:
return submitted(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileStarted value)  started,required TResult Function( ProfileSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case ProfileStarted():
return started(_that);case ProfileSubmitted():
return submitted(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileStarted value)?  started,TResult? Function( ProfileSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started(_that);case ProfileSubmitted() when submitted != null:
return submitted(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( String fullName,  String phone,  String city,  String area,  bool acceptedTerms,  ProfileAvatar? avatar)?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started();case ProfileSubmitted() when submitted != null:
return submitted(_that.fullName,_that.phone,_that.city,_that.area,_that.acceptedTerms,_that.avatar);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( String fullName,  String phone,  String city,  String area,  bool acceptedTerms,  ProfileAvatar? avatar)  submitted,}) {final _that = this;
switch (_that) {
case ProfileStarted():
return started();case ProfileSubmitted():
return submitted(_that.fullName,_that.phone,_that.city,_that.area,_that.acceptedTerms,_that.avatar);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( String fullName,  String phone,  String city,  String area,  bool acceptedTerms,  ProfileAvatar? avatar)?  submitted,}) {final _that = this;
switch (_that) {
case ProfileStarted() when started != null:
return started();case ProfileSubmitted() when submitted != null:
return submitted(_that.fullName,_that.phone,_that.city,_that.area,_that.acceptedTerms,_that.avatar);case _:
  return null;

}
}

}

/// @nodoc


class ProfileStarted implements ProfileEvent {
  const ProfileStarted();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEvent.started()';
}


}




/// @nodoc


class ProfileSubmitted implements ProfileEvent {
  const ProfileSubmitted({required this.fullName, required this.phone, required this.city, required this.area, required this.acceptedTerms, this.avatar});


 final  String fullName;
 final  String phone;
 final  String city;
 final  String area;
 final  bool acceptedTerms;
 final  ProfileAvatar? avatar;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSubmittedCopyWith<ProfileSubmitted> get copyWith => _$ProfileSubmittedCopyWithImpl<ProfileSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSubmitted&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.city, city) || other.city == city)&&(identical(other.area, area) || other.area == area)&&(identical(other.acceptedTerms, acceptedTerms) || other.acceptedTerms == acceptedTerms)&&(identical(other.avatar, avatar) || other.avatar == avatar));
}


@override
int get hashCode => Object.hash(runtimeType,fullName,phone,city,area,acceptedTerms,avatar);

@override
String toString() {
  return 'ProfileEvent.submitted(fullName: $fullName, phone: $phone, city: $city, area: $area, acceptedTerms: $acceptedTerms, avatar: $avatar)';
}


}

/// @nodoc
abstract mixin class $ProfileSubmittedCopyWith<$Res> implements $ProfileEventCopyWith<$Res> {
  factory $ProfileSubmittedCopyWith(ProfileSubmitted value, $Res Function(ProfileSubmitted) _then) = _$ProfileSubmittedCopyWithImpl;
@useResult
$Res call({
 String fullName, String phone, String city, String area, bool acceptedTerms, ProfileAvatar? avatar
});




}
/// @nodoc
class _$ProfileSubmittedCopyWithImpl<$Res>
    implements $ProfileSubmittedCopyWith<$Res> {
  _$ProfileSubmittedCopyWithImpl(this._self, this._then);

  final ProfileSubmitted _self;
  final $Res Function(ProfileSubmitted) _then;

/// Create a copy of ProfileEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? phone = null,Object? city = null,Object? area = null,Object? acceptedTerms = null,Object? avatar = freezed,}) {
  return _then(ProfileSubmitted(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,area: null == area ? _self.area : area // ignore: cast_nullable_to_non_nullable
as String,acceptedTerms: null == acceptedTerms ? _self.acceptedTerms : acceptedTerms // ignore: cast_nullable_to_non_nullable
as bool,avatar: freezed == avatar ? _self.avatar : avatar // ignore: cast_nullable_to_non_nullable
as ProfileAvatar?,
  ));
}


}

/// @nodoc
mixin _$ProfileState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState()';
}


}

/// @nodoc
class $ProfileStateCopyWith<$Res>  {
$ProfileStateCopyWith(ProfileState _, $Res Function(ProfileState) __);
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileInitial value)?  initial,TResult Function( ProfileLoading value)?  loading,TResult Function( ProfileReady value)?  ready,TResult Function( ProfileSubmitting value)?  submitting,TResult Function( ProfileCompleted value)?  completed,TResult Function( ProfileLoadFailure value)?  loadFailure,TResult Function( ProfileFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileReady() when ready != null:
return ready(_that);case ProfileSubmitting() when submitting != null:
return submitting(_that);case ProfileCompleted() when completed != null:
return completed(_that);case ProfileLoadFailure() when loadFailure != null:
return loadFailure(_that);case ProfileFailure() when failure != null:
return failure(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileInitial value)  initial,required TResult Function( ProfileLoading value)  loading,required TResult Function( ProfileReady value)  ready,required TResult Function( ProfileSubmitting value)  submitting,required TResult Function( ProfileCompleted value)  completed,required TResult Function( ProfileLoadFailure value)  loadFailure,required TResult Function( ProfileFailure value)  failure,}){
final _that = this;
switch (_that) {
case ProfileInitial():
return initial(_that);case ProfileLoading():
return loading(_that);case ProfileReady():
return ready(_that);case ProfileSubmitting():
return submitting(_that);case ProfileCompleted():
return completed(_that);case ProfileLoadFailure():
return loadFailure(_that);case ProfileFailure():
return failure(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileInitial value)?  initial,TResult? Function( ProfileLoading value)?  loading,TResult? Function( ProfileReady value)?  ready,TResult? Function( ProfileSubmitting value)?  submitting,TResult? Function( ProfileCompleted value)?  completed,TResult? Function( ProfileLoadFailure value)?  loadFailure,TResult? Function( ProfileFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial(_that);case ProfileLoading() when loading != null:
return loading(_that);case ProfileReady() when ready != null:
return ready(_that);case ProfileSubmitting() when submitting != null:
return submitting(_that);case ProfileCompleted() when completed != null:
return completed(_that);case ProfileLoadFailure() when loadFailure != null:
return loadFailure(_that);case ProfileFailure() when failure != null:
return failure(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( CustomerProfile profile)?  ready,TResult Function( CustomerProfile profile)?  submitting,TResult Function( CustomerProfile profile)?  completed,TResult Function( Failure failure)?  loadFailure,TResult Function( CustomerProfile profile,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileReady() when ready != null:
return ready(_that.profile);case ProfileSubmitting() when submitting != null:
return submitting(_that.profile);case ProfileCompleted() when completed != null:
return completed(_that.profile);case ProfileLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case ProfileFailure() when failure != null:
return failure(_that.profile,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( CustomerProfile profile)  ready,required TResult Function( CustomerProfile profile)  submitting,required TResult Function( CustomerProfile profile)  completed,required TResult Function( Failure failure)  loadFailure,required TResult Function( CustomerProfile profile,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ProfileInitial():
return initial();case ProfileLoading():
return loading();case ProfileReady():
return ready(_that.profile);case ProfileSubmitting():
return submitting(_that.profile);case ProfileCompleted():
return completed(_that.profile);case ProfileLoadFailure():
return loadFailure(_that.failure);case ProfileFailure():
return failure(_that.profile,_that.failure);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( CustomerProfile profile)?  ready,TResult? Function( CustomerProfile profile)?  submitting,TResult? Function( CustomerProfile profile)?  completed,TResult? Function( Failure failure)?  loadFailure,TResult? Function( CustomerProfile profile,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ProfileInitial() when initial != null:
return initial();case ProfileLoading() when loading != null:
return loading();case ProfileReady() when ready != null:
return ready(_that.profile);case ProfileSubmitting() when submitting != null:
return submitting(_that.profile);case ProfileCompleted() when completed != null:
return completed(_that.profile);case ProfileLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case ProfileFailure() when failure != null:
return failure(_that.profile,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ProfileInitial implements ProfileState {
  const ProfileInitial();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.initial()';
}


}




/// @nodoc


class ProfileLoading implements ProfileState {
  const ProfileLoading();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileState.loading()';
}


}




/// @nodoc


class ProfileReady implements ProfileState {
  const ProfileReady(this.profile);


 final  CustomerProfile profile;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileReadyCopyWith<ProfileReady> get copyWith => _$ProfileReadyCopyWithImpl<ProfileReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileReady&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'ProfileState.ready(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProfileReadyCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileReadyCopyWith(ProfileReady value, $Res Function(ProfileReady) _then) = _$ProfileReadyCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile
});




}
/// @nodoc
class _$ProfileReadyCopyWithImpl<$Res>
    implements $ProfileReadyCopyWith<$Res> {
  _$ProfileReadyCopyWithImpl(this._self, this._then);

  final ProfileReady _self;
  final $Res Function(ProfileReady) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(ProfileReady(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,
  ));
}


}

/// @nodoc


class ProfileSubmitting implements ProfileState {
  const ProfileSubmitting(this.profile);


 final  CustomerProfile profile;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileSubmittingCopyWith<ProfileSubmitting> get copyWith => _$ProfileSubmittingCopyWithImpl<ProfileSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileSubmitting&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'ProfileState.submitting(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProfileSubmittingCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileSubmittingCopyWith(ProfileSubmitting value, $Res Function(ProfileSubmitting) _then) = _$ProfileSubmittingCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile
});




}
/// @nodoc
class _$ProfileSubmittingCopyWithImpl<$Res>
    implements $ProfileSubmittingCopyWith<$Res> {
  _$ProfileSubmittingCopyWithImpl(this._self, this._then);

  final ProfileSubmitting _self;
  final $Res Function(ProfileSubmitting) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(ProfileSubmitting(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,
  ));
}


}

/// @nodoc


class ProfileCompleted implements ProfileState {
  const ProfileCompleted(this.profile);


 final  CustomerProfile profile;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCompletedCopyWith<ProfileCompleted> get copyWith => _$ProfileCompletedCopyWithImpl<ProfileCompleted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileCompleted&&(identical(other.profile, profile) || other.profile == profile));
}


@override
int get hashCode => Object.hash(runtimeType,profile);

@override
String toString() {
  return 'ProfileState.completed(profile: $profile)';
}


}

/// @nodoc
abstract mixin class $ProfileCompletedCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileCompletedCopyWith(ProfileCompleted value, $Res Function(ProfileCompleted) _then) = _$ProfileCompletedCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile
});




}
/// @nodoc
class _$ProfileCompletedCopyWithImpl<$Res>
    implements $ProfileCompletedCopyWith<$Res> {
  _$ProfileCompletedCopyWithImpl(this._self, this._then);

  final ProfileCompleted _self;
  final $Res Function(ProfileCompleted) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,}) {
  return _then(ProfileCompleted(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,
  ));
}


}

/// @nodoc


class ProfileLoadFailure implements ProfileState {
  const ProfileLoadFailure(this.failure);


 final  Failure failure;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileLoadFailureCopyWith<ProfileLoadFailure> get copyWith => _$ProfileLoadFailureCopyWithImpl<ProfileLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ProfileState.loadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProfileLoadFailureCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileLoadFailureCopyWith(ProfileLoadFailure value, $Res Function(ProfileLoadFailure) _then) = _$ProfileLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ProfileLoadFailureCopyWithImpl<$Res>
    implements $ProfileLoadFailureCopyWith<$Res> {
  _$ProfileLoadFailureCopyWithImpl(this._self, this._then);

  final ProfileLoadFailure _self;
  final $Res Function(ProfileLoadFailure) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ProfileLoadFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class ProfileFailure implements ProfileState {
  const ProfileFailure(this.profile, this.failure);


 final  CustomerProfile profile;
 final  Failure failure;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileFailureCopyWith<ProfileFailure> get copyWith => _$ProfileFailureCopyWithImpl<ProfileFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileFailure&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,profile,failure);

@override
String toString() {
  return 'ProfileState.failure(profile: $profile, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ProfileFailureCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory $ProfileFailureCopyWith(ProfileFailure value, $Res Function(ProfileFailure) _then) = _$ProfileFailureCopyWithImpl;
@useResult
$Res call({
 CustomerProfile profile, Failure failure
});




}
/// @nodoc
class _$ProfileFailureCopyWithImpl<$Res>
    implements $ProfileFailureCopyWith<$Res> {
  _$ProfileFailureCopyWithImpl(this._self, this._then);

  final ProfileFailure _self;
  final $Res Function(ProfileFailure) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? profile = null,Object? failure = null,}) {
  return _then(ProfileFailure(
null == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as CustomerProfile,null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
