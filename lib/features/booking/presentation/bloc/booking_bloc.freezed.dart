// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'booking_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BookingEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingEvent()';
}


}

/// @nodoc
class $BookingEventCopyWith<$Res>  {
$BookingEventCopyWith(BookingEvent _, $Res Function(BookingEvent) __);
}


/// Adds pattern-matching-related methods to [BookingEvent].
extension BookingEventPatterns on BookingEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BookingStarted value)?  started,TResult Function( BookingVehicleSelected value)?  vehicleSelected,TResult Function( BookingServiceSelected value)?  serviceSelected,TResult Function( BookingAddressSelected value)?  addressSelected,TResult Function( BookingSlotsRequested value)?  slotsRequested,TResult Function( BookingSlotSelected value)?  slotSelected,TResult Function( BookingPaymentSelected value)?  paymentSelected,TResult Function( BookingStepChanged value)?  stepChanged,TResult Function( BookingSubmitted value)?  submitted,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BookingStarted() when started != null:
return started(_that);case BookingVehicleSelected() when vehicleSelected != null:
return vehicleSelected(_that);case BookingServiceSelected() when serviceSelected != null:
return serviceSelected(_that);case BookingAddressSelected() when addressSelected != null:
return addressSelected(_that);case BookingSlotsRequested() when slotsRequested != null:
return slotsRequested(_that);case BookingSlotSelected() when slotSelected != null:
return slotSelected(_that);case BookingPaymentSelected() when paymentSelected != null:
return paymentSelected(_that);case BookingStepChanged() when stepChanged != null:
return stepChanged(_that);case BookingSubmitted() when submitted != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BookingStarted value)  started,required TResult Function( BookingVehicleSelected value)  vehicleSelected,required TResult Function( BookingServiceSelected value)  serviceSelected,required TResult Function( BookingAddressSelected value)  addressSelected,required TResult Function( BookingSlotsRequested value)  slotsRequested,required TResult Function( BookingSlotSelected value)  slotSelected,required TResult Function( BookingPaymentSelected value)  paymentSelected,required TResult Function( BookingStepChanged value)  stepChanged,required TResult Function( BookingSubmitted value)  submitted,}){
final _that = this;
switch (_that) {
case BookingStarted():
return started(_that);case BookingVehicleSelected():
return vehicleSelected(_that);case BookingServiceSelected():
return serviceSelected(_that);case BookingAddressSelected():
return addressSelected(_that);case BookingSlotsRequested():
return slotsRequested(_that);case BookingSlotSelected():
return slotSelected(_that);case BookingPaymentSelected():
return paymentSelected(_that);case BookingStepChanged():
return stepChanged(_that);case BookingSubmitted():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BookingStarted value)?  started,TResult? Function( BookingVehicleSelected value)?  vehicleSelected,TResult? Function( BookingServiceSelected value)?  serviceSelected,TResult? Function( BookingAddressSelected value)?  addressSelected,TResult? Function( BookingSlotsRequested value)?  slotsRequested,TResult? Function( BookingSlotSelected value)?  slotSelected,TResult? Function( BookingPaymentSelected value)?  paymentSelected,TResult? Function( BookingStepChanged value)?  stepChanged,TResult? Function( BookingSubmitted value)?  submitted,}){
final _that = this;
switch (_that) {
case BookingStarted() when started != null:
return started(_that);case BookingVehicleSelected() when vehicleSelected != null:
return vehicleSelected(_that);case BookingServiceSelected() when serviceSelected != null:
return serviceSelected(_that);case BookingAddressSelected() when addressSelected != null:
return addressSelected(_that);case BookingSlotsRequested() when slotsRequested != null:
return slotsRequested(_that);case BookingSlotSelected() when slotSelected != null:
return slotSelected(_that);case BookingPaymentSelected() when paymentSelected != null:
return paymentSelected(_that);case BookingStepChanged() when stepChanged != null:
return stepChanged(_that);case BookingSubmitted() when submitted != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( Vehicle vehicle)?  vehicleSelected,TResult Function( Service service,  List<ServiceAddon> addons,  ServicePricing pricing)?  serviceSelected,TResult Function( Address address)?  addressSelected,TResult Function( DateTime date)?  slotsRequested,TResult Function( TimeSlot slot)?  slotSelected,TResult Function( PaymentMethod method)?  paymentSelected,TResult Function( int step)?  stepChanged,TResult Function()?  submitted,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BookingStarted() when started != null:
return started();case BookingVehicleSelected() when vehicleSelected != null:
return vehicleSelected(_that.vehicle);case BookingServiceSelected() when serviceSelected != null:
return serviceSelected(_that.service,_that.addons,_that.pricing);case BookingAddressSelected() when addressSelected != null:
return addressSelected(_that.address);case BookingSlotsRequested() when slotsRequested != null:
return slotsRequested(_that.date);case BookingSlotSelected() when slotSelected != null:
return slotSelected(_that.slot);case BookingPaymentSelected() when paymentSelected != null:
return paymentSelected(_that.method);case BookingStepChanged() when stepChanged != null:
return stepChanged(_that.step);case BookingSubmitted() when submitted != null:
return submitted();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( Vehicle vehicle)  vehicleSelected,required TResult Function( Service service,  List<ServiceAddon> addons,  ServicePricing pricing)  serviceSelected,required TResult Function( Address address)  addressSelected,required TResult Function( DateTime date)  slotsRequested,required TResult Function( TimeSlot slot)  slotSelected,required TResult Function( PaymentMethod method)  paymentSelected,required TResult Function( int step)  stepChanged,required TResult Function()  submitted,}) {final _that = this;
switch (_that) {
case BookingStarted():
return started();case BookingVehicleSelected():
return vehicleSelected(_that.vehicle);case BookingServiceSelected():
return serviceSelected(_that.service,_that.addons,_that.pricing);case BookingAddressSelected():
return addressSelected(_that.address);case BookingSlotsRequested():
return slotsRequested(_that.date);case BookingSlotSelected():
return slotSelected(_that.slot);case BookingPaymentSelected():
return paymentSelected(_that.method);case BookingStepChanged():
return stepChanged(_that.step);case BookingSubmitted():
return submitted();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( Vehicle vehicle)?  vehicleSelected,TResult? Function( Service service,  List<ServiceAddon> addons,  ServicePricing pricing)?  serviceSelected,TResult? Function( Address address)?  addressSelected,TResult? Function( DateTime date)?  slotsRequested,TResult? Function( TimeSlot slot)?  slotSelected,TResult? Function( PaymentMethod method)?  paymentSelected,TResult? Function( int step)?  stepChanged,TResult? Function()?  submitted,}) {final _that = this;
switch (_that) {
case BookingStarted() when started != null:
return started();case BookingVehicleSelected() when vehicleSelected != null:
return vehicleSelected(_that.vehicle);case BookingServiceSelected() when serviceSelected != null:
return serviceSelected(_that.service,_that.addons,_that.pricing);case BookingAddressSelected() when addressSelected != null:
return addressSelected(_that.address);case BookingSlotsRequested() when slotsRequested != null:
return slotsRequested(_that.date);case BookingSlotSelected() when slotSelected != null:
return slotSelected(_that.slot);case BookingPaymentSelected() when paymentSelected != null:
return paymentSelected(_that.method);case BookingStepChanged() when stepChanged != null:
return stepChanged(_that.step);case BookingSubmitted() when submitted != null:
return submitted();case _:
  return null;

}
}

}

