// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'addresses_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddressesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressesEvent()';
}


}

/// @nodoc
class $AddressesEventCopyWith<$Res>  {
$AddressesEventCopyWith(AddressesEvent _, $Res Function(AddressesEvent) __);
}


/// Adds pattern-matching-related methods to [AddressesEvent].
extension AddressesEventPatterns on AddressesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddressesStarted value)?  started,TResult Function( AddressSubmitted value)?  submitted,TResult Function( AddressDeleteConfirmed value)?  deleteConfirmed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddressesStarted() when started != null:
return started(_that);case AddressSubmitted() when submitted != null:
return submitted(_that);case AddressDeleteConfirmed() when deleteConfirmed != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddressesStarted value)  started,required TResult Function( AddressSubmitted value)  submitted,required TResult Function( AddressDeleteConfirmed value)  deleteConfirmed,}){
final _that = this;
switch (_that) {
case AddressesStarted():
return started(_that);case AddressSubmitted():
return submitted(_that);case AddressDeleteConfirmed():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddressesStarted value)?  started,TResult? Function( AddressSubmitted value)?  submitted,TResult? Function( AddressDeleteConfirmed value)?  deleteConfirmed,}){
final _that = this;
switch (_that) {
case AddressesStarted() when started != null:
return started(_that);case AddressSubmitted() when submitted != null:
return submitted(_that);case AddressDeleteConfirmed() when deleteConfirmed != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( AddressInput input)?  submitted,TResult Function( String id)?  deleteConfirmed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddressesStarted() when started != null:
return started();case AddressSubmitted() when submitted != null:
return submitted(_that.input);case AddressDeleteConfirmed() when deleteConfirmed != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( AddressInput input)  submitted,required TResult Function( String id)  deleteConfirmed,}) {final _that = this;
switch (_that) {
case AddressesStarted():
return started();case AddressSubmitted():
return submitted(_that.input);case AddressDeleteConfirmed():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( AddressInput input)?  submitted,TResult? Function( String id)?  deleteConfirmed,}) {final _that = this;
switch (_that) {
case AddressesStarted() when started != null:
return started();case AddressSubmitted() when submitted != null:
return submitted(_that.input);case AddressDeleteConfirmed() when deleteConfirmed != null:
return deleteConfirmed(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class AddressesStarted implements AddressesEvent {
  const AddressesStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressesEvent.started()';
}


}




/// @nodoc


class AddressSubmitted implements AddressesEvent {
  const AddressSubmitted(this.input);
  

 final  AddressInput input;

/// Create a copy of AddressesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressSubmittedCopyWith<AddressSubmitted> get copyWith => _$AddressSubmittedCopyWithImpl<AddressSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressSubmitted&&(identical(other.input, input) || other.input == input));
}


@override
int get hashCode => Object.hash(runtimeType,input);

@override
String toString() {
  return 'AddressesEvent.submitted(input: $input)';
}


}

/// @nodoc
abstract mixin class $AddressSubmittedCopyWith<$Res> implements $AddressesEventCopyWith<$Res> {
  factory $AddressSubmittedCopyWith(AddressSubmitted value, $Res Function(AddressSubmitted) _then) = _$AddressSubmittedCopyWithImpl;
@useResult
$Res call({
 AddressInput input
});




}
/// @nodoc
class _$AddressSubmittedCopyWithImpl<$Res>
    implements $AddressSubmittedCopyWith<$Res> {
  _$AddressSubmittedCopyWithImpl(this._self, this._then);

  final AddressSubmitted _self;
  final $Res Function(AddressSubmitted) _then;

/// Create a copy of AddressesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? input = null,}) {
  return _then(AddressSubmitted(
null == input ? _self.input : input // ignore: cast_nullable_to_non_nullable
as AddressInput,
  ));
}


}

/// @nodoc


class AddressDeleteConfirmed implements AddressesEvent {
  const AddressDeleteConfirmed(this.id);
  

 final  String id;

/// Create a copy of AddressesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressDeleteConfirmedCopyWith<AddressDeleteConfirmed> get copyWith => _$AddressDeleteConfirmedCopyWithImpl<AddressDeleteConfirmed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressDeleteConfirmed&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'AddressesEvent.deleteConfirmed(id: $id)';
}


}

