import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

import './multi_manager/flick_multi_manager.dart';
import './multi_manager/flick_multi_player.dart';

class FeedPlayer extends StatefulWidget {
  final String videoUrl;
  final String thumbnailUrl;
  final bool isReal ;
  const FeedPlayer({
    Key? key,
    required this.videoUrl,
    required this.thumbnailUrl,
     this.isReal = false,
  }) : super(key: key);

  @override
  State<FeedPlayer> createState() => _FeedPlayerState();
}

class _FeedPlayerState extends State<FeedPlayer> {
  late FlickMultiManager flickMultiManager;

  @override
  void initState() {
    super.initState();
    flickMultiManager = FlickMultiManager();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickMultiManager),
      onVisibilityChanged: (visibility) {
        if (visibility.visibleFraction == 0 && mounted) {
          flickMultiManager.pause();
        }
      },
      child: FlickMultiPlayer(
        url: widget.videoUrl,
        flickMultiManager: flickMultiManager,
        image: widget.thumbnailUrl,
        isReal: widget.isReal
      ),
    );
  }
}
