import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_radius.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:bariq/features/addresses/domain/entities/address.dart';
import 'package:bariq/features/addresses/presentation/bloc/addresses_bloc.dart';
import 'package:bariq/features/addresses/presentation/pages/address_form_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Addresses list page.
class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressesBloc, AddressesState>(
      listenWhen: (_, current) => current.maybeWhen(
        success: (_, mutation) => mutation == AddressMutation.delete,
        failure: (_, _, mutation) => mutation == AddressMutation.delete,
        orElse: () => false,
      ),
      listener: _showMutationFeedback,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text(AppStrings.addressesTab)),
          body: SafeArea(child: _buildBody(context, state)),
          floatingActionButton: _canMutate(state)
              ? FloatingActionButton.extended(
                  onPressed: () => _openAddressForm(context),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text(AppStrings.addAddress),
                )
              : null,
        );
      },
    );
  }

  Widget _buildBody(BuildContext context, AddressesState state) {
    return state.when(
      initial: () => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
      ready: (addresses) => _AddressList(addresses: addresses),
      saving: (addresses) => _AddressList(addresses: addresses, isSaving: true),
      deleting: (addresses, _) =>
          _AddressList(addresses: addresses, isSaving: true),
      success: (addresses, _) => _AddressList(addresses: addresses),
      loadFailure: (failure) => Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppStrings.addressesLoadFailed, style: AppTextStyles.body),
            SizedBox(height: AppSpacing.regular),
            FilledButton(
              onPressed: () => context.read<AddressesBloc>().add(
                const AddressesEvent.started(),
              ),
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      ),
      failure: (addresses, _, _) => _AddressList(addresses: addresses),
    );
  }

  void _showMutationFeedback(BuildContext context, AddressesState state) {
    state.whenOrNull(
      success: (_, mutation) {
        if (mutation == AddressMutation.delete) {
          _showMessage(context, AppStrings.addressDeleted);
        }
      },
      failure: (_, failure, mutation) {
        if (mutation == AddressMutation.delete) {
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

  bool _canMutate(AddressesState state) => state.maybeWhen(
    ready: (_) => true,
    success: (_, _) => true,
    failure: (_, _, _) => true,
    orElse: () => false,
  );

  void _openAddressForm(BuildContext context) {
    final bloc = context.read<AddressesBloc>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) =>
            BlocProvider.value(value: bloc, child: const AddressFormPage()),
      ),
    );
  }
}

class _AddressList extends StatelessWidget {
  const _AddressList({required this.addresses, this.isSaving = false});

  final List<Address> addresses;
  final bool isSaving;

  @override
  Widget build(BuildContext context) {
    if (addresses.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.all(AppSpacing.section),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.location_off_rounded,
                size: 64.r,
                color: AppColors.dotInactive,
              ),
              SizedBox(height: AppSpacing.regular),
              Text(
                AppStrings.emptyAddressesTitle,
                style: AppTextStyles.title,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: AppSpacing.compact),
              Text(
                AppStrings.emptyAddressesBody,
                style: AppTextStyles.body,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Stack(
      children: [
        ListView.separated(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.pageHorizontal,
            AppSpacing.regular,
            AppSpacing.pageHorizontal,
            80.h,
          ),
          itemCount: addresses.length,
          separatorBuilder: (_, _) => SizedBox(height: AppSpacing.fieldGap),
          itemBuilder: (context, index) =>
              _AddressCard(address: addresses[index]),
        ),
        if (isSaving)
          const Positioned.fill(
            child: ColoredBox(
              color: Color(0x33FFFFFF),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});
  final Address address;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.medium),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, color: AppColors.aqua, size: 24.r),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        address.label,
                        style: AppTextStyles.vehicleName,
                      ),
                    ),
                    if (address.isDefault)
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.aquaSurface,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          AppStrings.defaultAddress,
                          style: AppTextStyles.vehicleBadge,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  '${address.street} • ${address.zoneName}',
                  style: AppTextStyles.helper,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.delete_outline,
              color: AppColors.error,
              size: 20.r,
            ),
            onPressed: () => _confirmDelete(context),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text(AppStrings.deleteAddressTitle),
        content: Text(AppStrings.deleteAddressBody(address.label)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(AppStrings.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AddressesBloc>().add(
                AddressesEvent.deleteConfirmed(address.id),
              );
            },
            child: const Text(
              AppStrings.deleteAddress,
              style: TextStyle(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }
}
