import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/features/vehicles/domain/entities/vehicle.dart';
import 'package:bariq/features/vehicles/presentation/bloc/vehicles_bloc.dart';
import 'package:bariq/features/vehicles/presentation/utils/vehicle_form_controller.dart';
import 'package:bariq/features/vehicles/presentation/widgets/vehicle_form_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehicleFormPage extends StatefulWidget {
  const VehicleFormPage({this.vehicle, super.key});

  final Vehicle? vehicle;

  @override
  State<VehicleFormPage> createState() => _VehicleFormPageState();
}

class _VehicleFormPageState extends State<VehicleFormPage> {
  late final VehicleFormController _form = VehicleFormController(
    widget.vehicle,
  );
  String? _errorMessage;

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VehiclesBloc, VehiclesState>(
      listenWhen: (_, current) => current.maybeWhen(
        success: (_, mutation) => mutation == VehicleMutation.save,
        failure: (_, _, mutation) => mutation == VehicleMutation.save,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          success: (_, mutation) {
            if (mutation == VehicleMutation.save) {
              Navigator.of(context).pop();
            }
          },
          failure: (_, failure, mutation) {
            if (mutation == VehicleMutation.save) {
              setState(() => _errorMessage = failure.message);
            }
          },
        );
      },
      builder: (context, state) {
        final isLoading = state is VehiclesSaving;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              widget.vehicle == null
                  ? AppStrings.addVehicle
                  : AppStrings.editVehicle,
            ),
          ),
          body: VehicleFormContent(
            makeController: _form.make,
            modelController: _form.model,
            colorController: _form.color,
            plateController: _form.plate,
            selectedYear: _form.year,
            availableYears: _form.availableYears,
            selectedClass: _form.vehicleClass,
            isDefault: _form.isDefault,
            isDefaultLocked: widget.vehicle?.isDefault ?? false,
            isLoading: isLoading,
            errorMessage: _errorMessage,
            onYearChanged: (value) => setState(() {
              if (value != null) {
                _form.year = value;
              }
            }),
            onClassChanged: (value) => setState(() {
              if (value != null) {
                _form.vehicleClass = value;
              }
            }),
            onDefaultChanged: (value) => setState(() {
              _form.isDefault = value;
            }),
            onSubmit: _submit,
          ),
        );
      },
    );
  }

  void _submit() {
    setState(() => _errorMessage = null);
    context.read<VehiclesBloc>().add(VehiclesEvent.submitted(_form.input));
  }
}
