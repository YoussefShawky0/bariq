// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'vehicles_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VehiclesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VehiclesEvent()';
}


}

/// @nodoc
class $VehiclesEventCopyWith<$Res>  {
$VehiclesEventCopyWith(VehiclesEvent _, $Res Function(VehiclesEvent) __);
}


/// Adds pattern-matching-related methods to [VehiclesEvent].
extension VehiclesEventPatterns on VehiclesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VehiclesStarted value)?  started,TResult Function( VehicleSubmitted value)?  submitted,TResult Function( VehicleDeleteConfirmed value)?  deleteConfirmed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VehiclesStarted() when started != null:
return started(_that);case VehicleSubmitted() when submitted != null:
return submitted(_that);case VehicleDeleteConfirmed() when deleteConfirmed != null:
return deleteConfirmed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VehiclesStarted value)  started,required TResult Function( VehicleSubmitted value)  submitted,required TResult Function( VehicleDeleteConfirmed value)  deleteConfirmed,}){
final _that = this;
switch (_that) {
case VehiclesStarted():
return started(_that);case VehicleSubmitted():
return submitted(_that);case VehicleDeleteConfirmed():
return deleteConfirmed(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VehiclesStarted value)?  started,TResult? Function( VehicleSubmitted value)?  submitted,TResult? Function( VehicleDeleteConfirmed value)?  deleteConfirmed,}){
final _that = this;
switch (_that) {
case VehiclesStarted() when started != null:
return started(_that);case VehicleSubmitted() when submitted != null:
return submitted(_that);case VehicleDeleteConfirmed() when deleteConfirmed != null:
return deleteConfirmed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( VehicleInput input)?  submitted,TResult Function( String id)?  deleteConfirmed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VehiclesStarted() when started != null:
return started();case VehicleSubmitted() when submitted != null:
return submitted(_that.input);case VehicleDeleteConfirmed() when deleteConfirmed != null:
return deleteConfirmed(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( VehicleInput input)  submitted,required TResult Function( String id)  deleteConfirmed,}) {final _that = this;
switch (_that) {
case VehiclesStarted():
return started();case VehicleSubmitted():
return submitted(_that.input);case VehicleDeleteConfirmed():
return deleteConfirmed(_that.id);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( VehicleInput input)?  submitted,TResult? Function( String id)?  deleteConfirmed,}) {final _that = this;
switch (_that) {
case VehiclesStarted() when started != null:
return started();case VehicleSubmitted() when submitted != null:
return submitted(_that.input);case VehicleDeleteConfirmed() when deleteConfirmed != null:
return deleteConfirmed(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class VehiclesStarted implements VehiclesEvent {
  const VehiclesStarted();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VehiclesEvent.started()';
}


}




/// @nodoc


class VehicleSubmitted implements VehiclesEvent {
  const VehicleSubmitted(this.input);


 final  VehicleInput input;

/// Create a copy of VehiclesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleSubmittedCopyWith<VehicleSubmitted> get copyWith => _$VehicleSubmittedCopyWithImpl<VehicleSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleSubmitted&&(identical(other.input, input) || other.input == input));
}


@override
int get hashCode => Object.hash(runtimeType,input);

@override
String toString() {
  return 'VehiclesEvent.submitted(input: $input)';
}


}

/// @nodoc
abstract mixin class $VehicleSubmittedCopyWith<$Res> implements $VehiclesEventCopyWith<$Res> {
  factory $VehicleSubmittedCopyWith(VehicleSubmitted value, $Res Function(VehicleSubmitted) _then) = _$VehicleSubmittedCopyWithImpl;
@useResult
$Res call({
 VehicleInput input
});




}
/// @nodoc
class _$VehicleSubmittedCopyWithImpl<$Res>
    implements $VehicleSubmittedCopyWith<$Res> {
  _$VehicleSubmittedCopyWithImpl(this._self, this._then);

  final VehicleSubmitted _self;
  final $Res Function(VehicleSubmitted) _then;

/// Create a copy of VehiclesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? input = null,}) {
  return _then(VehicleSubmitted(
null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as VehicleInput,
  ));
}


}

/// @nodoc


class VehicleDeleteConfirmed implements VehiclesEvent {
  const VehicleDeleteConfirmed(this.id);


 final  String id;

/// Create a copy of VehiclesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehicleDeleteConfirmedCopyWith<VehicleDeleteConfirmed> get copyWith => _$VehicleDeleteConfirmedCopyWithImpl<VehicleDeleteConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehicleDeleteConfirmed&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'VehiclesEvent.deleteConfirmed(id: $id)';
}


}

