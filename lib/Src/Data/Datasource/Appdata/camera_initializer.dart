import 'package:camera/camera.dart';

mixin CameraInitializer {
  late List<CameraDescription> cameras;
  getCameras() async {
    cameras = await availableCameras();
  }
}