/// @nodoc


class BookingStarted implements BookingEvent {
  const BookingStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingEvent.started()';
}


}




/// @nodoc


class BookingVehicleSelected implements BookingEvent {
  const BookingVehicleSelected(this.vehicle);
  

 final  Vehicle vehicle;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingVehicleSelectedCopyWith<BookingVehicleSelected> get copyWith => _$BookingVehicleSelectedCopyWithImpl<BookingVehicleSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingVehicleSelected&&(identical(other.vehicle, vehicle) || other.vehicle == vehicle));
}


@override
int get hashCode => Object.hash(runtimeType,vehicle);

@override
String toString() {
  return 'BookingEvent.vehicleSelected(vehicle: $vehicle)';
}


}

/// @nodoc
abstract mixin class $BookingVehicleSelectedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingVehicleSelectedCopyWith(BookingVehicleSelected value, $Res Function(BookingVehicleSelected) _then) = _$BookingVehicleSelectedCopyWithImpl;
@useResult
$Res call({
 Vehicle vehicle
});




}
/// @nodoc
class _$BookingVehicleSelectedCopyWithImpl<$Res>
    implements $BookingVehicleSelectedCopyWith<$Res> {
  _$BookingVehicleSelectedCopyWithImpl(this._self, this._then);

  final BookingVehicleSelected _self;
  final $Res Function(BookingVehicleSelected) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? vehicle = null,}) {
  return _then(BookingVehicleSelected(
null == vehicle ? _self.vehicle : vehicle // ignore: cast_nullable_to_non_nullable
as Vehicle,
  ));
}


}