/// @nodoc
abstract mixin class $VehicleDeleteConfirmedCopyWith<$Res> implements $VehiclesEventCopyWith<$Res> {
  factory $VehicleDeleteConfirmedCopyWith(VehicleDeleteConfirmed value, $Res Function(VehicleDeleteConfirmed) _then) = _$VehicleDeleteConfirmedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$VehicleDeleteConfirmedCopyWithImpl<$Res>
    implements $VehicleDeleteConfirmedCopyWith<$Res> {
  _$VehicleDeleteConfirmedCopyWithImpl(this._self, this._then);

  final VehicleDeleteConfirmed _self;
  final $Res Function(VehicleDeleteConfirmed) _then;

/// Create a copy of VehiclesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(VehicleDeleteConfirmed(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$VehiclesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VehiclesState()';
}


}

/// @nodoc
class $VehiclesStateCopyWith<$Res>  {
$VehiclesStateCopyWith(VehiclesState _, $Res Function(VehiclesState) __);
}


/// Adds pattern-matching-related methods to [VehiclesState].
extension VehiclesStatePatterns on VehiclesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VehiclesInitial value)?  initial,TResult Function( VehiclesLoading value)?  loading,TResult Function( VehiclesReady value)?  ready,TResult Function( VehiclesSaving value)?  saving,TResult Function( VehiclesDeleting value)?  deleting,TResult Function( VehiclesSuccess value)?  success,TResult Function( VehiclesLoadFailure value)?  loadFailure,TResult Function( VehiclesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VehiclesInitial() when initial != null:
return initial(_that);case VehiclesLoading() when loading != null:
return loading(_that);case VehiclesReady() when ready != null:
return ready(_that);case VehiclesSaving() when saving != null:
return saving(_that);case VehiclesDeleting() when deleting != null:
return deleting(_that);case VehiclesSuccess() when success != null:
return success(_that);case VehiclesLoadFailure() when loadFailure != null:
return loadFailure(_that);case VehiclesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VehiclesInitial value)  initial,required TResult Function( VehiclesLoading value)  loading,required TResult Function( VehiclesReady value)  ready,required TResult Function( VehiclesSaving value)  saving,required TResult Function( VehiclesDeleting value)  deleting,required TResult Function( VehiclesSuccess value)  success,required TResult Function( VehiclesLoadFailure value)  loadFailure,required TResult Function( VehiclesFailure value)  failure,}){
final _that = this;
switch (_that) {
case VehiclesInitial():
return initial(_that);case VehiclesLoading():
return loading(_that);case VehiclesReady():
return ready(_that);case VehiclesSaving():
return saving(_that);case VehiclesDeleting():
return deleting(_that);case VehiclesSuccess():
return success(_that);case VehiclesLoadFailure():
return loadFailure(_that);case VehiclesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VehiclesInitial value)?  initial,TResult? Function( VehiclesLoading value)?  loading,TResult? Function( VehiclesReady value)?  ready,TResult? Function( VehiclesSaving value)?  saving,TResult? Function( VehiclesDeleting value)?  deleting,TResult? Function( VehiclesSuccess value)?  success,TResult? Function( VehiclesLoadFailure value)?  loadFailure,TResult? Function( VehiclesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case VehiclesInitial() when initial != null:
return initial(_that);case VehiclesLoading() when loading != null:
return loading(_that);case VehiclesReady() when ready != null:
return ready(_that);case VehiclesSaving() when saving != null:
return saving(_that);case VehiclesDeleting() when deleting != null:
return deleting(_that);case VehiclesSuccess() when success != null:
return success(_that);case VehiclesLoadFailure() when loadFailure != null:
return loadFailure(_that);case VehiclesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Vehicle> vehicles)?  ready,TResult Function( List<Vehicle> vehicles)?  saving,TResult Function( List<Vehicle> vehicles,  String vehicleId)?  deleting,TResult Function( List<Vehicle> vehicles,  VehicleMutation mutation)?  success,TResult Function( Failure failure)?  loadFailure,TResult Function( List<Vehicle> vehicles,  Failure failure,  VehicleMutation mutation)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VehiclesInitial() when initial != null:
return initial();case VehiclesLoading() when loading != null:
return loading();case VehiclesReady() when ready != null:
return ready(_that.vehicles);case VehiclesSaving() when saving != null:
return saving(_that.vehicles);case VehiclesDeleting() when deleting != null:
return deleting(_that.vehicles,_that.vehicleId);case VehiclesSuccess() when success != null:
return success(_that.vehicles,_that.mutation);case VehiclesLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case VehiclesFailure() when failure != null:
return failure(_that.vehicles,_that.failure,_that.mutation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Vehicle> vehicles)  ready,required TResult Function( List<Vehicle> vehicles)  saving,required TResult Function( List<Vehicle> vehicles,  String vehicleId)  deleting,required TResult Function( List<Vehicle> vehicles,  VehicleMutation mutation)  success,required TResult Function( Failure failure)  loadFailure,required TResult Function( List<Vehicle> vehicles,  Failure failure,  VehicleMutation mutation)  failure,}) {final _that = this;
switch (_that) {
case VehiclesInitial():
return initial();case VehiclesLoading():
return loading();case VehiclesReady():
return ready(_that.vehicles);case VehiclesSaving():
return saving(_that.vehicles);case VehiclesDeleting():
return deleting(_that.vehicles,_that.vehicleId);case VehiclesSuccess():
return success(_that.vehicles,_that.mutation);case VehiclesLoadFailure():
return loadFailure(_that.failure);case VehiclesFailure():
return failure(_that.vehicles,_that.failure,_that.mutation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Vehicle> vehicles)?  ready,TResult? Function( List<Vehicle> vehicles)?  saving,TResult? Function( List<Vehicle> vehicles,  String vehicleId)?  deleting,TResult? Function( List<Vehicle> vehicles,  VehicleMutation mutation)?  success,TResult? Function( Failure failure)?  loadFailure,TResult? Function( List<Vehicle> vehicles,  Failure failure,  VehicleMutation mutation)?  failure,}) {final _that = this;
switch (_that) {
case VehiclesInitial() when initial != null:
return initial();case VehiclesLoading() when loading != null:
return loading();case VehiclesReady() when ready != null:
return ready(_that.vehicles);case VehiclesSaving() when saving != null:
return saving(_that.vehicles);case VehiclesDeleting() when deleting != null:
return deleting(_that.vehicles,_that.vehicleId);case VehiclesSuccess() when success != null:
return success(_that.vehicles,_that.mutation);case VehiclesLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case VehiclesFailure() when failure != null:
return failure(_that.vehicles,_that.failure,_that.mutation);case _:
  return null;

}
}

}

