import 'package:flutter/material.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../widgets/logo_loader.dart';

class PlayerControls extends StatelessWidget {
  const PlayerControls(
      {Key? key, this.iconSize, this.fontSize, this.progressBarSettings})
      : super(key: key);

  final double? iconSize;

  /// Font size.
  ///
  /// This size is used for all the text.
  final double? fontSize;

  /// [FlickProgressBarSettings] settings.
  final FlickProgressBarSettings? progressBarSettings;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(14.sp),
          child: FlickAutoHideChild(
            autoHide:
                !GoRouterState.of(context).uri.toString().startsWith("/vlog"),
            showIfVideoNotInitialized: false,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 5.sp),
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(20.sp),
                ),
                child: const FlickLeftDuration(),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickShowControlsAction(
            child: FlickSeekVideoAction(
              child: Center(
                child: FlickVideoBuffer(
                  bufferingChild: Transform.scale(
                    scale: .5,
                    child: LogoLoader(
                      size: 20.sp,
                    ),
                  ),
                  child: FlickAutoHideChild(
                    showIfVideoNotInitialized: false,
                    child: FlickPlayToggle(
                      size: 30.sp,
                      color: Colors.black,
                      padding: EdgeInsets.all(12.sp),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(40.sp),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: FlickAutoHideChild(
            autoHide:
                !GoRouterState.of(context).uri.toString().startsWith("/vlog"),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlickVideoProgressBar(
                    flickProgressBarSettings: progressBarSettings,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlickPlayToggle(
                        size: iconSize ?? 20.sp,
                      ),
                      SizedBox(
                        width: (iconSize ?? 20.sp) / 2,
                      ),
                      FlickSoundToggle(
                        size: (iconSize ?? 20.sp),
                      ),
                      SizedBox(
                        width: (iconSize ?? 20.sp) / 2,
                      ),
                      Row(
                        children: <Widget>[
                          FlickCurrentPosition(
                            fontSize: fontSize ?? 12.sp,
                          ),
                          FlickAutoHideChild(
                            child: Text(
                              ' / ',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: fontSize ?? 12.sp),
                            ),
                          ),
                          FlickTotalDuration(
                            fontSize: fontSize ?? 12.sp,
                          ),
                        ],
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      FlickSubtitleToggle(
                        size: iconSize ?? 20.sp,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