/// @nodoc
abstract mixin class $AddressDeleteConfirmedCopyWith<$Res> implements $AddressesEventCopyWith<$Res> {
  factory $AddressDeleteConfirmedCopyWith(AddressDeleteConfirmed value, $Res Function(AddressDeleteConfirmed) _then) = _$AddressDeleteConfirmedCopyWithImpl;
@useResult
$Res call({
 String id
});




}
/// @nodoc
class _$AddressDeleteConfirmedCopyWithImpl<$Res>
    implements $AddressDeleteConfirmedCopyWith<$Res> {
  _$AddressDeleteConfirmedCopyWithImpl(this._self, this._then);

  final AddressDeleteConfirmed _self;
  final $Res Function(AddressDeleteConfirmed) _then;

/// Create a copy of AddressesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(AddressDeleteConfirmed(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$AddressesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressesState()';
}


}

/// @nodoc
class $AddressesStateCopyWith<$Res>  {
$AddressesStateCopyWith(AddressesState _, $Res Function(AddressesState) __);
}


/// Adds pattern-matching-related methods to [AddressesState].
extension AddressesStatePatterns on AddressesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AddressesInitial value)?  initial,TResult Function( AddressesLoading value)?  loading,TResult Function( AddressesReady value)?  ready,TResult Function( AddressesSaving value)?  saving,TResult Function( AddressesDeleting value)?  deleting,TResult Function( AddressesSuccess value)?  success,TResult Function( AddressesLoadFailure value)?  loadFailure,TResult Function( AddressesFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AddressesInitial() when initial != null:
return initial(_that);case AddressesLoading() when loading != null:
return loading(_that);case AddressesReady() when ready != null:
return ready(_that);case AddressesSaving() when saving != null:
return saving(_that);case AddressesDeleting() when deleting != null:
return deleting(_that);case AddressesSuccess() when success != null:
return success(_that);case AddressesLoadFailure() when loadFailure != null:
return loadFailure(_that);case AddressesFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AddressesInitial value)  initial,required TResult Function( AddressesLoading value)  loading,required TResult Function( AddressesReady value)  ready,required TResult Function( AddressesSaving value)  saving,required TResult Function( AddressesDeleting value)  deleting,required TResult Function( AddressesSuccess value)  success,required TResult Function( AddressesLoadFailure value)  loadFailure,required TResult Function( AddressesFailure value)  failure,}){
final _that = this;
switch (_that) {
case AddressesInitial():
return initial(_that);case AddressesLoading():
return loading(_that);case AddressesReady():
return ready(_that);case AddressesSaving():
return saving(_that);case AddressesDeleting():
return deleting(_that);case AddressesSuccess():
return success(_that);case AddressesLoadFailure():
return loadFailure(_that);case AddressesFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AddressesInitial value)?  initial,TResult? Function( AddressesLoading value)?  loading,TResult? Function( AddressesReady value)?  ready,TResult? Function( AddressesSaving value)?  saving,TResult? Function( AddressesDeleting value)?  deleting,TResult? Function( AddressesSuccess value)?  success,TResult? Function( AddressesLoadFailure value)?  loadFailure,TResult? Function( AddressesFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AddressesInitial() when initial != null:
return initial(_that);case AddressesLoading() when loading != null:
return loading(_that);case AddressesReady() when ready != null:
return ready(_that);case AddressesSaving() when saving != null:
return saving(_that);case AddressesDeleting() when deleting != null:
return deleting(_that);case AddressesSuccess() when success != null:
return success(_that);case AddressesLoadFailure() when loadFailure != null:
return loadFailure(_that);case AddressesFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Address> addresses)?  ready,TResult Function( List<Address> addresses)?  saving,TResult Function( List<Address> addresses,  String addressId)?  deleting,TResult Function( List<Address> addresses,  AddressMutation mutation)?  success,TResult Function( Failure failure)?  loadFailure,TResult Function( List<Address> addresses,  Failure failure,  AddressMutation mutation)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AddressesInitial() when initial != null:
return initial();case AddressesLoading() when loading != null:
return loading();case AddressesReady() when ready != null:
return ready(_that.addresses);case AddressesSaving() when saving != null:
return saving(_that.addresses);case AddressesDeleting() when deleting != null:
return deleting(_that.addresses,_that.addressId);case AddressesSuccess() when success != null:
return success(_that.addresses,_that.mutation);case AddressesLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case AddressesFailure() when failure != null:
return failure(_that.addresses,_that.failure,_that.mutation);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Address> addresses)  ready,required TResult Function( List<Address> addresses)  saving,required TResult Function( List<Address> addresses,  String addressId)  deleting,required TResult Function( List<Address> addresses,  AddressMutation mutation)  success,required TResult Function( Failure failure)  loadFailure,required TResult Function( List<Address> addresses,  Failure failure,  AddressMutation mutation)  failure,}) {final _that = this;
switch (_that) {
case AddressesInitial():
return initial();case AddressesLoading():
return loading();case AddressesReady():
return ready(_that.addresses);case AddressesSaving():
return saving(_that.addresses);case AddressesDeleting():
return deleting(_that.addresses,_that.addressId);case AddressesSuccess():
return success(_that.addresses,_that.mutation);case AddressesLoadFailure():
return loadFailure(_that.failure);case AddressesFailure():
return failure(_that.addresses,_that.failure,_that.mutation);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Address> addresses)?  ready,TResult? Function( List<Address> addresses)?  saving,TResult? Function( List<Address> addresses,  String addressId)?  deleting,TResult? Function( List<Address> addresses,  AddressMutation mutation)?  success,TResult? Function( Failure failure)?  loadFailure,TResult? Function( List<Address> addresses,  Failure failure,  AddressMutation mutation)?  failure,}) {final _that = this;
switch (_that) {
case AddressesInitial() when initial != null:
return initial();case AddressesLoading() when loading != null:
return loading();case AddressesReady() when ready != null:
return ready(_that.addresses);case AddressesSaving() when saving != null:
return saving(_that.addresses);case AddressesDeleting() when deleting != null:
return deleting(_that.addresses,_that.addressId);case AddressesSuccess() when success != null:
return success(_that.addresses,_that.mutation);case AddressesLoadFailure() when loadFailure != null:
return loadFailure(_that.failure);case AddressesFailure() when failure != null:
return failure(_that.addresses,_that.failure,_that.mutation);case _:
  return null;

}
}

}

