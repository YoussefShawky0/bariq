import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:flutter/material.dart';

Future<bool> confirmVehicleDeletion(
  BuildContext context,
  Vehicle vehicle,
) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: const Text(AppStrings.deleteVehicleTitle),
      content: Text(AppStrings.deleteVehicleBody(vehicle.displayName)),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text(AppStrings.cancel),
        ),
        FilledButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text(AppStrings.deleteVehicle),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
