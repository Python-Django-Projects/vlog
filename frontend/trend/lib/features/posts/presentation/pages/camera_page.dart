import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trend/config/routes/app_routes.dart';
import '../widgets/camera_page/camera_image_video_widget.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  @override
  Widget build(BuildContext context) {
    return CameraImageVideoWidget(
      onTaken: (data) {
        if (data['files'] != null && data['files']!.isNotEmpty) {
          context.go(Routes.takenMediaPreview,
              extra: {"files": (data['files']), "mediaType": data['type']});
        }
      },
    );
  }
}