/// @nodoc


class BookingServiceSelected implements BookingEvent {
  const BookingServiceSelected(this.service, final  List<ServiceAddon> addons, this.pricing): _addons = addons;
  

 final  Service service;
 final  List<ServiceAddon> _addons;
 List<ServiceAddon> get addons {
  if (_addons is EqualUnmodifiableListView) return _addons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addons);
}

 final  ServicePricing pricing;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingServiceSelectedCopyWith<BookingServiceSelected> get copyWith => _$BookingServiceSelectedCopyWithImpl<BookingServiceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingServiceSelected&&(identical(other.service, service) || other.service == service)&&const DeepCollectionEquality().equals(other._addons, _addons)&&(identical(other.pricing, pricing) || other.pricing == pricing));
}


@override
int get hashCode => Object.hash(runtimeType,service,const DeepCollectionEquality().hash(_addons),pricing);

@override
String toString() {
  return 'BookingEvent.serviceSelected(service: $service, addons: $addons, pricing: $pricing)';
}


}

/// @nodoc
abstract mixin class $BookingServiceSelectedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingServiceSelectedCopyWith(BookingServiceSelected value, $Res Function(BookingServiceSelected) _then) = _$BookingServiceSelectedCopyWithImpl;
@useResult
$Res call({
 Service service, List<ServiceAddon> addons, ServicePricing pricing
});




}
/// @nodoc
class _$BookingServiceSelectedCopyWithImpl<$Res>
    implements $BookingServiceSelectedCopyWith<$Res> {
  _$BookingServiceSelectedCopyWithImpl(this._self, this._then);

  final BookingServiceSelected _self;
  final $Res Function(BookingServiceSelected) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? service = null,Object? addons = null,Object? pricing = null,}) {
  return _then(BookingServiceSelected(
null == service ? _self.service : service // ignore: cast_nullable_to_non_nullable
as Service,null == addons ? _self._addons : addons // ignore: cast_nullable_to_non_nullable
as List<ServiceAddon>,null == pricing ? _self.pricing : pricing // ignore: cast_nullable_to_non_nullable
as ServicePricing,
  ));
}


}

/// @nodoc


class BookingAddressSelected implements BookingEvent {
  const BookingAddressSelected(this.address);
  

 final  Address address;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingAddressSelectedCopyWith<BookingAddressSelected> get copyWith => _$BookingAddressSelectedCopyWithImpl<BookingAddressSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingAddressSelected&&(identical(other.address, address) || other.address == address));
}


@override
int get hashCode => Object.hash(runtimeType,address);

@override
String toString() {
  return 'BookingEvent.addressSelected(address: $address)';
}


}

/// @nodoc
abstract mixin class $BookingAddressSelectedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingAddressSelectedCopyWith(BookingAddressSelected value, $Res Function(BookingAddressSelected) _then) = _$BookingAddressSelectedCopyWithImpl;
@useResult
$Res call({
 Address address
});




}
/// @nodoc
class _$BookingAddressSelectedCopyWithImpl<$Res>
    implements $BookingAddressSelectedCopyWith<$Res> {
  _$BookingAddressSelectedCopyWithImpl(this._self, this._then);

  final BookingAddressSelected _self;
  final $Res Function(BookingAddressSelected) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? address = null,}) {
  return _then(BookingAddressSelected(
null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as Address,
  ));
}


}

/// @nodoc


class BookingSlotsRequested implements BookingEvent {
  const BookingSlotsRequested(this.date);
  

 final  DateTime date;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSlotsRequestedCopyWith<BookingSlotsRequested> get copyWith => _$BookingSlotsRequestedCopyWithImpl<BookingSlotsRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSlotsRequested&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'BookingEvent.slotsRequested(date: $date)';
}


}

