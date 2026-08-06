import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/pages/vehicle_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Opens the vehicle form while preserving the list BLoC instance.
void openVehicleForm(BuildContext context, [Vehicle? vehicle]) {
  final bloc = context.read<VehiclesBloc>();
  Navigator.of(context).push(
    MaterialPageRoute<void>(
      builder: (_) => BlocProvider.value(
        value: bloc,
        child: VehicleFormPage(vehicle: vehicle),
      ),
    ),
  );
}
