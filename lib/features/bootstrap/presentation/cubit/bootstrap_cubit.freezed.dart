// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bootstrap_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BootstrapState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootstrapState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootstrapState()';
}


}

/// @nodoc
class $BootstrapStateCopyWith<$Res>  {
$BootstrapStateCopyWith(BootstrapState _, $Res Function(BootstrapState) __);
}


/// Adds pattern-matching-related methods to [BootstrapState].
extension BootstrapStatePatterns on BootstrapState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BootstrapInitial value)?  initial,TResult Function( BootstrapLoading value)?  loading,TResult Function( BootstrapReady value)?  ready,TResult Function( BootstrapFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BootstrapInitial() when initial != null:
return initial(_that);case BootstrapLoading() when loading != null:
return loading(_that);case BootstrapReady() when ready != null:
return ready(_that);case BootstrapFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BootstrapInitial value)  initial,required TResult Function( BootstrapLoading value)  loading,required TResult Function( BootstrapReady value)  ready,required TResult Function( BootstrapFailure value)  failure,}){
final _that = this;
switch (_that) {
case BootstrapInitial():
return initial(_that);case BootstrapLoading():
return loading(_that);case BootstrapReady():
return ready(_that);case BootstrapFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BootstrapInitial value)?  initial,TResult? Function( BootstrapLoading value)?  loading,TResult? Function( BootstrapReady value)?  ready,TResult? Function( BootstrapFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BootstrapInitial() when initial != null:
return initial(_that);case BootstrapLoading() when loading != null:
return loading(_that);case BootstrapReady() when ready != null:
return ready(_that);case BootstrapFailure() when failure != null:
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
case BootstrapInitial() when initial != null:
return initial();case BootstrapLoading() when loading != null:
return loading();case BootstrapReady() when ready != null:
return ready(_that.destination);case BootstrapFailure() when failure != null:
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
case BootstrapInitial():
return initial();case BootstrapLoading():
return loading();case BootstrapReady():
return ready(_that.destination);case BootstrapFailure():
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
case BootstrapInitial() when initial != null:
return initial();case BootstrapLoading() when loading != null:
return loading();case BootstrapReady() when ready != null:
return ready(_that.destination);case BootstrapFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class BootstrapInitial implements BootstrapState {
  const BootstrapInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootstrapInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootstrapState.initial()';
}


}




/// @nodoc


class BootstrapLoading implements BootstrapState {
  const BootstrapLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootstrapLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BootstrapState.loading()';
}


}




/// @nodoc


class BootstrapReady implements BootstrapState {
  const BootstrapReady(this.destination);
  

 final  AppDestination destination;

/// Create a copy of BootstrapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BootstrapReadyCopyWith<BootstrapReady> get copyWith => _$BootstrapReadyCopyWithImpl<BootstrapReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootstrapReady&&(identical(other.destination, destination) || other.destination == destination));
}


@override
int get hashCode => Object.hash(runtimeType,destination);

@override
String toString() {
  return 'BootstrapState.ready(destination: $destination)';
}


}

/// @nodoc
abstract mixin class $BootstrapReadyCopyWith<$Res> implements $BootstrapStateCopyWith<$Res> {
  factory $BootstrapReadyCopyWith(BootstrapReady value, $Res Function(BootstrapReady) _then) = _$BootstrapReadyCopyWithImpl;
@useResult
$Res call({
 AppDestination destination
});




}
/// @nodoc
class _$BootstrapReadyCopyWithImpl<$Res>
    implements $BootstrapReadyCopyWith<$Res> {
  _$BootstrapReadyCopyWithImpl(this._self, this._then);

  final BootstrapReady _self;
  final $Res Function(BootstrapReady) _then;

/// Create a copy of BootstrapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? destination = null,}) {
  return _then(BootstrapReady(
null == destination ? _self.destination : destination // ignore: cast_nullable_to_non_nullable
as AppDestination,
  ));
}


}

/// @nodoc


class BootstrapFailure implements BootstrapState {
  const BootstrapFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of BootstrapState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BootstrapFailureCopyWith<BootstrapFailure> get copyWith => _$BootstrapFailureCopyWithImpl<BootstrapFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BootstrapFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'BootstrapState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BootstrapFailureCopyWith<$Res> implements $BootstrapStateCopyWith<$Res> {
  factory $BootstrapFailureCopyWith(BootstrapFailure value, $Res Function(BootstrapFailure) _then) = _$BootstrapFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$BootstrapFailureCopyWithImpl<$Res>
    implements $BootstrapFailureCopyWith<$Res> {
  _$BootstrapFailureCopyWithImpl(this._self, this._then);

  final BootstrapFailure _self;
  final $Res Function(BootstrapFailure) _then;

/// Create a copy of BootstrapState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(BootstrapFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