/// @nodoc
abstract mixin class $BookingSlotsRequestedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingSlotsRequestedCopyWith(BookingSlotsRequested value, $Res Function(BookingSlotsRequested) _then) = _$BookingSlotsRequestedCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$BookingSlotsRequestedCopyWithImpl<$Res>
    implements $BookingSlotsRequestedCopyWith<$Res> {
  _$BookingSlotsRequestedCopyWithImpl(this._self, this._then);

  final BookingSlotsRequested _self;
  final $Res Function(BookingSlotsRequested) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(BookingSlotsRequested(
null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class BookingSlotSelected implements BookingEvent {
  const BookingSlotSelected(this.slot);
  

 final  TimeSlot slot;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSlotSelectedCopyWith<BookingSlotSelected> get copyWith => _$BookingSlotSelectedCopyWithImpl<BookingSlotSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSlotSelected&&(identical(other.slot, slot) || other.slot == slot));
}


@override
int get hashCode => Object.hash(runtimeType,slot);

@override
String toString() {
  return 'BookingEvent.slotSelected(slot: $slot)';
}


}

/// @nodoc
abstract mixin class $BookingSlotSelectedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingSlotSelectedCopyWith(BookingSlotSelected value, $Res Function(BookingSlotSelected) _then) = _$BookingSlotSelectedCopyWithImpl;
@useResult
$Res call({
 TimeSlot slot
});




}
/// @nodoc
class _$BookingSlotSelectedCopyWithImpl<$Res>
    implements $BookingSlotSelectedCopyWith<$Res> {
  _$BookingSlotSelectedCopyWithImpl(this._self, this._then);

  final BookingSlotSelected _self;
  final $Res Function(BookingSlotSelected) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? slot = null,}) {
  return _then(BookingSlotSelected(
null == slot ? _self.slot : slot // ignore: cast_nullable_to_non_nullable
as TimeSlot,
  ));
}


}

/// @nodoc


class BookingPaymentSelected implements BookingEvent {
  const BookingPaymentSelected(this.method);
  

 final  PaymentMethod method;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingPaymentSelectedCopyWith<BookingPaymentSelected> get copyWith => _$BookingPaymentSelectedCopyWithImpl<BookingPaymentSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingPaymentSelected&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,method);

@override
String toString() {
  return 'BookingEvent.paymentSelected(method: $method)';
}


}

/// @nodoc
abstract mixin class $BookingPaymentSelectedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingPaymentSelectedCopyWith(BookingPaymentSelected value, $Res Function(BookingPaymentSelected) _then) = _$BookingPaymentSelectedCopyWithImpl;
@useResult
$Res call({
 PaymentMethod method
});




}
/// @nodoc
class _$BookingPaymentSelectedCopyWithImpl<$Res>
    implements $BookingPaymentSelectedCopyWith<$Res> {
  _$BookingPaymentSelectedCopyWithImpl(this._self, this._then);

  final BookingPaymentSelected _self;
  final $Res Function(BookingPaymentSelected) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? method = null,}) {
  return _then(BookingPaymentSelected(
null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as PaymentMethod,
  ));
}


}

/// @nodoc


class BookingStepChanged implements BookingEvent {
  const BookingStepChanged(this.step);
  

 final  int step;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingStepChangedCopyWith<BookingStepChanged> get copyWith => _$BookingStepChangedCopyWithImpl<BookingStepChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingStepChanged&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,step);

@override
String toString() {
  return 'BookingEvent.stepChanged(step: $step)';
}


}

/// @nodoc
abstract mixin class $BookingStepChangedCopyWith<$Res> implements $BookingEventCopyWith<$Res> {
  factory $BookingStepChangedCopyWith(BookingStepChanged value, $Res Function(BookingStepChanged) _then) = _$BookingStepChangedCopyWithImpl;
@useResult
$Res call({
 int step
});




}
/// @nodoc
class _$BookingStepChangedCopyWithImpl<$Res>
    implements $BookingStepChangedCopyWith<$Res> {
  _$BookingStepChangedCopyWithImpl(this._self, this._then);

  final BookingStepChanged _self;
  final $Res Function(BookingStepChanged) _then;

/// Create a copy of BookingEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? step = null,}) {
  return _then(BookingStepChanged(
null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class BookingSubmitted implements BookingEvent {
  const BookingSubmitted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSubmitted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingEvent.submitted()';
}


}




/// @nodoc
mixin _$BookingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState()';
}


}

