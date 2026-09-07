import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/domain/entities/address_input.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Address form page for adding or editing an address.
class AddressFormPage extends StatefulWidget {
  const AddressFormPage({this.address, super.key});

  /// If provided, the form is in edit mode.
  final Address? address;

  @override
  State<AddressFormPage> createState() => _AddressFormPageState();
}

class _AddressFormPageState extends State<AddressFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _labelController;
  late final TextEditingController _streetController;
  late final TextEditingController _buildingController;
  late final TextEditingController _floorController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _notesController;
  String? _selectedZoneId;
  bool _isDefault = false;
  AddressReadiness _readiness = const AddressReadiness();

  bool get _isEdit => widget.address != null;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _labelController = TextEditingController(text: a?.label);
    _streetController = TextEditingController(text: a?.street);
    _buildingController = TextEditingController(text: a?.building);
    _floorController = TextEditingController(text: a?.floor);
    _apartmentController = TextEditingController(text: a?.apartment);
    _notesController = TextEditingController(text: a?.accessNotes);
    _selectedZoneId = a?.zoneId;
    _isDefault = a?.isDefault ?? false;
    _readiness = a?.readiness ?? const AddressReadiness();
  }

  @override
  void dispose() {
    _labelController.dispose();
    _streetController.dispose();
    _buildingController.dispose();
    _floorController.dispose();
    _apartmentController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final zones = context.read<AddressesBloc>().zones;

    return BlocListener<AddressesBloc, AddressesState>(
      listenWhen: (_, current) => current.maybeWhen(
        success: (_, mutation) => mutation == AddressMutation.save,
        failure: (_, _, mutation) => mutation == AddressMutation.save,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.whenOrNull(
          success: (_, mutation) {
            if (mutation == AddressMutation.save) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.addressSaved)),
              );
              Navigator.of(context).pop();
            }
          },
          failure: (_, failure, mutation) {
            if (mutation == AddressMutation.save) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(failure.message)));
            }
          },
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(_isEdit ? AppStrings.editAddress : AppStrings.addAddress),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: AppSpacing.pageHorizontal,
              vertical: AppSpacing.pageVertical,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Label.
                  TextFormField(
                    controller: _labelController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addressLabel,
                      hintText: AppStrings.addressLabelHint,
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                  ),
                  SizedBox(height: AppSpacing.fieldGap),

                  // Zone dropdown.
                  DropdownButtonFormField<String>(
                    initialValue: _selectedZoneId,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addressZone,
                    ),
                    items: zones
                        .map(
                          (z) => DropdownMenuItem(
                            value: z.id,
                            child: Text(z.nameAr),
                          ),
                        )
                        .toList(),
                    onChanged: (v) => setState(() => _selectedZoneId = v),
                    validator: (v) =>
                        (v == null || v.isEmpty) ? 'اختر المنطقة' : null,
                  ),
                  SizedBox(height: AppSpacing.fieldGap),

                  // Street.
                  TextFormField(
                    controller: _streetController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addressStreet,
                    ),
                    validator: (v) =>
                        (v == null || v.trim().isEmpty) ? 'مطلوب' : null,
                  ),
                  SizedBox(height: AppSpacing.fieldGap),

                  // Building / Floor / Apartment row.
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _buildingController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.addressBuilding,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.fieldGap),
                      Expanded(
                        child: TextFormField(
                          controller: _floorController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.addressFloor,
                          ),
                        ),
                      ),
                      SizedBox(width: AppSpacing.fieldGap),
                      Expanded(
                        child: TextFormField(
                          controller: _apartmentController,
                          decoration: const InputDecoration(
                            labelText: AppStrings.addressApartment,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSpacing.fieldGap),

                  // Access notes.
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(
                      labelText: AppStrings.addressAccessNotes,
                      hintText: AppStrings.addressAccessNotesHint,
                    ),
                    maxLines: 2,
                  ),
                  SizedBox(height: AppSpacing.section),

                  // Readiness checklist.
                  Text(
                    AppStrings.readinessTitle,
                    style: AppTextStyles.sectionTitle,
                  ),
                  SizedBox(height: AppSpacing.compact),
                  _ReadinessToggle(
                    label: AppStrings.readinessWater,
                    value: _readiness.hasAccess,
                    onChanged: (v) => setState(
                      () => _readiness = AddressReadiness(
                        hasAccess: v,
                        hasVehicleSpace: _readiness.hasVehicleSpace,
                        noWaterNeeded: _readiness.noWaterNeeded,
                        hasPermission: _readiness.hasPermission,
                      ),
                    ),
                  ),
                  _ReadinessToggle(
                    label: AppStrings.readinessElectricity,
                    value: _readiness.hasVehicleSpace,
                    onChanged: (v) => setState(
                      () => _readiness = AddressReadiness(
                        hasAccess: _readiness.hasAccess,
                        hasVehicleSpace: v,
                        noWaterNeeded: _readiness.noWaterNeeded,
                        hasPermission: _readiness.hasPermission,
                      ),
                    ),
                  ),
                  _ReadinessToggle(
                    label: AppStrings.readinessSpace,
                    value: _readiness.noWaterNeeded,
                    onChanged: (v) => setState(
                      () => _readiness = AddressReadiness(
                        hasAccess: _readiness.hasAccess,
                        hasVehicleSpace: _readiness.hasVehicleSpace,
                        noWaterNeeded: v,
                        hasPermission: _readiness.hasPermission,
                      ),
                    ),
                  ),
                  _ReadinessToggle(
                    label: AppStrings.readinessPermission,
                    value: _readiness.hasPermission,
                    onChanged: (v) => setState(
                      () => _readiness = AddressReadiness(
                        hasAccess: _readiness.hasAccess,
                        hasVehicleSpace: _readiness.hasVehicleSpace,
                        noWaterNeeded: _readiness.noWaterNeeded,
                        hasPermission: v,
                      ),
                    ),
                  ),
                  SizedBox(height: AppSpacing.section),

                  // Default toggle.
                  SwitchListTile(
                    value: _isDefault,
                    onChanged: (v) => setState(() => _isDefault = v),
                    title: const Text(AppStrings.makeDefaultAddress),
                    activeThumbColor: AppColors.aqua,
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: AppSpacing.section),

                  // Submit.
                  BlocBuilder<AddressesBloc, AddressesState>(
                    builder: (context, state) {
                      final isSaving = state is AddressesSaving;
                      return SizedBox(
                        height: 52.h,
                        child: FilledButton(
                          onPressed: isSaving ? null : _onSubmit,
                          child: isSaving
                              ? SizedBox(
                                  width: 22.r,
                                  height: 22.r,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.w,
                                    color: AppColors.surface,
                                  ),
                                )
                              : const Text(AppStrings.saveAddress),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final input = AddressInput(
      id: widget.address?.id,
      label: _labelController.text.trim(),
      zoneId: _selectedZoneId!,
      street: _streetController.text.trim(),
      isDefault: _isDefault,
      building: _buildingController.text.trim().isNotEmpty
          ? _buildingController.text.trim()
          : null,
      floor: _floorController.text.trim().isNotEmpty
          ? _floorController.text.trim()
          : null,
      apartment: _apartmentController.text.trim().isNotEmpty
          ? _apartmentController.text.trim()
          : null,
      accessNotes: _notesController.text.trim().isNotEmpty
          ? _notesController.text.trim()
          : null,
      readiness: _readiness,
    );

    context.read<AddressesBloc>().add(AddressesEvent.submitted(input));
  }
}

class _ReadinessToggle extends StatelessWidget {
  const _ReadinessToggle({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: value,
      onChanged: (v) => onChanged(v ?? false),
      title: Text(label, style: AppTextStyles.body.copyWith(fontSize: 14.sp)),
      activeColor: AppColors.aqua,
      controlAffinity: ListTileControlAffinity.leading,
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}
