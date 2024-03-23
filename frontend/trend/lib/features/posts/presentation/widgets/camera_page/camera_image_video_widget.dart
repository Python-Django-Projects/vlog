// ignore_for_file: unused_field

import 'dart:async';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:trend/config/locale/app_localizations.dart';
import 'package:trend/core/utils/media_picker_utils.dart';
import 'package:trend/features/posts/presentation/widgets/camera_page/timer_widget.dart';
import '../../../../../core/resources/values_manager.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../../../data/models/post_media_type_enum.dart';

class CameraImageVideoWidget extends StatefulWidget {
  final Function(Map) onTaken;
  final bool isSingle;
  final bool allowRecording;

  const CameraImageVideoWidget({
    super.key,
    required this.onTaken,
    this.isSingle = false,
    this.allowRecording = true,
  });

  @override
  State<CameraImageVideoWidget> createState() => _CameraImageVideoWidgetState();
}

class _CameraImageVideoWidgetState extends State<CameraImageVideoWidget> {
  List<CameraDescription>? cameras;
  late CameraController _cameraController;
  Future<void>? _cameraValue;
  bool isInitialized = false;
  bool _isLoading = false;
  int direction = 0;
  bool isFlashOn = false;
  bool isCameraFront = true;
  bool isRecording = false;
  Timer? _timer;
  double _minAvailableZoom = 1.0;
  double _maxAvailableZoom = 1.0;
  double _currentZoomLevel = 1.0;
  String cameraType = "Photo".hardcoded;