/// @nodoc
class $BookingStateCopyWith<$Res>  {
$BookingStateCopyWith(BookingState _, $Res Function(BookingState) __);
}


/// Adds pattern-matching-related methods to [BookingState].
extension BookingStatePatterns on BookingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( BookingInitial value)?  initial,TResult Function( BookingDrafting value)?  drafting,TResult Function( BookingLoadingSlots value)?  loadingSlots,TResult Function( BookingSlotsReady value)?  slotsReady,TResult Function( BookingSubmitting value)?  submitting,TResult Function( BookingSuccess value)?  success,TResult Function( BookingFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case BookingInitial() when initial != null:
return initial(_that);case BookingDrafting() when drafting != null:
return drafting(_that);case BookingLoadingSlots() when loadingSlots != null:
return loadingSlots(_that);case BookingSlotsReady() when slotsReady != null:
return slotsReady(_that);case BookingSubmitting() when submitting != null:
return submitting(_that);case BookingSuccess() when success != null:
return success(_that);case BookingFailure() when failure != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( BookingInitial value)  initial,required TResult Function( BookingDrafting value)  drafting,required TResult Function( BookingLoadingSlots value)  loadingSlots,required TResult Function( BookingSlotsReady value)  slotsReady,required TResult Function( BookingSubmitting value)  submitting,required TResult Function( BookingSuccess value)  success,required TResult Function( BookingFailure value)  failure,}){
final _that = this;
switch (_that) {
case BookingInitial():
return initial(_that);case BookingDrafting():
return drafting(_that);case BookingLoadingSlots():
return loadingSlots(_that);case BookingSlotsReady():
return slotsReady(_that);case BookingSubmitting():
return submitting(_that);case BookingSuccess():
return success(_that);case BookingFailure():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( BookingInitial value)?  initial,TResult? Function( BookingDrafting value)?  drafting,TResult? Function( BookingLoadingSlots value)?  loadingSlots,TResult? Function( BookingSlotsReady value)?  slotsReady,TResult? Function( BookingSubmitting value)?  submitting,TResult? Function( BookingSuccess value)?  success,TResult? Function( BookingFailure value)?  failure,}){
final _that = this;
switch (_that) {
case BookingInitial() when initial != null:
return initial(_that);case BookingDrafting() when drafting != null:
return drafting(_that);case BookingLoadingSlots() when loadingSlots != null:
return loadingSlots(_that);case BookingSlotsReady() when slotsReady != null:
return slotsReady(_that);case BookingSubmitting() when submitting != null:
return submitting(_that);case BookingSuccess() when success != null:
return success(_that);case BookingFailure() when failure != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( BookingDraft draft,  int step)?  drafting,TResult Function( BookingDraft draft)?  loadingSlots,TResult Function( BookingDraft draft,  List<TimeSlot> slots)?  slotsReady,TResult Function( BookingDraft draft)?  submitting,TResult Function( Booking booking)?  success,TResult Function( BookingDraft draft,  Failure failure)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case BookingInitial() when initial != null:
return initial();case BookingDrafting() when drafting != null:
return drafting(_that.draft,_that.step);case BookingLoadingSlots() when loadingSlots != null:
return loadingSlots(_that.draft);case BookingSlotsReady() when slotsReady != null:
return slotsReady(_that.draft,_that.slots);case BookingSubmitting() when submitting != null:
return submitting(_that.draft);case BookingSuccess() when success != null:
return success(_that.booking);case BookingFailure() when failure != null:
return failure(_that.draft,_that.failure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( BookingDraft draft,  int step)  drafting,required TResult Function( BookingDraft draft)  loadingSlots,required TResult Function( BookingDraft draft,  List<TimeSlot> slots)  slotsReady,required TResult Function( BookingDraft draft)  submitting,required TResult Function( Booking booking)  success,required TResult Function( BookingDraft draft,  Failure failure)  failure,}) {final _that = this;
switch (_that) {
case BookingInitial():
return initial();case BookingDrafting():
return drafting(_that.draft,_that.step);case BookingLoadingSlots():
return loadingSlots(_that.draft);case BookingSlotsReady():
return slotsReady(_that.draft,_that.slots);case BookingSubmitting():
return submitting(_that.draft);case BookingSuccess():
return success(_that.booking);case BookingFailure():
return failure(_that.draft,_that.failure);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( BookingDraft draft,  int step)?  drafting,TResult? Function( BookingDraft draft)?  loadingSlots,TResult? Function( BookingDraft draft,  List<TimeSlot> slots)?  slotsReady,TResult? Function( BookingDraft draft)?  submitting,TResult? Function( Booking booking)?  success,TResult? Function( BookingDraft draft,  Failure failure)?  failure,}) {final _that = this;
switch (_that) {
case BookingInitial() when initial != null:
return initial();case BookingDrafting() when drafting != null:
return drafting(_that.draft,_that.step);case BookingLoadingSlots() when loadingSlots != null:
return loadingSlots(_that.draft);case BookingSlotsReady() when slotsReady != null:
return slotsReady(_that.draft,_that.slots);case BookingSubmitting() when submitting != null:
return submitting(_that.draft);case BookingSuccess() when success != null:
return success(_that.booking);case BookingFailure() when failure != null:
return failure(_that.draft,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class BookingInitial implements BookingState {
  const BookingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'BookingState.initial()';
}


}




/// @nodoc


class BookingDrafting implements BookingState {
  const BookingDrafting(this.draft, this.step);
  

 final  BookingDraft draft;
 final  int step;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingDraftingCopyWith<BookingDrafting> get copyWith => _$BookingDraftingCopyWithImpl<BookingDrafting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingDrafting&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.step, step) || other.step == step));
}


