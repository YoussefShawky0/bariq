import 'dart:async';

import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/features/profile/domain/entities/customer_profile.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:bariq/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:bariq/features/profile/presentation/utils/profile_avatar_selector.dart';
import 'package:bariq/features/profile/presentation/utils/profile_form_controller.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_form_content.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_status_views.dart';
import 'package:bariq/features/profile/presentation/widgets/profile_terms_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCompletionPage extends StatefulWidget {
  const ProfileCompletionPage({
    required this.onCompleted,
    this.avatarSelector,
    super.key,
  });

  final Future<void> Function() onCompleted;
  final ProfileAvatarSelector? avatarSelector;

  @override
  State<ProfileCompletionPage> createState() => _ProfileCompletionPageState();
}

class _ProfileCompletionPageState extends State<ProfileCompletionPage> {
  final _form = ProfileFormController();
  late final ProfileAvatarSelector _avatarSelector =
      widget.avatarSelector ?? ProfileAvatarSelector();

  @override
  void initState() {
    super.initState();
    unawaited(_recoverLostAvatar());
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        state.whenOrNull(
          ready: _initializeForm,
          completed: (_) => unawaited(widget.onCompleted()),
        );
      },
      builder: (context, state) => state.when(
        initial: ProfileLoadingView.new,
        loading: ProfileLoadingView.new,
        ready: (profile) => _buildForm(profile),
        submitting: (profile) => _buildForm(profile, isLoading: true),
        completed: (profile) => _buildForm(profile, isLoading: true),
        loadFailure: (_) => ProfileLoadFailureView(onRetry: _retry),
        failure: (profile, failure) =>
            _buildForm(profile, errorMessage: failure.message),
      ),
    );
  }

  Widget _buildForm(
    CustomerProfile profile, {
    bool isLoading = false,
    String? errorMessage,
  }) {
    _form.initialize(profile);
    return ProfileFormContent(
      profile: profile,
      fullNameController: _form.fullName,
      phoneController: _form.phone,
      selectedGovernorate: _form.governorate,
      areaController: _form.area,
      selectedAvatar: _form.avatar?.bytes,
      acceptedTerms: _form.acceptedTerms,
      isLoading: isLoading,
      errorMessage: _form.localError ?? errorMessage,
      onPickAvatar: _pickAvatar,
      onGovernorateChanged: (value) => setState(() {
        _form.setGovernorate(value);
      }),
      onTermsChanged: (value) => setState(() {
        _form.setTerms(value);
      }),
      onViewTerms: () => showProfileTermsSheet(context),
      onSubmit: _submit,
    );
  }

  void _initializeForm(CustomerProfile profile) => _form.initialize(profile);

  Future<void> _pickAvatar() async {
    try {
      final avatar = await _avatarSelector.pick();
      _applyAvatar(avatar);
    } on UnsupportedProfileAvatarException {
      _setLocalError(AppStrings.avatarFormatError);
    } on Object {
      _setLocalError(AppStrings.avatarReadError);
    }
  }

  Future<void> _recoverLostAvatar() async {
    try {
      _applyAvatar(await _avatarSelector.recover());
    } on UnsupportedProfileAvatarException {
      _setLocalError(AppStrings.avatarFormatError);
    } on Object {
      _setLocalError(AppStrings.avatarReadError);
    }
  }

  void _applyAvatar(ProfileAvatar? avatar) {
    if (!mounted || avatar == null) {
      return;
    }
    setState(() {
      _form.setAvatar(avatar);
    });
  }

  void _submit() {
    setState(() => _form.localError = null);
    context.read<ProfileBloc>().add(_form.submission());
  }

  void _retry() =>
      context.read<ProfileBloc>().add(const ProfileEvent.started());

  void _setLocalError(String message) {
    if (mounted) {
      setState(() => _form.localError = message);
    }
  }
}
