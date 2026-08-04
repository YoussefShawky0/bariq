// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthModeChanged value)?  modeChanged,TResult Function( AuthCredentialsSubmitted value)?  credentialsSubmitted,TResult Function( AuthPasswordResetRequested value)?  passwordResetRequested,TResult Function( AuthPasswordUpdateSubmitted value)?  passwordUpdateSubmitted,TResult Function( AuthGoogleSubmitted value)?  googleSubmitted,TResult Function( AuthSessionChanged value)?  sessionChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthModeChanged() when modeChanged != null:
return modeChanged(_that);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case AuthPasswordUpdateSubmitted() when passwordUpdateSubmitted != null:
return passwordUpdateSubmitted(_that);case AuthGoogleSubmitted() when googleSubmitted != null:
return googleSubmitted(_that);case AuthSessionChanged() when sessionChanged != null:
return sessionChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthModeChanged value)  modeChanged,required TResult Function( AuthCredentialsSubmitted value)  credentialsSubmitted,required TResult Function( AuthPasswordResetRequested value)  passwordResetRequested,required TResult Function( AuthPasswordUpdateSubmitted value)  passwordUpdateSubmitted,required TResult Function( AuthGoogleSubmitted value)  googleSubmitted,required TResult Function( AuthSessionChanged value)  sessionChanged,}){
final _that = this;
switch (_that) {
case AuthModeChanged():
return modeChanged(_that);case AuthCredentialsSubmitted():
return credentialsSubmitted(_that);case AuthPasswordResetRequested():
return passwordResetRequested(_that);case AuthPasswordUpdateSubmitted():
return passwordUpdateSubmitted(_that);case AuthGoogleSubmitted():
return googleSubmitted(_that);case AuthSessionChanged():
return sessionChanged(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthModeChanged value)?  modeChanged,TResult? Function( AuthCredentialsSubmitted value)?  credentialsSubmitted,TResult? Function( AuthPasswordResetRequested value)?  passwordResetRequested,TResult? Function( AuthPasswordUpdateSubmitted value)?  passwordUpdateSubmitted,TResult? Function( AuthGoogleSubmitted value)?  googleSubmitted,TResult? Function( AuthSessionChanged value)?  sessionChanged,}){
final _that = this;
switch (_that) {
case AuthModeChanged() when modeChanged != null:
return modeChanged(_that);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case AuthPasswordUpdateSubmitted() when passwordUpdateSubmitted != null:
return passwordUpdateSubmitted(_that);case AuthGoogleSubmitted() when googleSubmitted != null:
return googleSubmitted(_that);case AuthSessionChanged() when sessionChanged != null:
return sessionChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuthMode mode)?  modeChanged,TResult Function( String email,  String password,  String passwordConfirmation)?  credentialsSubmitted,TResult Function( String email)?  passwordResetRequested,TResult Function( String password,  String passwordConfirmation)?  passwordUpdateSubmitted,TResult Function()?  googleSubmitted,TResult Function( Either<Failure, AuthSessionStatus> result)?  sessionChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that.email,_that.password,_that.passwordConfirmation);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case AuthPasswordUpdateSubmitted() when passwordUpdateSubmitted != null:
return passwordUpdateSubmitted(_that.password,_that.passwordConfirmation);case AuthGoogleSubmitted() when googleSubmitted != null:
return googleSubmitted();case AuthSessionChanged() when sessionChanged != null:
return sessionChanged(_that.result);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuthMode mode)  modeChanged,required TResult Function( String email,  String password,  String passwordConfirmation)  credentialsSubmitted,required TResult Function( String email)  passwordResetRequested,required TResult Function( String password,  String passwordConfirmation)  passwordUpdateSubmitted,required TResult Function()  googleSubmitted,required TResult Function( Either<Failure, AuthSessionStatus> result)  sessionChanged,}) {final _that = this;
switch (_that) {
case AuthModeChanged():
return modeChanged(_that.mode);case AuthCredentialsSubmitted():
return credentialsSubmitted(_that.email,_that.password,_that.passwordConfirmation);case AuthPasswordResetRequested():
return passwordResetRequested(_that.email);case AuthPasswordUpdateSubmitted():
return passwordUpdateSubmitted(_that.password,_that.passwordConfirmation);case AuthGoogleSubmitted():
return googleSubmitted();case AuthSessionChanged():
return sessionChanged(_that.result);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuthMode mode)?  modeChanged,TResult? Function( String email,  String password,  String passwordConfirmation)?  credentialsSubmitted,TResult? Function( String email)?  passwordResetRequested,TResult? Function( String password,  String passwordConfirmation)?  passwordUpdateSubmitted,TResult? Function()?  googleSubmitted,TResult? Function( Either<Failure, AuthSessionStatus> result)?  sessionChanged,}) {final _that = this;
switch (_that) {
case AuthModeChanged() when modeChanged != null:
return modeChanged(_that.mode);case AuthCredentialsSubmitted() when credentialsSubmitted != null:
return credentialsSubmitted(_that.email,_that.password,_that.passwordConfirmation);case AuthPasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case AuthPasswordUpdateSubmitted() when passwordUpdateSubmitted != null:
return passwordUpdateSubmitted(_that.password,_that.passwordConfirmation);case AuthGoogleSubmitted() when googleSubmitted != null:
return googleSubmitted();case AuthSessionChanged() when sessionChanged != null:
return sessionChanged(_that.result);case _:
  return null;

}
}

}

