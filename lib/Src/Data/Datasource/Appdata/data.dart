import 'package:flutter_camera/Src/Data/Datasource/Appdata/camera_initializer.dart';

class Data with CameraInitializer {
  Data._();
  static final Data _data = Data._();
  factory Data() => _data;

  init() {
    super.getCameras();
  }
}
