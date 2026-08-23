// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_catalog_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServiceCatalogState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCatalogState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceCatalogState()';
}


}

/// @nodoc
class $ServiceCatalogStateCopyWith<$Res>  {
$ServiceCatalogStateCopyWith(ServiceCatalogState _, $Res Function(ServiceCatalogState) __);
}


/// Adds pattern-matching-related methods to [ServiceCatalogState].
extension ServiceCatalogStatePatterns on ServiceCatalogState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServiceCatalogInitial value)?  initial,TResult Function( ServiceCatalogLoading value)?  loading,TResult Function( ServiceCatalogReady value)?  ready,TResult Function( ServiceCatalogFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServiceCatalogInitial() when initial != null:
return initial(_that);case ServiceCatalogLoading() when loading != null:
return loading(_that);case ServiceCatalogReady() when ready != null:
return ready(_that);case ServiceCatalogFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServiceCatalogInitial value)  initial,required TResult Function( ServiceCatalogLoading value)  loading,required TResult Function( ServiceCatalogReady value)  ready,required TResult Function( ServiceCatalogFailure value)  failure,}){
final _that = this;
switch (_that) {
case ServiceCatalogInitial():
return initial(_that);case ServiceCatalogLoading():
return loading(_that);case ServiceCatalogReady():
return ready(_that);case ServiceCatalogFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServiceCatalogInitial value)?  initial,TResult? Function( ServiceCatalogLoading value)?  loading,TResult? Function( ServiceCatalogReady value)?  ready,TResult? Function( ServiceCatalogFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ServiceCatalogInitial() when initial != null:
return initial(_that);case ServiceCatalogLoading() when loading != null:
return loading(_that);case ServiceCatalogReady() when ready != null:
return ready(_that);case ServiceCatalogFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Service> services)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServiceCatalogInitial() when initial != null:
return initial();case ServiceCatalogLoading() when loading != null:
return loading();case ServiceCatalogReady() when ready != null:
return ready(_that.services);case ServiceCatalogFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Service> services)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ServiceCatalogInitial():
return initial();case ServiceCatalogLoading():
return loading();case ServiceCatalogReady():
return ready(_that.services);case ServiceCatalogFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Service> services)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ServiceCatalogInitial() when initial != null:
return initial();case ServiceCatalogLoading() when loading != null:
return loading();case ServiceCatalogReady() when ready != null:
return ready(_that.services);case ServiceCatalogFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ServiceCatalogInitial implements ServiceCatalogState {
  const ServiceCatalogInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCatalogInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceCatalogState.initial()';
}


}




/// @nodoc


class ServiceCatalogLoading implements ServiceCatalogState {
  const ServiceCatalogLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCatalogLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceCatalogState.loading()';
}


}




/// @nodoc


class ServiceCatalogReady implements ServiceCatalogState {
  const ServiceCatalogReady(final  List<Service> services): _services = services;
  

 final  List<Service> _services;
 List<Service> get services {
  if (_services is EqualUnmodifiableListView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_services);
}


/// Create a copy of ServiceCatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCatalogReadyCopyWith<ServiceCatalogReady> get copyWith => _$ServiceCatalogReadyCopyWithImpl<ServiceCatalogReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCatalogReady&&const DeepCollectionEquality().equals(other._services, _services));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_services));

@override
String toString() {
  return 'ServiceCatalogState.ready(services: $services)';
}


}

/// @nodoc
abstract mixin class $ServiceCatalogReadyCopyWith<$Res> implements $ServiceCatalogStateCopyWith<$Res> {
  factory $ServiceCatalogReadyCopyWith(ServiceCatalogReady value, $Res Function(ServiceCatalogReady) _then) = _$ServiceCatalogReadyCopyWithImpl;
@useResult
$Res call({
 List<Service> services
});




}
/// @nodoc
class _$ServiceCatalogReadyCopyWithImpl<$Res>
    implements $ServiceCatalogReadyCopyWith<$Res> {
  _$ServiceCatalogReadyCopyWithImpl(this._self, this._then);

  final ServiceCatalogReady _self;
  final $Res Function(ServiceCatalogReady) _then;

/// Create a copy of ServiceCatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? services = null,}) {
  return _then(ServiceCatalogReady(
null == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as List<Service>,
  ));
}


}

/// @nodoc


