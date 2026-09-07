import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:flutter/material.dart';

enum VehicleCardAction { edit, delete }

class VehicleCard extends StatelessWidget {
  const VehicleCard({
    required this.vehicle,
    required this.onEdit,
    required this.onDelete,
    required this.enabled,
    required this.isDeleting,
    super.key,
  });

  final Vehicle vehicle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool enabled;
  final bool isDeleting;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        enabled: enabled,
        onTap: enabled ? onEdit : null,
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSpacing.regular,
          vertical: AppSpacing.compact,
        ),
        leading: const _VehicleIcon(),
        title: _VehicleTitle(vehicle),
        subtitle: _VehicleDetails(vehicle),
        trailing: isDeleting
            ? SizedBox.square(
                dimension: AppSizes.vehicleLoadingIndicator,
                child: CircularProgressIndicator(
                  strokeWidth: AppSizes.vehicleLoadingStroke,
                ),
              )
            : _VehicleMenu(
                onEdit: onEdit,
                onDelete: onDelete,
                enabled: enabled,
              ),
      ),
    );
  }
}

class _VehicleIcon extends StatelessWidget {
  const _VehicleIcon();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: AppSizes.vehicleIcon,
      backgroundColor: AppColors.aquaSurface,
      foregroundColor: AppColors.aqua,
      child: Icon(Icons.directions_car_outlined, size: AppSizes.vehicleIcon),
    );
  }
}

class _VehicleTitle extends StatelessWidget {
  const _VehicleTitle(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.compact,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(vehicle.displayName, style: AppTextStyles.vehicleName),
        if (vehicle.isDefault)
          Text(AppStrings.defaultVehicle, style: AppTextStyles.vehicleBadge),
      ],
    );
  }
}

class _VehicleDetails extends StatelessWidget {
  const _VehicleDetails(this.vehicle);

  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${AppStrings.vehicleMeta(vehicle.year, vehicle.vehicleClass.arabicLabel)}\n'
      '${vehicle.color} • ${vehicle.plateNumber}',
      style: AppTextStyles.helper,
    );
  }
}

class _VehicleMenu extends StatelessWidget {
  const _VehicleMenu({
    required this.onEdit,
    required this.onDelete,
    required this.enabled,
  });

  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<VehicleCardAction>(
      enabled: enabled,
      onSelected: (action) => switch (action) {
        VehicleCardAction.edit => onEdit(),
        VehicleCardAction.delete => onDelete(),
      },
      itemBuilder: (_) => const [
        PopupMenuItem(
          value: VehicleCardAction.edit,
          child: Text(AppStrings.editVehicle),
        ),
        PopupMenuItem(
          value: VehicleCardAction.delete,
          child: Text(AppStrings.deleteVehicle),
        ),
      ],
    );
  }
}
