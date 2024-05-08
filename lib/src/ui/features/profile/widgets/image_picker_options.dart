import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../constants/sizes_constants.dart';
import '../../../localizations/l10n.dart';
import 'image_option_button.dart';

/// The options to pick an image.
class ImagePickerOptions extends StatelessWidget {
  /// Creates a new instance of [ImagePickerOptions].
  const ImagePickerOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: Sizes.s24, bottom: Sizes.s16),
      child: Wrap(
        children: <Widget>[
          ImageOptionButton(
            source: ImageSource.camera,
            title: context.l10n.takePicture,
            icon: Icons.camera_alt,
          ),
          ImageOptionButton(
            source: ImageSource.gallery,
            title: context.l10n.chooseFromGallery,
            icon: Icons.photo_library,
          ),
        ],
      ),
    );
  }
}