class ServiceCatalogFailure implements ServiceCatalogState {
  const ServiceCatalogFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ServiceCatalogState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceCatalogFailureCopyWith<ServiceCatalogFailure> get copyWith => _$ServiceCatalogFailureCopyWithImpl<ServiceCatalogFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceCatalogFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ServiceCatalogState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ServiceCatalogFailureCopyWith<$Res> implements $ServiceCatalogStateCopyWith<$Res> {
  factory $ServiceCatalogFailureCopyWith(ServiceCatalogFailure value, $Res Function(ServiceCatalogFailure) _then) = _$ServiceCatalogFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ServiceCatalogFailureCopyWithImpl<$Res>
    implements $ServiceCatalogFailureCopyWith<$Res> {
  _$ServiceCatalogFailureCopyWithImpl(this._self, this._then);

  final ServiceCatalogFailure _self;
  final $Res Function(ServiceCatalogFailure) _then;

/// Create a copy of ServiceCatalogState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ServiceCatalogFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc
mixin _$ServiceDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceDetailState()';
}


}

/// @nodoc
class $ServiceDetailStateCopyWith<$Res>  {
$ServiceDetailStateCopyWith(ServiceDetailState _, $Res Function(ServiceDetailState) __);
}


/// Adds pattern-matching-related methods to [ServiceDetailState].
extension ServiceDetailStatePatterns on ServiceDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServiceDetailInitial value)?  initial,TResult Function( ServiceDetailLoading value)?  loading,TResult Function( ServiceDetailReady value)?  ready,TResult Function( ServiceDetailFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServiceDetailInitial() when initial != null:
return initial(_that);case ServiceDetailLoading() when loading != null:
return loading(_that);case ServiceDetailReady() when ready != null:
return ready(_that);case ServiceDetailFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServiceDetailInitial value)  initial,required TResult Function( ServiceDetailLoading value)  loading,required TResult Function( ServiceDetailReady value)  ready,required TResult Function( ServiceDetailFailure value)  failure,}){
final _that = this;
switch (_that) {
case ServiceDetailInitial():
return initial(_that);case ServiceDetailLoading():
return loading(_that);case ServiceDetailReady():
return ready(_that);case ServiceDetailFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServiceDetailInitial value)?  initial,TResult? Function( ServiceDetailLoading value)?  loading,TResult? Function( ServiceDetailReady value)?  ready,TResult? Function( ServiceDetailFailure value)?  failure,}){
final _that = this;
switch (_that) {
case ServiceDetailInitial() when initial != null:
return initial(_that);case ServiceDetailLoading() when loading != null:
return loading(_that);case ServiceDetailReady() when ready != null:
return ready(_that);case ServiceDetailFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( ServiceDetail detail)?  ready,TResult Function( Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServiceDetailInitial() when initial != null:
return initial();case ServiceDetailLoading() when loading != null:
return loading();case ServiceDetailReady() when ready != null:
return ready(_that.detail);case ServiceDetailFailure() when failure != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( ServiceDetail detail)  ready,required TResult Function( Failure failure)  failure,}) {final _that = this;
switch (_that) {
case ServiceDetailInitial():
return initial();case ServiceDetailLoading():
return loading();case ServiceDetailReady():
return ready(_that.detail);case ServiceDetailFailure():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( ServiceDetail detail)?  ready,TResult? Function( Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case ServiceDetailInitial() when initial != null:
return initial();case ServiceDetailLoading() when loading != null:
return loading();case ServiceDetailReady() when ready != null:
return ready(_that.detail);case ServiceDetailFailure() when failure != null:
return failure(_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class ServiceDetailInitial implements ServiceDetailState {
  const ServiceDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceDetailState.initial()';
}


}




/// @nodoc


class ServiceDetailLoading implements ServiceDetailState {
  const ServiceDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServiceDetailState.loading()';
}


}




/// @nodoc


class ServiceDetailReady implements ServiceDetailState {
  const ServiceDetailReady(this.detail);
  

 final  ServiceDetail detail;

/// Create a copy of ServiceDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceDetailReadyCopyWith<ServiceDetailReady> get copyWith => _$ServiceDetailReadyCopyWithImpl<ServiceDetailReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDetailReady&&(identical(other.detail, detail) || other.detail == detail));
}


@override
int get hashCode => Object.hash(runtimeType,detail);

@override
String toString() {
  return 'ServiceDetailState.ready(detail: $detail)';
}


}

/// @nodoc
abstract mixin class $ServiceDetailReadyCopyWith<$Res> implements $ServiceDetailStateCopyWith<$Res> {
  factory $ServiceDetailReadyCopyWith(ServiceDetailReady value, $Res Function(ServiceDetailReady) _then) = _$ServiceDetailReadyCopyWithImpl;
@useResult
$Res call({
 ServiceDetail detail
});




}
/// @nodoc
class _$ServiceDetailReadyCopyWithImpl<$Res>
    implements $ServiceDetailReadyCopyWith<$Res> {
  _$ServiceDetailReadyCopyWithImpl(this._self, this._then);

  final ServiceDetailReady _self;
  final $Res Function(ServiceDetailReady) _then;

/// Create a copy of ServiceDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? detail = null,}) {
  return _then(ServiceDetailReady(
null == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as ServiceDetail,
  ));
}


}

/// @nodoc


class ServiceDetailFailure implements ServiceDetailState {
  const ServiceDetailFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of ServiceDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceDetailFailureCopyWith<ServiceDetailFailure> get copyWith => _$ServiceDetailFailureCopyWithImpl<ServiceDetailFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceDetailFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'ServiceDetailState.failure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $ServiceDetailFailureCopyWith<$Res> implements $ServiceDetailStateCopyWith<$Res> {
  factory $ServiceDetailFailureCopyWith(ServiceDetailFailure value, $Res Function(ServiceDetailFailure) _then) = _$ServiceDetailFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$ServiceDetailFailureCopyWithImpl<$Res>
    implements $ServiceDetailFailureCopyWith<$Res> {
  _$ServiceDetailFailureCopyWithImpl(this._self, this._then);

  final ServiceDetailFailure _self;
  final $Res Function(ServiceDetailFailure) _then;

/// Create a copy of ServiceDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(ServiceDetailFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