/// @nodoc


class VehiclesInitial implements VehiclesState {
  const VehiclesInitial();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VehiclesState.initial()';
}


}




/// @nodoc


class VehiclesLoading implements VehiclesState {
  const VehiclesLoading();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VehiclesState.loading()';
}


}




/// @nodoc


class VehiclesReady implements VehiclesState {
  const VehiclesReady(final  List<Vehicle> vehicles): _vehicles = vehicles;


 final  List<Vehicle> _vehicles;
 List<Vehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}


/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesReadyCopyWith<VehiclesReady> get copyWith => _$VehiclesReadyCopyWithImpl<VehiclesReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesReady&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'VehiclesState.ready(vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $VehiclesReadyCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesReadyCopyWith(VehiclesReady value, $Res Function(VehiclesReady) _then) = _$VehiclesReadyCopyWithImpl;
@useResult
$Res call({
 List<Vehicle> vehicles
});




}
/// @nodoc
class _$VehiclesReadyCopyWithImpl<$Res>
    implements $VehiclesReadyCopyWith<$Res> {
  _$VehiclesReadyCopyWithImpl(this._self, this._then);

  final VehiclesReady _self;
  final $Res Function(VehiclesReady) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicles = null,}) {
  return _then(VehiclesReady(
null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<Vehicle>,
  ));
}


}