/// @nodoc


class AddressesInitial implements AddressesState {
  const AddressesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressesState.initial()';
}


}




/// @nodoc


class AddressesLoading implements AddressesState {
  const AddressesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AddressesState.loading()';
}


}




/// @nodoc


class AddressesReady implements AddressesState {
  const AddressesReady(final  List<Address> addresses): _addresses = addresses;
  

 final  List<Address> _addresses;
 List<Address> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}


/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesReadyCopyWith<AddressesReady> get copyWith => _$AddressesReadyCopyWithImpl<AddressesReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesReady&&const DeepCollectionEquality().equals(other._addresses, _addresses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses));

@override
String toString() {
  return 'AddressesState.ready(addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class $AddressesReadyCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesReadyCopyWith(AddressesReady value, $Res Function(AddressesReady) _then) = _$AddressesReadyCopyWithImpl;
@useResult
$Res call({
 List<Address> addresses
});




}
/// @nodoc
class _$AddressesReadyCopyWithImpl<$Res>
    implements $AddressesReadyCopyWith<$Res> {
  _$AddressesReadyCopyWithImpl(this._self, this._then);

  final AddressesReady _self;
  final $Res Function(AddressesReady) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,}) {
  return _then(AddressesReady(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Address>,
  ));
}


}

/// @nodoc


class AddressesSaving implements AddressesState {
  const AddressesSaving(final  List<Address> addresses): _addresses = addresses;
  

 final  List<Address> _addresses;
 List<Address> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}


/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesSavingCopyWith<AddressesSaving> get copyWith => _$AddressesSavingCopyWithImpl<AddressesSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesSaving&&const DeepCollectionEquality().equals(other._addresses, _addresses));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses));

@override
String toString() {
  return 'AddressesState.saving(addresses: $addresses)';
}


}

/// @nodoc
abstract mixin class $AddressesSavingCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesSavingCopyWith(AddressesSaving value, $Res Function(AddressesSaving) _then) = _$AddressesSavingCopyWithImpl;
@useResult
$Res call({
 List<Address> addresses
});




}
/// @nodoc
class _$AddressesSavingCopyWithImpl<$Res>
    implements $AddressesSavingCopyWith<$Res> {
  _$AddressesSavingCopyWithImpl(this._self, this._then);

  final AddressesSaving _self;
  final $Res Function(AddressesSaving) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,}) {
  return _then(AddressesSaving(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Address>,
  ));
}


}

/// @nodoc


class AddressesDeleting implements AddressesState {
  const AddressesDeleting(final  List<Address> addresses, this.addressId): _addresses = addresses;
  

 final  List<Address> _addresses;
 List<Address> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

 final  String addressId;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesDeletingCopyWith<AddressesDeleting> get copyWith => _$AddressesDeletingCopyWithImpl<AddressesDeleting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesDeleting&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&(identical(other.addressId, addressId) || other.addressId == addressId));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses),addressId);

@override
String toString() {
  return 'AddressesState.deleting(addresses: $addresses, addressId: $addressId)';
}


}

