import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/utils/vehicle_form_navigation.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_delete_dialog.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicles_header.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicles_list_content.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicles_status_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesStateBody extends StatelessWidget {
  const VehiclesStateBody(this.state, {super.key});

  final VehiclesState state;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: AppSizes.vehiclesContentMaxWidth),
        child: state.when(
          initial: VehiclesLoadingView.new,
          loading: VehiclesLoadingView.new,
          loadFailure: (_) => VehiclesLoadFailureView(
            onRetry: () =>
                context.read<VehiclesBloc>().add(const VehiclesEvent.started()),
          ),
          ready: (vehicles) => _buildList(context, vehicles),
          saving: (vehicles) => _buildList(context, vehicles, busy: true),
          deleting: (vehicles, id) =>
              _buildList(context, vehicles, busy: true, deletingId: id),
          success: (vehicles, _) => _buildList(context, vehicles),
          failure: (vehicles, _, _) => _buildList(context, vehicles),
        ),
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<Vehicle> vehicles, {
    bool busy = false,
    String? deletingId,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const VehiclesHeader(),
        SizedBox(height: AppSpacing.regular),
        Expanded(
          child: VehiclesListContent(
            vehicles: vehicles,
            busy: busy,
            deletingId: deletingId,
            onAdd: () => openVehicleForm(context),
            onEdit: (vehicle) => openVehicleForm(context, vehicle),
            onDelete: (vehicle) => _delete(context, vehicle),
          ),
        ),
      ],
    );
  }

  Future<void> _delete(BuildContext context, Vehicle vehicle) async {
    final confirmed = await confirmVehicleDeletion(context, vehicle);
    if (confirmed && context.mounted) {
      context.read<VehiclesBloc>().add(
        VehiclesEvent.deleteConfirmed(vehicle.id),
      );
    }
  }
}
