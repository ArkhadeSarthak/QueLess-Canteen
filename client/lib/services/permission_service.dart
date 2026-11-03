import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestCameraPermission() async {
    PermissionStatus status = await Permission.camera.request();

    return status.isGranted;
  }

  static Future<bool> requestGalleryPermission() async {
    PermissionStatus status = await Permission.photos.request();

    return status.isGranted || status.isLimited;
  }

  static Future<bool> requestLocationPermission() async {
    PermissionStatus status = await Permission.locationWhenInUse.request();

    return status.isGranted;
  }

  static Future<void> requestAllPermissions() async {
    await requestCameraPermission();
    await requestGalleryPermission();
    await requestLocationPermission();
  }

  Future<bool> checkCameraPermission() async {
    return await Permission.camera.isGranted;
  }

  Future<bool> checkGalleryPermission() async {
    PermissionStatus status = await Permission.photos.status;

    return status.isGranted || status.isLimited;
  }

  Future<bool> checkLocationPermission() async {
    return await Permission.locationWhenInUse.isGranted;
  }
}