@override
int get hashCode => Object.hash(runtimeType,draft,step);

@override
String toString() {
  return 'BookingState.drafting(draft: $draft, step: $step)';
}


}

/// @nodoc
abstract mixin class $BookingDraftingCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingDraftingCopyWith(BookingDrafting value, $Res Function(BookingDrafting) _then) = _$BookingDraftingCopyWithImpl;
@useResult
$Res call({
 BookingDraft draft, int step
});




}
/// @nodoc
class _$BookingDraftingCopyWithImpl<$Res>
    implements $BookingDraftingCopyWith<$Res> {
  _$BookingDraftingCopyWithImpl(this._self, this._then);

  final BookingDrafting _self;
  final $Res Function(BookingDrafting) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? step = null,}) {
  return _then(BookingDrafting(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BookingDraft,null == step ? _self.step : step // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class BookingLoadingSlots implements BookingState {
  const BookingLoadingSlots(this.draft);
  

 final  BookingDraft draft;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingLoadingSlotsCopyWith<BookingLoadingSlots> get copyWith => _$BookingLoadingSlotsCopyWithImpl<BookingLoadingSlots>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingLoadingSlots&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,draft);

@override
String toString() {
  return 'BookingState.loadingSlots(draft: $draft)';
}


}

/// @nodoc
abstract mixin class $BookingLoadingSlotsCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingLoadingSlotsCopyWith(BookingLoadingSlots value, $Res Function(BookingLoadingSlots) _then) = _$BookingLoadingSlotsCopyWithImpl;
@useResult
$Res call({
 BookingDraft draft
});




}
/// @nodoc
class _$BookingLoadingSlotsCopyWithImpl<$Res>
    implements $BookingLoadingSlotsCopyWith<$Res> {
  _$BookingLoadingSlotsCopyWithImpl(this._self, this._then);

  final BookingLoadingSlots _self;
  final $Res Function(BookingLoadingSlots) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(BookingLoadingSlots(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BookingDraft,
  ));
}


}

/// @nodoc


class BookingSlotsReady implements BookingState {
  const BookingSlotsReady(this.draft, final  List<TimeSlot> slots): _slots = slots;
  

 final  BookingDraft draft;
 final  List<TimeSlot> _slots;
 List<TimeSlot> get slots {
  if (_slots is EqualUnmodifiableListView) return _slots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_slots);
}


/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSlotsReadyCopyWith<BookingSlotsReady> get copyWith => _$BookingSlotsReadyCopyWithImpl<BookingSlotsReady>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSlotsReady&&(identical(other.draft, draft) || other.draft == draft)&&const DeepCollectionEquality().equals(other._slots, _slots));
}


@override
int get hashCode => Object.hash(runtimeType,draft,const DeepCollectionEquality().hash(_slots));

@override
String toString() {
  return 'BookingState.slotsReady(draft: $draft, slots: $slots)';
}


}

