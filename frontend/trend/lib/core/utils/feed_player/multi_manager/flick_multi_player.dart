// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../widgets/logo_loader.dart';
import '../player_controls.dart';
import './flick_multi_manager.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class FlickMultiPlayer extends StatefulWidget {
  const FlickMultiPlayer(
      {Key? key,
      required this.url,
      required this.isReal,
      this.image,
      required this.flickMultiManager})
      : super(key: key);

  final String url;
  final String? image;
  final FlickMultiManager flickMultiManager;
  final bool isReal;

  @override
  State<FlickMultiPlayer> createState() => _FlickMultiPlayerState();
}

class _FlickMultiPlayerState extends State<FlickMultiPlayer> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(widget.url)
        ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager.play(flickManager);
        }
      },
      child: FlickVideoPlayer(
        flickManager: flickManager,
        flickVideoWithControls: FlickVideoWithControls(
          playerLoadingFallback: Positioned.fill(
            child: Stack(
              children: [
                Container(
                    color: Colors.black,
                    child: CachedNetworkImage(
                      imageUrl: widget.image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )),
                Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Transform.scale(
                      scale: .2.sp,
                      child: LogoLoader(
                        size: 20.sp,
                      ),
                    )),
              ],
            ),
          ),
          controls: const PlayerControls(),
        ),
        flickVideoWithControlsFullscreen: FlickVideoWithControls(
          playerLoadingFallback: Center(
              child: Container(
                  color: Colors.black,
                  child: CachedNetworkImage(
                    imageUrl: widget.image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ))),
          controls: const FlickLandscapeControls(),
          iconThemeData: IconThemeData(
            size: 40.sp,
            color: Colors.white,
          ),
          textStyle: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }
}