/// @nodoc
abstract mixin class $AddressesDeletingCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesDeletingCopyWith(AddressesDeleting value, $Res Function(AddressesDeleting) _then) = _$AddressesDeletingCopyWithImpl;
@useResult
$Res call({
 List<Address> addresses, String addressId
});




}
/// @nodoc
class _$AddressesDeletingCopyWithImpl<$Res>
    implements $AddressesDeletingCopyWith<$Res> {
  _$AddressesDeletingCopyWithImpl(this._self, this._then);

  final AddressesDeleting _self;
  final $Res Function(AddressesDeleting) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,Object? addressId = null,}) {
  return _then(AddressesDeleting(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Address>,null == addressId ? _self.addressId : addressId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AddressesSuccess implements AddressesState {
  const AddressesSuccess(final  List<Address> addresses, this.mutation): _addresses = addresses;
  

 final  List<Address> _addresses;
 List<Address> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

 final  AddressMutation mutation;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesSuccessCopyWith<AddressesSuccess> get copyWith => _$AddressesSuccessCopyWithImpl<AddressesSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesSuccess&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&(identical(other.mutation, mutation) || other.mutation == mutation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses),mutation);

@override
String toString() {
  return 'AddressesState.success(addresses: $addresses, mutation: $mutation)';
}


}

/// @nodoc
abstract mixin class $AddressesSuccessCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesSuccessCopyWith(AddressesSuccess value, $Res Function(AddressesSuccess) _then) = _$AddressesSuccessCopyWithImpl;
@useResult
$Res call({
 List<Address> addresses, AddressMutation mutation
});




}
/// @nodoc
class _$AddressesSuccessCopyWithImpl<$Res>
    implements $AddressesSuccessCopyWith<$Res> {
  _$AddressesSuccessCopyWithImpl(this._self, this._then);

  final AddressesSuccess _self;
  final $Res Function(AddressesSuccess) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,Object? mutation = null,}) {
  return _then(AddressesSuccess(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Address>,null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as AddressMutation,
  ));
}


}

/// @nodoc


class AddressesLoadFailure implements AddressesState {
  const AddressesLoadFailure(this.failure);
  

 final  Failure failure;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesLoadFailureCopyWith<AddressesLoadFailure> get copyWith => _$AddressesLoadFailureCopyWithImpl<AddressesLoadFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesLoadFailure&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,failure);

@override
String toString() {
  return 'AddressesState.loadFailure(failure: $failure)';
}


}

/// @nodoc
abstract mixin class $AddressesLoadFailureCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesLoadFailureCopyWith(AddressesLoadFailure value, $Res Function(AddressesLoadFailure) _then) = _$AddressesLoadFailureCopyWithImpl;
@useResult
$Res call({
 Failure failure
});




}
/// @nodoc
class _$AddressesLoadFailureCopyWithImpl<$Res>
    implements $AddressesLoadFailureCopyWith<$Res> {
  _$AddressesLoadFailureCopyWithImpl(this._self, this._then);

  final AddressesLoadFailure _self;
  final $Res Function(AddressesLoadFailure) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? failure = null,}) {
  return _then(AddressesLoadFailure(
null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

/// @nodoc


class AddressesFailure implements AddressesState {
  const AddressesFailure(final  List<Address> addresses, this.failure, this.mutation): _addresses = addresses;
  

 final  List<Address> _addresses;
 List<Address> get addresses {
  if (_addresses is EqualUnmodifiableListView) return _addresses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addresses);
}

 final  Failure failure;
 final  AddressMutation mutation;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddressesFailureCopyWith<AddressesFailure> get copyWith => _$AddressesFailureCopyWithImpl<AddressesFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddressesFailure&&const DeepCollectionEquality().equals(other._addresses, _addresses)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.mutation, mutation) || other.mutation == mutation));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_addresses),failure,mutation);

@override
String toString() {
  return 'AddressesState.failure(addresses: $addresses, failure: $failure, mutation: $mutation)';
}


}

/// @nodoc
abstract mixin class $AddressesFailureCopyWith<$Res> implements $AddressesStateCopyWith<$Res> {
  factory $AddressesFailureCopyWith(AddressesFailure value, $Res Function(AddressesFailure) _then) = _$AddressesFailureCopyWithImpl;
@useResult
$Res call({
 List<Address> addresses, Failure failure, AddressMutation mutation
});




}
/// @nodoc
class _$AddressesFailureCopyWithImpl<$Res>
    implements $AddressesFailureCopyWith<$Res> {
  _$AddressesFailureCopyWithImpl(this._self, this._then);

  final AddressesFailure _self;
  final $Res Function(AddressesFailure) _then;

/// Create a copy of AddressesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? addresses = null,Object? failure = null,Object? mutation = null,}) {
  return _then(AddressesFailure(
null == addresses ? _self._addresses : addresses // ignore: cast_nullable_to_non_nullable
as List<Address>,null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,null == mutation ? _self.mutation : mutation // ignore: cast_nullable_to_non_nullable
as AddressMutation,
  ));
}


}

// dart format on
