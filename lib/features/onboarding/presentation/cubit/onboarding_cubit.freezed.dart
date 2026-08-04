// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OnboardingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState()';
}


}

/// @nodoc
class $OnboardingStateCopyWith<$Res>  {
$OnboardingStateCopyWith(OnboardingState _, $Res Function(OnboardingState) __);
}


/// Adds pattern-matching-related methods to [OnboardingState].
extension OnboardingStatePatterns on OnboardingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnboardingViewing value)?  viewing,TResult Function( OnboardingSaving value)?  saving,TResult Function( OnboardingCompleted value)?  completed,TResult Function( OnboardingFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnboardingViewing() when viewing != null:
return viewing(_that);case OnboardingSaving() when saving != null:
return saving(_that);case OnboardingCompleted() when completed != null:
return completed(_that);case OnboardingFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnboardingViewing value)  viewing,required TResult Function( OnboardingSaving value)  saving,required TResult Function( OnboardingCompleted value)  completed,required TResult Function( OnboardingFailure value)  failure,}){
final _that = this;
switch (_that) {
case OnboardingViewing():
return viewing(_that);case OnboardingSaving():
return saving(_that);case OnboardingCompleted():
return completed(_that);case OnboardingFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnboardingViewing value)?  viewing,TResult? Function( OnboardingSaving value)?  saving,TResult? Function( OnboardingCompleted value)?  completed,TResult? Function( OnboardingFailure value)?  failure,}){
final _that = this;
switch (_that) {
case OnboardingViewing() when viewing != null:
return viewing(_that);case OnboardingSaving() when saving != null:
return saving(_that);case OnboardingCompleted() when completed != null:
return completed(_that);case OnboardingFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int currentPage)?  viewing,TResult Function( int currentPage)?  saving,TResult Function()?  completed,TResult Function( int currentPage,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnboardingViewing() when viewing != null:
return viewing(_that.currentPage);case OnboardingSaving() when saving != null:
return saving(_that.currentPage);case OnboardingCompleted() when completed != null:
return completed();case OnboardingFailure() when failure != null:
return failure(_that.currentPage,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int currentPage)  viewing,required TResult Function( int currentPage)  saving,required TResult Function()  completed,required TResult Function( int currentPage,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case OnboardingViewing():
return viewing(_that.currentPage);case OnboardingSaving():
return saving(_that.currentPage);case OnboardingCompleted():
return completed();case OnboardingFailure():
return failure(_that.currentPage,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int currentPage)?  viewing,TResult? Function( int currentPage)?  saving,TResult? Function()?  completed,TResult? Function( int currentPage,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case OnboardingViewing() when viewing != null:
return viewing(_that.currentPage);case OnboardingSaving() when saving != null:
return saving(_that.currentPage);case OnboardingCompleted() when completed != null:
return completed();case OnboardingFailure() when failure != null:
return failure(_that.currentPage,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class OnboardingViewing extends OnboardingState {
  const OnboardingViewing({required this.currentPage}): super._();


 final  int currentPage;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingViewingCopyWith<OnboardingViewing> get copyWith => _$OnboardingViewingCopyWithImpl<OnboardingViewing>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingViewing&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPage);

@override
String toString() {
  return 'OnboardingState.viewing(currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $OnboardingViewingCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory $OnboardingViewingCopyWith(OnboardingViewing value, $Res Function(OnboardingViewing) _then) = _$OnboardingViewingCopyWithImpl;
@useResult
$Res call({
 int currentPage
});




}
/// @nodoc
class _$OnboardingViewingCopyWithImpl<$Res>
    implements $OnboardingViewingCopyWith<$Res> {
  _$OnboardingViewingCopyWithImpl(this._self, this._then);

  final OnboardingViewing _self;
  final $Res Function(OnboardingViewing) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentPage = null,}) {
  return _then(OnboardingViewing(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnboardingSaving extends OnboardingState {
  const OnboardingSaving({required this.currentPage}): super._();


 final  int currentPage;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingSavingCopyWith<OnboardingSaving> get copyWith => _$OnboardingSavingCopyWithImpl<OnboardingSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingSaving&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage));
}


@override
int get hashCode => Object.hash(runtimeType,currentPage);

@override
String toString() {
  return 'OnboardingState.saving(currentPage: $currentPage)';
}


}

/// @nodoc
abstract mixin class $OnboardingSavingCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory $OnboardingSavingCopyWith(OnboardingSaving value, $Res Function(OnboardingSaving) _then) = _$OnboardingSavingCopyWithImpl;
@useResult
$Res call({
 int currentPage
});




}
/// @nodoc
class _$OnboardingSavingCopyWithImpl<$Res>
    implements $OnboardingSavingCopyWith<$Res> {
  _$OnboardingSavingCopyWithImpl(this._self, this._then);

  final OnboardingSaving _self;
  final $Res Function(OnboardingSaving) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentPage = null,}) {
  return _then(OnboardingSaving(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnboardingCompleted extends OnboardingState {
  const OnboardingCompleted(): super._();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OnboardingState.completed()';
}


}




/// @nodoc


class OnboardingFailure extends OnboardingState {
  const OnboardingFailure({required this.currentPage, required this.failure}): super._();


 final  int currentPage;
 final  Failure failure;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingFailureCopyWith<OnboardingFailure> get copyWith => _$OnboardingFailureCopyWithImpl<OnboardingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingFailure&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,currentPage,failure);

@override
String toString() {
  return 'OnboardingState.failure(currentPage: $currentPage, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $OnboardingFailureCopyWith<$Res> implements $OnboardingStateCopyWith<$Res> {
  factory $OnboardingFailureCopyWith(OnboardingFailure value, $Res Function(OnboardingFailure) _then) = _$OnboardingFailureCopyWithImpl;
@useResult
$Res call({
 int currentPage, Failure failure
});




}
/// @nodoc
class _$OnboardingFailureCopyWithImpl<$Res>
    implements $OnboardingFailureCopyWith<$Res> {
  _$OnboardingFailureCopyWithImpl(this._self, this._then);

  final OnboardingFailure _self;
  final $Res Function(OnboardingFailure) _then;

/// Create a copy of OnboardingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentPage = null,Object? failure = null,}) {
  return _then(OnboardingFailure(
currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,failure: null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
