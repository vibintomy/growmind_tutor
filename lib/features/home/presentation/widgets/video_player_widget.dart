import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController controller;
  ChewieController? chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {
          chewieController = ChewieController(
              videoPlayerController: controller,
              autoPlay: false,
              looping: false);
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? Chewie(controller: chewieController!)
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  @override
  void dispose() {
    controller.dispose();
    chewieController?.dispose();
    // TODO: implement dispose
    super.dispose();
  }
}