/// @nodoc
abstract mixin class $BookingSlotsReadyCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingSlotsReadyCopyWith(BookingSlotsReady value, $Res Function(BookingSlotsReady) _then) = _$BookingSlotsReadyCopyWithImpl;
@useResult
$Res call({
 BookingDraft draft, List<TimeSlot> slots
});




}
/// @nodoc
class _$BookingSlotsReadyCopyWithImpl<$Res>
    implements $BookingSlotsReadyCopyWith<$Res> {
  _$BookingSlotsReadyCopyWithImpl(this._self, this._then);

  final BookingSlotsReady _self;
  final $Res Function(BookingSlotsReady) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? slots = null,}) {
  return _then(BookingSlotsReady(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BookingDraft,null == slots ? _self._slots : slots // ignore: cast_nullable_to_non_nullable
as List<TimeSlot>,
  ));
}


}

/// @nodoc


class BookingSubmitting implements BookingState {
  const BookingSubmitting(this.draft);
  

 final  BookingDraft draft;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSubmittingCopyWith<BookingSubmitting> get copyWith => _$BookingSubmittingCopyWithImpl<BookingSubmitting>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSubmitting&&(identical(other.draft, draft) || other.draft == draft));
}


@override
int get hashCode => Object.hash(runtimeType,draft);

@override
String toString() {
  return 'BookingState.submitting(draft: $draft)';
}


}

/// @nodoc
abstract mixin class $BookingSubmittingCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingSubmittingCopyWith(BookingSubmitting value, $Res Function(BookingSubmitting) _then) = _$BookingSubmittingCopyWithImpl;
@useResult
$Res call({
 BookingDraft draft
});




}
/// @nodoc
class _$BookingSubmittingCopyWithImpl<$Res>
    implements $BookingSubmittingCopyWith<$Res> {
  _$BookingSubmittingCopyWithImpl(this._self, this._then);

  final BookingSubmitting _self;
  final $Res Function(BookingSubmitting) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,}) {
  return _then(BookingSubmitting(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BookingDraft,
  ));
}


}

/// @nodoc


class BookingSuccess implements BookingState {
  const BookingSuccess(this.booking);
  

 final  Booking booking;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingSuccessCopyWith<BookingSuccess> get copyWith => _$BookingSuccessCopyWithImpl<BookingSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingSuccess&&(identical(other.booking, booking) || other.booking == booking));
}


@override
int get hashCode => Object.hash(runtimeType,booking);

@override
String toString() {
  return 'BookingState.success(booking: $booking)';
}


}

/// @nodoc
abstract mixin class $BookingSuccessCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingSuccessCopyWith(BookingSuccess value, $Res Function(BookingSuccess) _then) = _$BookingSuccessCopyWithImpl;
@useResult
$Res call({
 Booking booking
});




}
/// @nodoc
class _$BookingSuccessCopyWithImpl<$Res>
    implements $BookingSuccessCopyWith<$Res> {
  _$BookingSuccessCopyWithImpl(this._self, this._then);

  final BookingSuccess _self;
  final $Res Function(BookingSuccess) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? booking = null,}) {
  return _then(BookingSuccess(
null == booking ? _self.booking : booking // ignore: cast_nullable_to_non_nullable
as Booking,
  ));
}


}

/// @nodoc


class BookingFailure implements BookingState {
  const BookingFailure(this.draft, this.failure);
  

 final  BookingDraft draft;
 final  Failure failure;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BookingFailureCopyWith<BookingFailure> get copyWith => _$BookingFailureCopyWithImpl<BookingFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BookingFailure&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,draft,failure);

@override
String toString() {
  return 'BookingState.failure(draft: $draft, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $BookingFailureCopyWith<$Res> implements $BookingStateCopyWith<$Res> {
  factory $BookingFailureCopyWith(BookingFailure value, $Res Function(BookingFailure) _then) = _$BookingFailureCopyWithImpl;
@useResult
$Res call({
 BookingDraft draft, Failure failure
});




}
/// @nodoc
class _$BookingFailureCopyWithImpl<$Res>
    implements $BookingFailureCopyWith<$Res> {
  _$BookingFailureCopyWithImpl(this._self, this._then);

  final BookingFailure _self;
  final $Res Function(BookingFailure) _then;

/// Create a copy of BookingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? draft = null,Object? failure = null,}) {
  return _then(BookingFailure(
null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as BookingDraft,null == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as Failure,
  ));
}


}

// dart format on
