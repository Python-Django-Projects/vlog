// ignore_for_file: use_build_context_synchronously
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:trend/config/locale/app_localizations.dart';

class MediaPickerUtils {
  factory MediaPickerUtils() {
    return _instance;
  }
  const MediaPickerUtils._();

  static const MediaPickerUtils _instance = MediaPickerUtils._();

  Future<XFile?> pickImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (image != null) {
        return XFile(image.path);
      }
      return null;
    } catch (e) {
      debugPrint('Exception ==> $e');
      await _checkPermission(context, e);
    }
    return null;
  }

  Future<List<XFile>?> pickMultiImages(BuildContext context) async {
    try {
      final picker = ImagePicker();
      List<XFile>? pickedFiles = await picker.pickMultiImage(
        maxWidth: 1920,
        maxHeight: 1200,
        imageQuality: 80,
      );

      if (pickedFiles.isNotEmpty) {
        if (pickedFiles.length <= 20) {
          return pickedFiles;
        } else {
          await showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("To many images selected".hardcoded),
                content:
                    Text("Please do not select more than 20 images".hardcoded),
                actions: [
                  TextButton(
                    child: Text("Ok".hardcoded),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      debugPrint('Exception ==> $e');
      await _checkPermission(context, e);
    }
    return null;
  }

  Future<void> _showAlertPermissionsDialog(BuildContext context) {
    return showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Permissions Denied'.hardcoded),
          content: Text('Allow access to gallery and photos'.hardcoded),
          actions: <CupertinoDialogAction>[
            CupertinoDialogAction(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'.hardcoded),
            ),
            CupertinoDialogAction(
              isDefaultAction: true,
              onPressed: openAppSettings,
              child: Text('Settings'.hardcoded),
            ),
          ],
        );
      },
    );
  }

  Future<void> _checkPermission(BuildContext context, Object e) async {
    if (Platform.isIOS) {
      final permissionStatus = (await Permission.photos.status);

      if (permissionStatus.isDenied) {
        // show dialog
        await _showAlertPermissionsDialog(context);
      } else {
        debugPrint('Image Exception ==> $e');
      }
    }
  }
}