/// @nodoc


class AuthModeChanged implements AuthEvent {
  const AuthModeChanged(this.mode);


 final  AuthMode mode;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthModeChangedCopyWith<AuthModeChanged> get copyWith => _$AuthModeChangedCopyWithImpl<AuthModeChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthModeChanged&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthEvent.modeChanged(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $AuthModeChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthModeChangedCopyWith(AuthModeChanged value, $Res Function(AuthModeChanged) _then) = _$AuthModeChangedCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class _$AuthModeChangedCopyWithImpl<$Res>
    implements $AuthModeChangedCopyWith<$Res> {
  _$AuthModeChangedCopyWithImpl(this._self, this._then);

  final AuthModeChanged _self;
  final $Res Function(AuthModeChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(AuthModeChanged(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class AuthCredentialsSubmitted implements AuthEvent {
  const AuthCredentialsSubmitted({required this.email, required this.password, required this.passwordConfirmation});


 final  String email;
 final  String password;
 final  String passwordConfirmation;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthCredentialsSubmittedCopyWith<AuthCredentialsSubmitted> get copyWith => _$AuthCredentialsSubmittedCopyWithImpl<AuthCredentialsSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCredentialsSubmitted&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,email,password,passwordConfirmation);

@override
String toString() {
  return 'AuthEvent.credentialsSubmitted(email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class $AuthCredentialsSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthCredentialsSubmittedCopyWith(AuthCredentialsSubmitted value, $Res Function(AuthCredentialsSubmitted) _then) = _$AuthCredentialsSubmittedCopyWithImpl;
@useResult
$Res call({
 String email, String password, String passwordConfirmation
});




}
/// @nodoc
class _$AuthCredentialsSubmittedCopyWithImpl<$Res>
    implements $AuthCredentialsSubmittedCopyWith<$Res> {
  _$AuthCredentialsSubmittedCopyWithImpl(this._self, this._then);

  final AuthCredentialsSubmitted _self;
  final $Res Function(AuthCredentialsSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(AuthCredentialsSubmitted(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordResetRequested implements AuthEvent {
  const AuthPasswordResetRequested(this.email);


 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordResetRequestedCopyWith<AuthPasswordResetRequested> get copyWith => _$AuthPasswordResetRequestedCopyWithImpl<AuthPasswordResetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordResetRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.passwordResetRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordResetRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthPasswordResetRequestedCopyWith(AuthPasswordResetRequested value, $Res Function(AuthPasswordResetRequested) _then) = _$AuthPasswordResetRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthPasswordResetRequestedCopyWithImpl<$Res>
    implements $AuthPasswordResetRequestedCopyWith<$Res> {
  _$AuthPasswordResetRequestedCopyWithImpl(this._self, this._then);

  final AuthPasswordResetRequested _self;
  final $Res Function(AuthPasswordResetRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthPasswordResetRequested(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordUpdateSubmitted implements AuthEvent {
  const AuthPasswordUpdateSubmitted({required this.password, required this.passwordConfirmation});


 final  String password;
 final  String passwordConfirmation;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordUpdateSubmittedCopyWith<AuthPasswordUpdateSubmitted> get copyWith => _$AuthPasswordUpdateSubmittedCopyWithImpl<AuthPasswordUpdateSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordUpdateSubmitted&&(identical(other.password, password) || other.password == password)&&(identical(other.passwordConfirmation, passwordConfirmation) || other.passwordConfirmation == passwordConfirmation));
}


@override
int get hashCode => Object.hash(runtimeType,password,passwordConfirmation);

@override
String toString() {
  return 'AuthEvent.passwordUpdateSubmitted(password: $password, passwordConfirmation: $passwordConfirmation)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordUpdateSubmittedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthPasswordUpdateSubmittedCopyWith(AuthPasswordUpdateSubmitted value, $Res Function(AuthPasswordUpdateSubmitted) _then) = _$AuthPasswordUpdateSubmittedCopyWithImpl;
@useResult
$Res call({
 String password, String passwordConfirmation
});




}
/// @nodoc
class _$AuthPasswordUpdateSubmittedCopyWithImpl<$Res>
    implements $AuthPasswordUpdateSubmittedCopyWith<$Res> {
  _$AuthPasswordUpdateSubmittedCopyWithImpl(this._self, this._then);

  final AuthPasswordUpdateSubmitted _self;
  final $Res Function(AuthPasswordUpdateSubmitted) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,Object? passwordConfirmation = null,}) {
  return _then(AuthPasswordUpdateSubmitted(
password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,passwordConfirmation: null == passwordConfirmation ? _self.passwordConfirmation : passwordConfirmation // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthGoogleSubmitted implements AuthEvent {
  const AuthGoogleSubmitted();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthGoogleSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleSubmitted()';
}


}




/// @nodoc


class AuthSessionChanged implements AuthEvent {
  const AuthSessionChanged(this.result);


 final  Either<Failure, AuthSessionStatus> result;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSessionChangedCopyWith<AuthSessionChanged> get copyWith => _$AuthSessionChangedCopyWithImpl<AuthSessionChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSessionChanged&&(identical(other.result, result) || other.result == result));
}


@override
int get hashCode => Object.hash(runtimeType,result);

@override
String toString() {
  return 'AuthEvent.sessionChanged(result: $result)';
}


}

/// @nodoc
abstract mixin class $AuthSessionChangedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $AuthSessionChangedCopyWith(AuthSessionChanged value, $Res Function(AuthSessionChanged) _then) = _$AuthSessionChangedCopyWithImpl;
@useResult
$Res call({
 Either<Failure, AuthSessionStatus> result
});




}
/// @nodoc
class _$AuthSessionChangedCopyWithImpl<$Res>
    implements $AuthSessionChangedCopyWith<$Res> {
  _$AuthSessionChangedCopyWithImpl(this._self, this._then);

  final AuthSessionChanged _self;
  final $Res Function(AuthSessionChanged) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? result = null,}) {
  return _then(AuthSessionChanged(
null == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as Either<Failure, AuthSessionStatus>,
  ));
}


}

/// @nodoc
mixin _$AuthState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState()';
}


}

/// @nodoc
class $AuthStateCopyWith<$Res>  {
$AuthStateCopyWith(AuthState _, $Res Function(AuthState) __);
}


/// Adds pattern-matching-related methods to [AuthState].
extension AuthStatePatterns on AuthState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthReady value)?  ready,TResult Function( AuthSubmitting value)?  submitting,TResult Function( AuthEmailVerificationRequired value)?  emailVerificationRequired,TResult Function( AuthPasswordResetSent value)?  passwordResetSent,TResult Function( AuthPasswordRecovery value)?  passwordRecovery,TResult Function( AuthPasswordUpdating value)?  passwordUpdating,TResult Function( AuthPasswordUpdateFailure value)?  passwordUpdateFailure,TResult Function( AuthOauthPending value)?  oauthPending,TResult Function( AuthAuthenticated value)?  authenticated,TResult Function( AuthFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthReady() when ready != null:
return ready(_that);case AuthSubmitting() when submitting != null:
return submitting(_that);case AuthEmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that);case AuthPasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that);case AuthPasswordRecovery() when passwordRecovery != null:
return passwordRecovery(_that);case AuthPasswordUpdating() when passwordUpdating != null:
return passwordUpdating(_that);case AuthPasswordUpdateFailure() when passwordUpdateFailure != null:
return passwordUpdateFailure(_that);case AuthOauthPending() when oauthPending != null:
return oauthPending(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthReady value)  ready,required TResult Function( AuthSubmitting value)  submitting,required TResult Function( AuthEmailVerificationRequired value)  emailVerificationRequired,required TResult Function( AuthPasswordResetSent value)  passwordResetSent,required TResult Function( AuthPasswordRecovery value)  passwordRecovery,required TResult Function( AuthPasswordUpdating value)  passwordUpdating,required TResult Function( AuthPasswordUpdateFailure value)  passwordUpdateFailure,required TResult Function( AuthOauthPending value)  oauthPending,required TResult Function( AuthAuthenticated value)  authenticated,required TResult Function( AuthFailure value)  failure,}){
final _that = this;
switch (_that) {
case AuthReady():
return ready(_that);case AuthSubmitting():
return submitting(_that);case AuthEmailVerificationRequired():
return emailVerificationRequired(_that);case AuthPasswordResetSent():
return passwordResetSent(_that);case AuthPasswordRecovery():
return passwordRecovery(_that);case AuthPasswordUpdating():
return passwordUpdating(_that);case AuthPasswordUpdateFailure():
return passwordUpdateFailure(_that);case AuthOauthPending():
return oauthPending(_that);case AuthAuthenticated():
return authenticated(_that);case AuthFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthReady value)?  ready,TResult? Function( AuthSubmitting value)?  submitting,TResult? Function( AuthEmailVerificationRequired value)?  emailVerificationRequired,TResult? Function( AuthPasswordResetSent value)?  passwordResetSent,TResult? Function( AuthPasswordRecovery value)?  passwordRecovery,TResult? Function( AuthPasswordUpdating value)?  passwordUpdating,TResult? Function( AuthPasswordUpdateFailure value)?  passwordUpdateFailure,TResult? Function( AuthOauthPending value)?  oauthPending,TResult? Function( AuthAuthenticated value)?  authenticated,TResult? Function( AuthFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AuthReady() when ready != null:
return ready(_that);case AuthSubmitting() when submitting != null:
return submitting(_that);case AuthEmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that);case AuthPasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that);case AuthPasswordRecovery() when passwordRecovery != null:
return passwordRecovery(_that);case AuthPasswordUpdating() when passwordUpdating != null:
return passwordUpdating(_that);case AuthPasswordUpdateFailure() when passwordUpdateFailure != null:
return passwordUpdateFailure(_that);case AuthOauthPending() when oauthPending != null:
return oauthPending(_that);case AuthAuthenticated() when authenticated != null:
return authenticated(_that);case AuthFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( AuthMode mode)?  ready,TResult Function( AuthMode mode)?  submitting,TResult Function( String email)?  emailVerificationRequired,TResult Function( String email)?  passwordResetSent,TResult Function()?  passwordRecovery,TResult Function()?  passwordUpdating,TResult Function( Failure failure)?  passwordUpdateFailure,TResult Function( AuthMode mode)?  oauthPending,TResult Function()?  authenticated,TResult Function( AuthMode mode,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthReady() when ready != null:
return ready(_that.mode);case AuthSubmitting() when submitting != null:
return submitting(_that.mode);case AuthEmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that.email);case AuthPasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that.email);case AuthPasswordRecovery() when passwordRecovery != null:
return passwordRecovery();case AuthPasswordUpdating() when passwordUpdating != null:
return passwordUpdating();case AuthPasswordUpdateFailure() when passwordUpdateFailure != null:
return passwordUpdateFailure(_that.failure);case AuthOauthPending() when oauthPending != null:
return oauthPending(_that.mode);case AuthAuthenticated() when authenticated != null:
return authenticated();case AuthFailure() when failure != null:
return failure(_that.mode,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( AuthMode mode)  ready,required TResult Function( AuthMode mode)  submitting,required TResult Function( String email)  emailVerificationRequired,required TResult Function( String email)  passwordResetSent,required TResult Function()  passwordRecovery,required TResult Function()  passwordUpdating,required TResult Function( Failure failure)  passwordUpdateFailure,required TResult Function( AuthMode mode)  oauthPending,required TResult Function()  authenticated,required TResult Function( AuthMode mode,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case AuthReady():
return ready(_that.mode);case AuthSubmitting():
return submitting(_that.mode);case AuthEmailVerificationRequired():
return emailVerificationRequired(_that.email);case AuthPasswordResetSent():
return passwordResetSent(_that.email);case AuthPasswordRecovery():
return passwordRecovery();case AuthPasswordUpdating():
return passwordUpdating();case AuthPasswordUpdateFailure():
return passwordUpdateFailure(_that.failure);case AuthOauthPending():
return oauthPending(_that.mode);case AuthAuthenticated():
return authenticated();case AuthFailure():
return failure(_that.mode,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( AuthMode mode)?  ready,TResult? Function( AuthMode mode)?  submitting,TResult? Function( String email)?  emailVerificationRequired,TResult? Function( String email)?  passwordResetSent,TResult? Function()?  passwordRecovery,TResult? Function()?  passwordUpdating,TResult? Function( Failure failure)?  passwordUpdateFailure,TResult? Function( AuthMode mode)?  oauthPending,TResult? Function()?  authenticated,TResult? Function( AuthMode mode,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case AuthReady() when ready != null:
return ready(_that.mode);case AuthSubmitting() when submitting != null:
return submitting(_that.mode);case AuthEmailVerificationRequired() when emailVerificationRequired != null:
return emailVerificationRequired(_that.email);case AuthPasswordResetSent() when passwordResetSent != null:
return passwordResetSent(_that.email);case AuthPasswordRecovery() when passwordRecovery != null:
return passwordRecovery();case AuthPasswordUpdating() when passwordUpdating != null:
return passwordUpdating();case AuthPasswordUpdateFailure() when passwordUpdateFailure != null:
return passwordUpdateFailure(_that.failure);case AuthOauthPending() when oauthPending != null:
return oauthPending(_that.mode);case AuthAuthenticated() when authenticated != null:
return authenticated();case AuthFailure() when failure != null:
return failure(_that.mode,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class AuthReady implements AuthState {
  const AuthReady(this.mode);


 final  AuthMode mode;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthReadyCopyWith<AuthReady> get copyWith => _$AuthReadyCopyWithImpl<AuthReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthReady&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthState.ready(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $AuthReadyCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthReadyCopyWith(AuthReady value, $Res Function(AuthReady) _then) = _$AuthReadyCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class _$AuthReadyCopyWithImpl<$Res>
    implements $AuthReadyCopyWith<$Res> {
  _$AuthReadyCopyWithImpl(this._self, this._then);

  final AuthReady _self;
  final $Res Function(AuthReady) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(AuthReady(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class AuthSubmitting implements AuthState {
  const AuthSubmitting(this.mode);


 final  AuthMode mode;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthSubmittingCopyWith<AuthSubmitting> get copyWith => _$AuthSubmittingCopyWithImpl<AuthSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthSubmitting&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthState.submitting(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $AuthSubmittingCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthSubmittingCopyWith(AuthSubmitting value, $Res Function(AuthSubmitting) _then) = _$AuthSubmittingCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class _$AuthSubmittingCopyWithImpl<$Res>
    implements $AuthSubmittingCopyWith<$Res> {
  _$AuthSubmittingCopyWithImpl(this._self, this._then);

  final AuthSubmitting _self;
  final $Res Function(AuthSubmitting) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(AuthSubmitting(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class AuthEmailVerificationRequired implements AuthState {
  const AuthEmailVerificationRequired(this.email);


 final  String email;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthEmailVerificationRequiredCopyWith<AuthEmailVerificationRequired> get copyWith => _$AuthEmailVerificationRequiredCopyWithImpl<AuthEmailVerificationRequired>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEmailVerificationRequired&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthState.emailVerificationRequired(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthEmailVerificationRequiredCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthEmailVerificationRequiredCopyWith(AuthEmailVerificationRequired value, $Res Function(AuthEmailVerificationRequired) _then) = _$AuthEmailVerificationRequiredCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthEmailVerificationRequiredCopyWithImpl<$Res>
    implements $AuthEmailVerificationRequiredCopyWith<$Res> {
  _$AuthEmailVerificationRequiredCopyWithImpl(this._self, this._then);

  final AuthEmailVerificationRequired _self;
  final $Res Function(AuthEmailVerificationRequired) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthEmailVerificationRequired(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordResetSent implements AuthState {
  const AuthPasswordResetSent(this.email);


 final  String email;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordResetSentCopyWith<AuthPasswordResetSent> get copyWith => _$AuthPasswordResetSentCopyWithImpl<AuthPasswordResetSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordResetSent&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthState.passwordResetSent(email: $email)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordResetSentCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthPasswordResetSentCopyWith(AuthPasswordResetSent value, $Res Function(AuthPasswordResetSent) _then) = _$AuthPasswordResetSentCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$AuthPasswordResetSentCopyWithImpl<$Res>
    implements $AuthPasswordResetSentCopyWith<$Res> {
  _$AuthPasswordResetSentCopyWithImpl(this._self, this._then);

  final AuthPasswordResetSent _self;
  final $Res Function(AuthPasswordResetSent) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(AuthPasswordResetSent(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AuthPasswordRecovery implements AuthState {
  const AuthPasswordRecovery();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordRecovery);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.passwordRecovery()';
}


}




/// @nodoc


class AuthPasswordUpdating implements AuthState {
  const AuthPasswordUpdating();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordUpdating);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.passwordUpdating()';
}


}




/// @nodoc


class AuthPasswordUpdateFailure implements AuthState {
  const AuthPasswordUpdateFailure(this.failure);


 final  Failure failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthPasswordUpdateFailureCopyWith<AuthPasswordUpdateFailure> get copyWith => _$AuthPasswordUpdateFailureCopyWithImpl<AuthPasswordUpdateFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthPasswordUpdateFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AuthState.passwordUpdateFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthPasswordUpdateFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthPasswordUpdateFailureCopyWith(AuthPasswordUpdateFailure value, $Res Function(AuthPasswordUpdateFailure) _then) = _$AuthPasswordUpdateFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$AuthPasswordUpdateFailureCopyWithImpl<$Res>
    implements $AuthPasswordUpdateFailureCopyWith<$Res> {
  _$AuthPasswordUpdateFailureCopyWithImpl(this._self, this._then);

  final AuthPasswordUpdateFailure _self;
  final $Res Function(AuthPasswordUpdateFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(AuthPasswordUpdateFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class AuthOauthPending implements AuthState {
  const AuthOauthPending(this.mode);


 final  AuthMode mode;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthOauthPendingCopyWith<AuthOauthPending> get copyWith => _$AuthOauthPendingCopyWithImpl<AuthOauthPending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthOauthPending&&(identical(other.mode, mode) || other.mode == mode));
}


@override
int get hashCode => Object.hash(runtimeType,mode);

@override
String toString() {
  return 'AuthState.oauthPending(mode: $mode)';
}


}

/// @nodoc
abstract mixin class $AuthOauthPendingCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthOauthPendingCopyWith(AuthOauthPending value, $Res Function(AuthOauthPending) _then) = _$AuthOauthPendingCopyWithImpl;
@useResult
$Res call({
 AuthMode mode
});




}
/// @nodoc
class _$AuthOauthPendingCopyWithImpl<$Res>
    implements $AuthOauthPendingCopyWith<$Res> {
  _$AuthOauthPendingCopyWithImpl(this._self, this._then);

  final AuthOauthPending _self;
  final $Res Function(AuthOauthPending) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,}) {
  return _then(AuthOauthPending(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,
  ));
}


}

/// @nodoc


class AuthAuthenticated implements AuthState {
  const AuthAuthenticated();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthAuthenticated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthState.authenticated()';
}


}




/// @nodoc


class AuthFailure implements AuthState {
  const AuthFailure(this.mode, this.failure);


 final  AuthMode mode;
 final  Failure failure;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthFailureCopyWith<AuthFailure> get copyWith => _$AuthFailureCopyWithImpl<AuthFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthFailure&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,mode,failure);

@override
String toString() {
  return 'AuthState.failure(mode: $mode, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AuthFailureCopyWith<$Res> implements $AuthStateCopyWith<$Res> {
  factory $AuthFailureCopyWith(AuthFailure value, $Res Function(AuthFailure) _then) = _$AuthFailureCopyWithImpl;
@useResult
$Res call({
 AuthMode mode, Failure failure
});




}
/// @nodoc
class _$AuthFailureCopyWithImpl<$Res>
    implements $AuthFailureCopyWith<$Res> {
  _$AuthFailureCopyWithImpl(this._self, this._then);

  final AuthFailure _self;
  final $Res Function(AuthFailure) _then;

/// Create a copy of AuthState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? mode = null,Object? failure = null,}) {
  return _then(AuthFailure(
null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as AuthMode,null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