/// @nodoc


class VehiclesSaving implements VehiclesState {
  const VehiclesSaving(final  List<Vehicle> vehicles): _vehicles = vehicles;


 final  List<Vehicle> _vehicles;
 List<Vehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}


/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesSavingCopyWith<VehiclesSaving> get copyWith => _$VehiclesSavingCopyWithImpl<VehiclesSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesSaving&&const DeepCollectionEquality().equals(other._vehicles, _vehicles));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vehicles));

@override
String toString() {
  return 'VehiclesState.saving(vehicles: $vehicles)';
}


}

/// @nodoc
abstract mixin class $VehiclesSavingCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesSavingCopyWith(VehiclesSaving value, $Res Function(VehiclesSaving) _then) = _$VehiclesSavingCopyWithImpl;
@useResult
$Res call({
 List<Vehicle> vehicles
});




}
/// @nodoc
class _$VehiclesSavingCopyWithImpl<$Res>
    implements $VehiclesSavingCopyWith<$Res> {
  _$VehiclesSavingCopyWithImpl(this._self, this._then);

  final VehiclesSaving _self;
  final $Res Function(VehiclesSaving) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicles = null,}) {
  return _then(VehiclesSaving(
null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<Vehicle>,
  ));
}


}

/// @nodoc


class VehiclesDeleting implements VehiclesState {
  const VehiclesDeleting(final  List<Vehicle> vehicles, this.vehicleId): _vehicles = vehicles;


 final  List<Vehicle> _vehicles;
 List<Vehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}

 final  String vehicleId;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesDeletingCopyWith<VehiclesDeleting> get copyWith => _$VehiclesDeletingCopyWithImpl<VehiclesDeleting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesDeleting&&const DeepCollectionEquality().equals(other._vehicles, _vehicles)&&(identical(other.vehicleId, vehicleId) || other.vehicleId == vehicleId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vehicles),vehicleId);

@override
String toString() {
  return 'VehiclesState.deleting(vehicles: $vehicles, vehicleId: $vehicleId)';
}


}

