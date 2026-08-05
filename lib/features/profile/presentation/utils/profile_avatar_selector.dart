import 'package:bariq/core/constants/app_strings.dart';
import 'package:bariq/core/theme/app_colors.dart';
import 'package:bariq/features/profile/domain/entities/profile_avatar.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

final class UnsupportedProfileAvatarException implements Exception {
  const UnsupportedProfileAvatarException();
}

abstract interface class ProfileAvatarCropper {
  Future<XFile?> crop(XFile source);
}

final class NativeProfileAvatarCropper implements ProfileAvatarCropper {
  NativeProfileAvatarCropper({ImageCropper? cropper})
    : _cropper = cropper ?? ImageCropper();

  final ImageCropper _cropper;

  @override
  Future<XFile?> crop(XFile source) async {
    final result = await _cropper.cropImage(
      sourcePath: source.path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
      maxWidth: ProfileAvatarRules.maxDimension.toInt(),
      maxHeight: ProfileAvatarRules.maxDimension.toInt(),
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: ProfileAvatarRules.imageQuality,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: AppStrings.cropAvatarTitle,
          toolbarColor: AppColors.navy,
          toolbarWidgetColor: AppColors.surface,
          activeControlsWidgetColor: AppColors.aqua,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: AppStrings.cropAvatarTitle,
          doneButtonTitle: AppStrings.cropAvatarDone,
          cancelButtonTitle: AppStrings.cropAvatarCancel,
          aspectRatioLockEnabled: true,
          resetAspectRatioEnabled: false,
        ),
      ],
    );
    return result == null ? null : XFile(result.path);
  }
}

final class ProfileAvatarSelector {
  ProfileAvatarSelector({ImagePicker? picker, ProfileAvatarCropper? cropper})
    : _picker = picker ?? ImagePicker(),
      _cropper = cropper ?? NativeProfileAvatarCropper();

  final ImagePicker _picker;
  final ProfileAvatarCropper _cropper;

  Future<ProfileAvatar?> pick() async {
    final file = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: ProfileAvatarRules.maxDimension,
      maxHeight: ProfileAvatarRules.maxDimension,
      imageQuality: ProfileAvatarRules.imageQuality,
      requestFullMetadata: false,
    );
    return file == null ? null : _cropAndPrepare(file);
  }

  Future<ProfileAvatar?> recover() async {
    final response = await _picker.retrieveLostData();
    final files = response.files;
    if (response.isEmpty || files == null || files.isEmpty) {
      return null;
    }
    return _cropAndPrepare(files.first);
  }

  Future<ProfileAvatar?> _cropAndPrepare(XFile source) async {
    final cropped = await _cropper.crop(source);
    return cropped == null ? null : _prepare(cropped);
  }

  Future<ProfileAvatar> _prepare(XFile file) async {
    final extension = file.name.split('.').last.toLowerCase();
    final contentType = ProfileAvatarRules.supportedTypes[extension];
    if (contentType == null) {
      throw const UnsupportedProfileAvatarException();
    }
    return ProfileAvatar(
      bytes: await file.readAsBytes(),
      extension: extension,
      contentType: contentType,
    );
  }
}
