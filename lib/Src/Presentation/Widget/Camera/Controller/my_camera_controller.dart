import 'dart:async';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Appdata/Data.dart';
import 'package:flutter_camera/Src/Presentation/Widget/Camera/camera_screen.dart';
import 'package:flutter_camera/Src/Presentation/Widget/PictureView/picture_view_screen.dart';
import 'package:flutter_camera/Src/Presentation/Widget/VideoPlay/video_play_screen.dart';

class MyCameraController with ChangeNotifier {
  late CameraController controller;
  int selectedCameraInt = 0;
  ValueNotifier<bool> isVideoRecording = ValueNotifier(false);
  ValueNotifier<bool> cameraLoaded = ValueNotifier(false);
  ValueNotifier<int> videoTime = ValueNotifier(0);
  Timer? timer;
  ValueNotifier<File?> capturedImage = ValueNotifier(null);
  File? recordedVideo;
  ValueNotifier<bool> isPictureMode = ValueNotifier(true);

  initCamera() async {
    log('>>>>Initing Camera');
    controller = CameraController(
        Data().cameras[selectedCameraInt], ResolutionPreset.ultraHigh,
        enableAudio: false);
    controller.initialize().then((_) {
      cameraLoaded.value = true;
      cameraLoaded.notifyListeners();
    }).catchError((Object e) {
      log(e.toString());
    });
  }

  Future<void> startRecording() async {
    isVideoRecording.value = true;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      videoTime.value = timer.tick;
      log(videoTime.value.toString());

      videoTime.notifyListeners();
    });

    await controller.startVideoRecording();
  }

  Future<void> stopVideoRecording(context) async {
    isVideoRecording.value = false;
    isVideoRecording.notifyListeners();
    timer?.cancel();
    videoTime.value = 0;

    XFile recorded = await controller.stopVideoRecording();
    log(recorded.path.toString());
    await Future.delayed(const Duration(milliseconds: 200));
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreen(video: File(recorded.path)),
      ),
    );
  }

  Future<void> captureImage(context) async {
    final XFile capture = await controller.takePicture();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PictureViewScreen(image: File(capture.path)),
      ),
    );
  }

  void toggleMode() {
    isPictureMode.value = !isPictureMode.value;
  }

  void toggleCamera() {
    int newCam = selectedCameraInt == 1 ? 0 : 1;
    controller.setDescription(Data().cameras[newCam]);
    selectedCameraInt = newCam;
  }
}
