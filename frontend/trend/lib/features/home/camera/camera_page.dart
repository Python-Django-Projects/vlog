import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:trend/features/home/camera/taken_image_preview_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  List<CameraDescription>? cameras;
  CameraController? cameraController;
  bool isInitialized = false;
  bool _isLoading = false;

  int direction = 0;

  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }

  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras![direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        isInitialized = true;
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      child: Scaffold(
        body: !isInitialized
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Positioned.fill(child: CameraPreview(cameraController!)),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        direction = direction == 0 ? 1 : 0;
                        startCamera(direction);
                      });
                    },
                    child: button(
                        Icons.flip_camera_ios_outlined, Alignment.bottomLeft),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isLoading = true;
                      });
                      cameraController!.takePicture().then((XFile? file) {
                        setState(() {
                          _isLoading = false;
                        });
                        if (mounted) {
                          if (file != null) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) =>
                                    TakenImagePreviewPage(file: file)));
                          }
                        }
                      });
                    },
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(
                          bottom: 20,
                        ),
                        height: 60,
                        width: 60,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(2, 2),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  if (_isLoading)
                    Positioned(
                        bottom: 0,
                        top: 0,
                        right: 50,
                        left: 50,
                        child: Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 30, horizontal: 16),
                            child: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                        )),
                ],
              ),
      ),
    );
  }

  Widget button(IconData icon, Alignment alignment) {
    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black26,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
