import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../extensions/build_context_extensions.dart';
import '../../../localizations/l10n.dart';
import '../cubit/profile_cubit.dart';

/// A dialog that shows a camera preview to capture an image.
class CameraDialog extends StatefulWidget {
  /// Creates a new instance of [CameraDialog].
  const CameraDialog({required this.camera, super.key});

  /// The camera to use for the preview.
  final CameraDescription camera;

  @override
  State<CameraDialog> createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {
  late CameraController? _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized || _controller == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return _CameraPreview(controller: _controller);
  }

  Future<void> _initializeCamera() async {
    final List<CameraDescription> cameras = await availableCameras();
    if (cameras.isNotEmpty) {
      _controller = CameraController(cameras.first, ResolutionPreset.veryHigh);
      try {
        await _controller!.initialize();
        if (!mounted) return;
        setState(() {
          _isInitialized = true;
        });
      } catch (e) {
        if (!mounted) return;
        await context.showSnackBar(
          SnackBar(content: Text('${context.l10n.cameraAccessError} $e')),
        );
      }
    }
  }
}

class _CameraPreview extends StatelessWidget {
  const _CameraPreview({required this.controller});

  final CameraController? controller;

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return const Center(child: CircularProgressIndicator());
    }

    final ProfileCubit profileCubit = context.read<ProfileCubit>();

    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      content: AspectRatio(
        aspectRatio: controller!.value.aspectRatio,
        child: CameraPreview(controller!),
      ),
      actions: <Widget>[
        FilledButton(
          child: Text(
            context.l10n.captureImage,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () async {
            if (controller == null) return;
            await _takePictureAndCloseDialog(context, profileCubit).onError((
              Object? error,
              StackTrace stackTrace,
            ) async {
              if (!context.mounted) return;
              await context.showSnackBar(
                SnackBar(content: Text(context.l10n.generalCameraError)),
              );
            });
          },
        ),
      ],
    );
  }

  Future<void> _takePictureAndCloseDialog(
    BuildContext context,
    ProfileCubit profileCubit,
  ) async {
    final XFile image = await controller!.takePicture();
    final Uint8List bytes = await image.readAsBytes();
    await profileCubit.updateProfileImage(bytes);
    if (!context.mounted) return;
    context.pop();
  }
}
