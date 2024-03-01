import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({
    super.key,
    required this.isVideoRecording,
    required this.stopVideoRecording,
    required this.startVideoRecording,
    required this.isPictureMode,
    required this.captureImage,
  });
  final ValueNotifier<bool> isVideoRecording;
  final bool isPictureMode;
  final Future<void> Function(BuildContext context) stopVideoRecording;
  final Future<void> Function() startVideoRecording;
  final Future<void> Function(BuildContext context) captureImage;
  // final MyCameraController myCameraController;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isVideoRecording,
      builder: (context, val, child) {
        log(val.toString());
        return GestureDetector(
          onTap: () async {
            if (isPictureMode) {
              log('Capture');
              await captureImage(context);
            } else {
              if (val) {
                stopVideoRecording(context);
              } else {
                startVideoRecording();
              }
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 100),
            height: !isPictureMode
                ? val
                    ? 110
                    : 90
                : 110,
            width: !isPictureMode
                ? val
                    ? 110
                    : 90
                : 90,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.redColor, width: 5),
                color: isPictureMode
                    ? AppColors.redColor
                    : val
                        ? AppColors.redColor
                        : null),
            child: isPictureMode
                ? const Icon(
                    Icons.camera,
                    color: AppColors.whiteColor,
                    size: 50,
                  )
                : null,
          ),
        );
      },
    );
  }
}
