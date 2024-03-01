import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_camera/Src/Data/Datasource/Resources/app_colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key, required this.video});
  final File video;
  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video)
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.addListener(() {
      isPlaying = _controller.value.isPlaying;
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context).aspectRatio;
    // _controller.addListener(() { })
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: AppColors.blackColor.withOpacity(0.2),
      ),
      body: Center(
        child: _controller.value.isInitialized
            ? AspectRatio(
                aspectRatio: size,
                child: VideoPlayer(_controller),
              )
            : Container(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.redColor,

        onPressed: () {
          setState(() {
            isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(

          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
