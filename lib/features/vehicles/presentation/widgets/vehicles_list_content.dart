import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_card.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicles_empty_view.dart';
import 'package:flutter/material.dart';

class VehiclesListContent extends StatelessWidget {
  const VehiclesListContent({
    required this.vehicles,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
    this.busy = false,
    this.deletingId,
    super.key,
  });

  final List<Vehicle> vehicles;
  final VoidCallback onAdd;
  final ValueChanged<Vehicle> onEdit;
  final ValueChanged<Vehicle> onDelete;
  final bool busy;
  final String? deletingId;

  @override
  Widget build(BuildContext context) {
    if (vehicles.isEmpty) {
      return VehiclesEmptyView(onAdd: busy ? _ignore : onAdd);
    }
    return ListView.separated(
      padding: EdgeInsets.only(
        left: AppSpacing.pageHorizontal,
        right: AppSpacing.pageHorizontal,
        top: AppSpacing.compact,
        bottom: AppSpacing.spacious,
      ),
      itemCount: vehicles.length,
      separatorBuilder: (_, _) => SizedBox(height: AppSpacing.compact),
      itemBuilder: (_, index) {
        final vehicle = vehicles[index];
        return VehicleCard(
          vehicle: vehicle,
          enabled: !busy,
          isDeleting: deletingId == vehicle.id,
          onEdit: () => onEdit(vehicle),
          onDelete: () => onDelete(vehicle),
        );
      },
    );
  }

  static void _ignore() {}
}