  void startCamera(int direction) async {
    cameras = await availableCameras();

    _cameraController =
        CameraController(cameras![direction], ResolutionPreset.veryHigh);
    _cameraValue = _cameraController.initialize().then((_) async {
      setState(() {
        _cameraController.setFlashMode(FlashMode.off);
        _cameraController.setExposureMode(ExposureMode.auto);
        _cameraController.setExposurePoint(const Offset(0.5, 0.5));
        _cameraController.setFocusMode(FocusMode.auto);
        _cameraController.setFocusPoint(const Offset(0.5, 0.5));
        _cameraController.setExposureOffset(0.0);
        _cameraController
            .getMaxZoomLevel()
            .then((value) => _maxAvailableZoom = value);

        _cameraController
            .getMinZoomLevel()
            .then((value) => _minAvailableZoom = value);
      });
    });
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    startCamera(direction);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  _buildCamera(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 12.sp, vertical: 25.sp),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildZoom(),
                          _currentMediaText(),
                          SizedBox(height: 8.sp),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _galleryImage(),
                              GestureDetector(
                                onTap: () {
                                  if (!isRecording) takePhoto(context);
                                },
                                onLongPress: !widget.allowRecording
                                    ? () {}
                                    : () async {
                                        if (!widget.isSingle) {
                                          try {
                                            await _cameraController
                                                .startVideoRecording();
                                            setState(() {
                                              isRecording = true;
                                              cameraType = "Video".hardcoded;
                                            });
                                            _timer = Timer(
                                                const Duration(
                                                    seconds: AppConstants
                                                        .videoLength),
                                                () async {
                                              if (isRecording) {
                                                if (mounted) {
                                                  setState(() {
                                                    _isLoading = true;
                                                    cameraType =
                                                        "Video".hardcoded;
                                                  });
                                                }
                                                XFile videoPath =
                                                    await _cameraController
                                                        .stopVideoRecording();
                                                setState(() {
                                                  isRecording = false;
                                                  cameraType =
                                                      "Photo".hardcoded;
                                                  _isLoading = false;
                                                });
                                                if (!mounted) return;
                                                widget.onTaken({
                                                  "files": [
                                                    File(videoPath.path)
                                                  ],
                                                  "type": PostMediaType.video
                                                });
                                              }
                                            });
                                          } catch (_) {}
                                        }
                                      },
                                onLongPressUp: !widget.allowRecording
                                    ? () {}
                                    : () async {
                                        if (!widget.isSingle) {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          XFile videoPath =
                                              await _cameraController
                                                  .stopVideoRecording();
                                          setState(() {
                                            isRecording = false;
                                            _isLoading = false;
                                            cameraType = "Photo".hardcoded;
                                          });
                                          if (!mounted) return;
                                          widget.onTaken({
                                            "files": [File(videoPath.path)],
                                            "type": PostMediaType.video
                                          });
                                        }
                                      },
                                child: cameraIcon(),
                              ),
                              _toggleCamera(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  _buildFlashToggle(),
                  if (_isLoading) _buildLoading(),
                  if (isRecording) _buildRecordingTimer()
                ],
              ),
            ),
            // const Padding(
            //   padding: EdgeInsets.only(top: 8, bottom: 8),
            //   child: Text(
            //     'Hold for video, tap for photo',
            //     style: TextStyle(fontSize: 16),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  GestureDetector _toggleCamera() {
    return GestureDetector(
      onTap: toggleCameraFront,
      child: CircleAvatar(
        radius: 30.sp,
        backgroundColor: Colors.white12,
        child: Icon(
          Icons.flip_camera_ios,
          color: Colors.white,
          size: 30.sp,
        ),
      ),
    );
  }

  GestureDetector _galleryImage() {
    return GestureDetector(
      onTap: () {
        if (widget.isSingle) {
          getOneImageFromGallery();
        } else {
          getImageFromGallery();
        }
      },
      child: CircleAvatar(
        radius: 30.sp,
        backgroundColor: Colors.white12,
        child: Icon(
          Icons.photo,
          color: Colors.white,
          size: 30.sp,
        ),
      ),
    );
  }

  Center _currentMediaText() {
    return Center(
      child: Text(
        cameraType,
        style: TextStyle(
            fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Row _buildZoom() {
    return Row(
      children: [
        Expanded(
          child: Slider(
            value: _currentZoomLevel,
            min: _minAvailableZoom,
            max: _maxAvailableZoom,
            activeColor: Colors.white,
            inactiveColor: Colors.white30,
            onChanged: (value) async {
              setState(() {
                _currentZoomLevel = value;
              });
              await _cameraController.setZoomLevel(value);
            },
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(5.sp),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3.sp, horizontal: 8.sp),
            child: Text(
              '${_currentZoomLevel.toStringAsFixed(1)}x',
              style: TextStyle(color: Colors.white, fontSize: 12.5.sp),
            ),
          ),
        ),
      ],
    );
  }

  Align _buildFlashToggle() {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(start: 10.sp, end: 10.sp, top: 12.sp),
        child: GestureDetector(
          onTap: toggleFlash,
          child: CircleAvatar(
            radius: 20.sp,
            backgroundColor: Colors.white12,
            child: Icon(
              isFlashOn ? Icons.flash_on : Icons.flash_off,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Positioned _buildLoading() {
    return Positioned(
        bottom: 0,
        top: 0,
        right: 50.sp,
        left: 50.sp,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.sp),
          ),
          child: Container(
            padding: EdgeInsets.all(16.sp),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LoadingWidget(
                  height: 50.sp,
                )
              ],
            ),
          ),
        ));
  }

  Align _buildRecordingTimer() {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: EdgeInsets.only(top: 16.sp),
        child: const TimerWidget(
            duration: Duration(seconds: AppConstants.videoLength)),
      ),
    );
  }

  FutureBuilder<void> _buildCamera() {
    return FutureBuilder(
      future: _cameraValue,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GestureDetector(
            child: SizedBox(
              width: _cameraController.value.previewSize!.height,
              height: _cameraController.value.previewSize!.width,
              child: CameraPreview(_cameraController),
            ),
          );
        } else {
          return const LoadingWidget();
        }
      },
    );
  }

  Icon cameraIcon() {
    return isRecording
        ? Icon(
            Icons.radio_button_on,
            color: Colors.red,
            size: 80.sp,
          )
        : Icon(
            Icons.panorama_fish_eye,
            size: 80.sp,
            color: Colors.white,
          );
  }

  void toggleFlash() {
    setState(() {
      isFlashOn = !isFlashOn;
    });
    isFlashOn
        ? _cameraController.setFlashMode(FlashMode.torch)
        : _cameraController.setFlashMode(FlashMode.off);
  }

  void toggleCameraFront() {
    setState(() {
      isCameraFront = !isCameraFront;
    });
    int cameraPos = isCameraFront ? 0 : 1;
    _cameraController =
        CameraController(cameras![cameraPos], ResolutionPreset.high);
    _cameraValue = _cameraController.initialize();
  }

  void takePhoto(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    XFile file = await _cameraController.takePicture();
    if (!mounted) return;
    widget.onTaken({
      "files": [File(file.path)],
      "type": PostMediaType.image
    });
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getImageFromGallery() async {
    List<XFile>? pickedFiles =
        await MediaPickerUtils().pickMultiImages(context);

    if (pickedFiles != null) {
      widget.onTaken({
        "files": pickedFiles.map((xfile) => File(xfile.path)).toList(),
        "type": PostMediaType.image
      });
    }
  }

  Future<void> getOneImageFromGallery() async {
    final pickedFile = await MediaPickerUtils().pickImage(context);

    if (pickedFile != null) {
      widget.onTaken({
        "files": [File(pickedFile.path)],
        "type": PostMediaType.image
      });
    }
  }
}
