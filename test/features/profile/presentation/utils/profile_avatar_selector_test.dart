import 'dart:typed_data';

import 'package:bariq/features/profile/presentation/utils/profile_avatar_selector.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';

class MockImagePicker extends Mock implements ImagePicker {}

class MockProfileAvatarCropper extends Mock implements ProfileAvatarCropper {}

class MockXFile extends Mock implements XFile {}

void main() {
  late MockImagePicker picker;
  late MockProfileAvatarCropper cropper;
  late MockXFile pickedFile;
  late MockXFile croppedFile;

  setUp(() {
    picker = MockImagePicker();
    cropper = MockProfileAvatarCropper();
    pickedFile = MockXFile();
    croppedFile = MockXFile();
    when(
      () => picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: any(named: 'maxWidth'),
        maxHeight: any(named: 'maxHeight'),
        imageQuality: any(named: 'imageQuality'),
        requestFullMetadata: false,
      ),
    ).thenAnswer((_) async => pickedFile);
    when(() => cropper.crop(pickedFile)).thenAnswer((_) async => croppedFile);
    when(() => croppedFile.name).thenReturn('avatar.jpg');
    when(
      () => croppedFile.readAsBytes(),
    ).thenAnswer((_) async => Uint8List.fromList([1, 2, 3]));
  });

  test('crops a selected image before preparing the upload payload', () async {
    final selector = ProfileAvatarSelector(picker: picker, cropper: cropper);

    final avatar = await selector.pick();

    verify(() => cropper.crop(pickedFile)).called(1);
    expect(avatar?.extension, 'jpg');
    expect(avatar?.contentType, 'image/jpeg');
    expect(avatar?.bytes, orderedEquals([1, 2, 3]));
  });

  test('keeps the existing avatar when cropping is cancelled', () async {
    when(() => cropper.crop(pickedFile)).thenAnswer((_) async => null);
    final selector = ProfileAvatarSelector(picker: picker, cropper: cropper);

    expect(await selector.pick(), isNull);
  });
}
