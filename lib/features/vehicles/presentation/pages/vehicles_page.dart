import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/utils/vehicle_form_navigation.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicles_state_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesPage extends StatelessWidget {
  const VehiclesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehiclesBloc, VehiclesState>(
      listenWhen: (_, current) => current.maybeWhen(
        success: (_, mutation) => mutation == VehicleMutation.delete,
        failure: (_, _, mutation) => mutation == VehicleMutation.delete,
        orElse: () => false,
      ),
      listener: _showMutationFeedback,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.vehiclesTitle)),
          body: SafeArea(child: VehiclesStateBody(state)),
          floatingActionButton: _canMutate(state)
              ? FloatingActionButton.extended(
                  onPressed: () => openVehicleForm(context),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text(AppStrings.addVehicle),
                )
              : null,
        );
      },
    );
  }

  void _showMutationFeedback(BuildContext context, VehiclesState state) {
    state.whenOrNull(
      success: (_, mutation) {
        if (mutation == VehicleMutation.delete) {
          _showMessage(context, AppStrings.vehicleDeleted);
        }
      },
      failure: (_, failure, mutation) {
        if (mutation == VehicleMutation.delete) {
          _showMessage(context, failure.message);
        }
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  bool _canMutate(VehiclesState state) => state.maybeWhen(
    ready: (_) => true,
    success: (_, _) => true,
    failure: (_, _, _) => true,
    orElse: () => false,
  );
}