/// @nodoc
abstract mixin class $VehiclesDeletingCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesDeletingCopyWith(VehiclesDeleting value, $Res Function(VehiclesDeleting) _then) = _$VehiclesDeletingCopyWithImpl;
@useResult
$Res call({
 List<Vehicle> vehicles, String vehicleId
});




}
/// @nodoc
class _$VehiclesDeletingCopyWithImpl<$Res>
    implements $VehiclesDeletingCopyWith<$Res> {
  _$VehiclesDeletingCopyWithImpl(this._self, this._then);

  final VehiclesDeleting _self;
  final $Res Function(VehiclesDeleting) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicles = null,Object? vehicleId = null,}) {
  return _then(VehiclesDeleting(
null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<Vehicle>,null == vehicleId ? _self.vehicleId : vehicleId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class VehiclesSuccess implements VehiclesState {
  const VehiclesSuccess(final  List<Vehicle> vehicles, this.mutation): _vehicles = vehicles;


 final  List<Vehicle> _vehicles;
 List<Vehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}

 final  VehicleMutation mutation;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesSuccessCopyWith<VehiclesSuccess> get copyWith => _$VehiclesSuccessCopyWithImpl<VehiclesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesSuccess&&const DeepCollectionEquality().equals(other._vehicles, _vehicles)&&(identical(other.mutation, mutation) || other.mutation == mutation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vehicles),mutation);

@override
String toString() {
  return 'VehiclesState.success(vehicles: $vehicles, mutation: $mutation)';
}


}

/// @nodoc
abstract mixin class $VehiclesSuccessCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesSuccessCopyWith(VehiclesSuccess value, $Res Function(VehiclesSuccess) _then) = _$VehiclesSuccessCopyWithImpl;
@useResult
$Res call({
 List<Vehicle> vehicles, VehicleMutation mutation
});




}
/// @nodoc
class _$VehiclesSuccessCopyWithImpl<$Res>
    implements $VehiclesSuccessCopyWith<$Res> {
  _$VehiclesSuccessCopyWithImpl(this._self, this._then);

  final VehiclesSuccess _self;
  final $Res Function(VehiclesSuccess) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicles = null,Object? mutation = null,}) {
  return _then(VehiclesSuccess(
null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<Vehicle>,null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as VehicleMutation,
  ));
}


}

/// @nodoc


class VehiclesLoadFailure implements VehiclesState {
  const VehiclesLoadFailure(this.failure);


 final  Failure failure;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesLoadFailureCopyWith<VehiclesLoadFailure> get copyWith => _$VehiclesLoadFailureCopyWithImpl<VehiclesLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'VehiclesState.loadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $VehiclesLoadFailureCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesLoadFailureCopyWith(VehiclesLoadFailure value, $Res Function(VehiclesLoadFailure) _then) = _$VehiclesLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$VehiclesLoadFailureCopyWithImpl<$Res>
    implements $VehiclesLoadFailureCopyWith<$Res> {
  _$VehiclesLoadFailureCopyWithImpl(this._self, this._then);

  final VehiclesLoadFailure _self;
  final $Res Function(VehiclesLoadFailure) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(VehiclesLoadFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class VehiclesFailure implements VehiclesState {
  const VehiclesFailure(final  List<Vehicle> vehicles, this.failure, this.mutation): _vehicles = vehicles;


 final  List<Vehicle> _vehicles;
 List<Vehicle> get vehicles {
  if (_vehicles is EqualUnmodifiableListView) return _vehicles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_vehicles);
}

 final  Failure failure;
 final  VehicleMutation mutation;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VehiclesFailureCopyWith<VehiclesFailure> get copyWith => _$VehiclesFailureCopyWithImpl<VehiclesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VehiclesFailure&&const DeepCollectionEquality().equals(other._vehicles, _vehicles)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.mutation, mutation) || other.mutation == mutation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_vehicles),failure,mutation);

@override
String toString() {
  return 'VehiclesState.failure(vehicles: $vehicles, failure: $failure, mutation: $mutation)';
}


}

/// @nodoc
abstract mixin class $VehiclesFailureCopyWith<$Res> implements $VehiclesStateCopyWith<$Res> {
  factory $VehiclesFailureCopyWith(VehiclesFailure value, $Res Function(VehiclesFailure) _then) = _$VehiclesFailureCopyWithImpl;
@useResult
$Res call({
 List<Vehicle> vehicles, Failure failure, VehicleMutation mutation
});




}
/// @nodoc
class _$VehiclesFailureCopyWithImpl<$Res>
    implements $VehiclesFailureCopyWith<$Res> {
  _$VehiclesFailureCopyWithImpl(this._self, this._then);

  final VehiclesFailure _self;
  final $Res Function(VehiclesFailure) _then;

/// Create a copy of VehiclesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicles = null,Object? failure = null,Object? mutation = null,}) {
  return _then(VehiclesFailure(
null == vehicles ? _self._vehicles : vehicles // ignore: cast_nullable_to_non_nullable
as List<Vehicle>,null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as VehicleMutation,
  ));
}


}

// dart format on
