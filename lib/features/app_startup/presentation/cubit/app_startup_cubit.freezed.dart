// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_startup_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppStartupState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStartupState()';
}


}

/// @nodoc
class $AppStartupStateCopyWith<$Res>  {
$AppStartupStateCopyWith(AppStartupState _, $Res Function(AppStartupState) __);
}


/// Adds pattern-matching-related methods to [AppStartupState].
extension AppStartupStatePatterns on AppStartupState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AppStartupInitial value)?  initial,TResult Function( AppStartupLoading value)?  loading,TResult Function( AppStartupReady value)?  ready,TResult Function( AppStartupFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AppStartupInitial() when initial != null:
return initial(_that);case AppStartupLoading() when loading != null:
return loading(_that);case AppStartupReady() when ready != null:
return ready(_that);case AppStartupFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AppStartupInitial value)  initial,required TResult Function( AppStartupLoading value)  loading,required TResult Function( AppStartupReady value)  ready,required TResult Function( AppStartupFailure value)  failure,}){
final _that = this;
switch (_that) {
case AppStartupInitial():
return initial(_that);case AppStartupLoading():
return loading(_that);case AppStartupReady():
return ready(_that);case AppStartupFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AppStartupInitial value)?  initial,TResult? Function( AppStartupLoading value)?  loading,TResult? Function( AppStartupReady value)?  ready,TResult? Function( AppStartupFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AppStartupInitial() when initial != null:
return initial(_that);case AppStartupLoading() when loading != null:
return loading(_that);case AppStartupReady() when ready != null:
return ready(_that);case AppStartupFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( AppDestination destination)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AppStartupInitial() when initial != null:
return initial();case AppStartupLoading() when loading != null:
return loading();case AppStartupReady() when ready != null:
return ready(_that.destination);case AppStartupFailure() when failure != null:
return failure(_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( AppDestination destination)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case AppStartupInitial():
return initial();case AppStartupLoading():
return loading();case AppStartupReady():
return ready(_that.destination);case AppStartupFailure():
return failure(_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( AppDestination destination)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case AppStartupInitial() when initial != null:
return initial();case AppStartupLoading() when loading != null:
return loading();case AppStartupReady() when ready != null:
return ready(_that.destination);case AppStartupFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class AppStartupInitial implements AppStartupState {
  const AppStartupInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStartupState.initial()';
}


}




/// @nodoc


class AppStartupLoading implements AppStartupState {
  const AppStartupLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AppStartupState.loading()';
}


}




/// @nodoc


class AppStartupReady implements AppStartupState {
  const AppStartupReady(this.destination);
  

 final  AppDestination destination;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupReadyCopyWith<AppStartupReady> get copyWith => _$AppStartupReadyCopyWithImpl<AppStartupReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupReady&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode => Object.hash(runtimeType,destination);

@override
String toString() {
  return 'AppStartupState.ready(destination: $destination)';
}


}

/// @nodoc
abstract mixin class $AppStartupReadyCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupReadyCopyWith(AppStartupReady value, $Res Function(AppStartupReady) _then) = _$AppStartupReadyCopyWithImpl;
@useResult
$Res call({
 AppDestination destination
});




}
/// @nodoc
class _$AppStartupReadyCopyWithImpl<$Res>
    implements $AppStartupReadyCopyWith<$Res> {
  _$AppStartupReadyCopyWithImpl(this._self, this._then);

  final AppStartupReady _self;
  final $Res Function(AppStartupReady) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destination = null,}) {
  return _then(AppStartupReady(
null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as AppDestination,
  ));
}


}

/// @nodoc


class AppStartupFailure implements AppStartupState {
  const AppStartupFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppStartupFailureCopyWith<AppStartupFailure> get copyWith => _$AppStartupFailureCopyWithImpl<AppStartupFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppStartupFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AppStartupState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AppStartupFailureCopyWith<$Res> implements $AppStartupStateCopyWith<$Res> {
  factory $AppStartupFailureCopyWith(AppStartupFailure value, $Res Function(AppStartupFailure) _then) = _$AppStartupFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$AppStartupFailureCopyWithImpl<$Res>
    implements $AppStartupFailureCopyWith<$Res> {
  _$AppStartupFailureCopyWithImpl(this._self, this._then);

  final AppStartupFailure _self;
  final $Res Function(AppStartupFailure) _then;

/// Create a copy of AppStartupState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(AppStartupFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
