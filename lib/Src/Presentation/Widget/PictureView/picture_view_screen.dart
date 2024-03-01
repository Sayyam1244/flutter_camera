import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';

class PictureViewScreen extends StatefulWidget {
  const PictureViewScreen({super.key, required this.image});
  final File image;
  @override
  State<PictureViewScreen> createState() => _PictureViewScreenState();
}

class _PictureViewScreenState extends State<PictureViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor.withOpacity(0.2),
      ),
      body: AspectRatio(
        aspectRatio: MediaQuery.sizeOf(context).aspectRatio,

        child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Image.file(widget.image)),
      ),
    );
  }
}
