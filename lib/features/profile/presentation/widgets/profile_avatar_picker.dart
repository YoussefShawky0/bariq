import 'dart:typed_data';

import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/core/theme/app_sizes.dart';
import 'package:bariq/core/theme/app_spacing.dart';
import 'package:bariq/core/theme/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileAvatarPicker extends StatelessWidget {
  const ProfileAvatarPicker({
    required this.selectedBytes,
    required this.currentUrl,
    required this.onPressed,
    required this.enabled,
    super.key,
  });

  final Uint8List? selectedBytes;
  final String? currentUrl;
  final VoidCallback onPressed;
  final bool enabled;

  bool get _hasAvatar => selectedBytes != null || currentUrl != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Semantics(
          button: true,
          image: true,
          label: AppStrings.avatarSemanticLabel,
          child: InkWell(
            onTap: enabled ? onPressed : null,
            customBorder: const CircleBorder(),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                _AvatarImage(bytes: selectedBytes, url: currentUrl),
                _AvatarAction(enabled: enabled),
              ],
            ),
          ),
        ),
        SizedBox(height: AppSpacing.profileAvatarGap),
        TextButton(
          onPressed: enabled ? onPressed : null,
          child: Text(
            _hasAvatar
                ? AppStrings.changeProfilePhoto
                : AppStrings.addProfilePhoto,
            style: AppTextStyles.authLink,
          ),
        ),
      ],
    );
  }
}

class _AvatarImage extends StatelessWidget {
  const _AvatarImage({required this.bytes, required this.url});

  final Uint8List? bytes;
  final String? url;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: AppSizes.profileAvatar,
      child: ClipOval(child: _buildContent()),
    );
  }

  Widget _buildContent() {
    if (bytes != null) {
      return Image.memory(bytes!, fit: BoxFit.cover);
    }
    if (url != null) {
      return Image.network(
        url!,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => const _AvatarFallback(),
      );
    }
    return const _AvatarFallback();
  }
}

class _AvatarFallback extends StatelessWidget {
  const _AvatarFallback();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.aquaSurface,
      child: Icon(
        Icons.person_outline_rounded,
        color: AppColors.aqua,
        size: AppSizes.profileAvatarIcon,
      ),
    );
  }
}

class _AvatarAction extends StatelessWidget {
  const _AvatarAction({required this.enabled});

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: enabled ? AppColors.navy : AppColors.textMuted,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.surface),
      ),
      child: SizedBox.square(
        dimension: AppSizes.profileAvatarAction,
        child: Icon(
          Icons.edit_outlined,
          color: AppColors.surface,
          size: AppSizes.profileTermsIcon,
        ),
      ),
    );
  }
}
