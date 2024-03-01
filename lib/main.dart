import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Appdata/Data.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';
import 'package:flutter_camera/Src/Presentation/Widget/Camera/camera_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Data().getCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.redColor),
        useMaterial3: true,
      ),
      home: const CameraScreen(),
    );
  }
}
