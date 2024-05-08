import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/l10n.dart';
import '../cubit/profile_cubit.dart';
import 'camera_dialog.dart';

/// The options to pick an image.
class ImageOptionButton extends StatefulWidget {
  /// Creates a new instance of [ImageOptionButton].
  const ImageOptionButton({
    required this.source,
    required this.title,
    required this.icon,
    super.key,
  });

  /// Creates a new instance of [ImageOptionButton].
  final ImageSource source;

  /// The title of the option.
  final String title;

  /// The icon of the option.
  final IconData icon;

  @override
  State<ImageOptionButton> createState() => _ImageOptionButtonState();
}

class _ImageOptionButtonState extends State<ImageOptionButton> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(widget.icon),
      title: Text(widget.title),
      onTap: () {
        try {
          _pickImage(context, widget.source);
        } catch (e) {
          _showErrorSnackBar(context.l10n.generalCameraError);
        }
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    if (kIsWeb) {
      await _handleWebImagePick(context, source);
    } else {
      await _handleMobileImagePick(context, source);
    }
  }

  Future<void> _handleWebImagePick(
    BuildContext context,
    ImageSource source,
  ) async {
    if (source == ImageSource.camera) {
      await _pickImageFromCameraWeb(context);
    } else {
      await _pickImageFromGallery(context);
    }
  }

  Future<void> _pickImageFromCameraWeb(
    BuildContext context,
  ) async {
    final List<CameraDescription> cameras = await availableCameras();
    if (!mounted) return;
    // Potential exceptions for this case are handeled in the CameraDialog.
    // Try catch not necessary.
    _showCameraDialog(cameras);
  }

  void _showCameraDialog(List<CameraDescription> cameras) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) =>
          CameraDialog(camera: cameras.first),
    );
  }

  void _showErrorSnackBar(String message) {
    context.showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _handleMobileImagePick(
    BuildContext context,
    ImageSource source,
  ) async {
    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    final XFile? pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final Uint8List bytes = await pickedImage.readAsBytes();
      await profileCubit.updateProfileImage(bytes).then((_) => context.pop());
    }
  }

  Future<void> _pickImageFromGallery(
    BuildContext context,
  ) async {
    final ProfileCubit profileCubit = context.read<ProfileCubit>();
    final XFile? pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      final Uint8List bytes = await pickedImage.readAsBytes();
      await profileCubit.updateProfileImage(bytes).then((_) => context.pop());
    }
  }
}
