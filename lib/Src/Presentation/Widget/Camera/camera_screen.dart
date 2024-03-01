import 'dart:developer';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Appdata/Data.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/extensions/styling.dart';
import 'package:flutter_camera/Src/Presentation/Common/app_text.dart';
import 'package:flutter_camera/Src/Presentation/Widget/Camera/Common/capture_button.dart';
import 'package:flutter_camera/Src/Presentation/Widget/Camera/Controller/my_camera_controller.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  MyCameraController myCameraController = MyCameraController();
  @override
  void initState() {
    if (mounted) {
      myCameraController.initCamera();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).aspectRatio;
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: myCameraController.cameraLoaded,
        builder: (context, value, child) {
          if (value) {
            log(myCameraController.controller.value.toString());
            return AspectRatio(
              aspectRatio: size,
              child: CameraPreview(
                myCameraController.controller,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ValueListenableBuilder(
                      valueListenable: myCameraController.isVideoRecording,
                      builder: (context, value, child) {
                        return value
                            ? Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                    color: AppColors.redColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(40)),
                                child: ValueListenableBuilder(
                                  valueListenable: myCameraController.videoTime,
                                  builder: (context, value, child) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.circle,
                                              color: AppColors.redColor,
                                              size: 16)
                                          .onlyPadding(r: 6),
                                      Apptext(
                                        text: "$value Seconds",
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: AppColors.redColor),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                    SizedBox(
                      child: ValueListenableBuilder(
                        valueListenable: myCameraController.isPictureMode,
                        builder: (context, isPictureMode, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () {
                                  myCameraController.toggleMode();
                                },
                                icon: Icon(
                                    isPictureMode
                                        ? Icons.videocam_rounded
                                        : Icons.camera_alt,
                                    size: 40,
                                    color: AppColors.lightblackColor)),
                            CaptureButton(
                              isVideoRecording:
                                  myCameraController.isVideoRecording,
                              stopVideoRecording:
                                  myCameraController.stopVideoRecording,
                              startVideoRecording:
                                  myCameraController.startRecording,
                              isPictureMode: isPictureMode,
                              captureImage: myCameraController.captureImage,
                            ),
                            IconButton(
                                onPressed: () {
                                  myCameraController.toggleCamera();
                                },
                                icon: const Icon(Icons.cameraswitch,
                                    size: 40,
                                    color: AppColors.lightblackColor)),
                          ],
                        ),
                      ),
                    ).onlyPadding(b: 30)
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
