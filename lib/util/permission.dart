import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static bool is_camera_enable = false;
  static bool is_location_enable = false;

  initialisationPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.camera,
    ].request();

    is_camera_enable = statuses[Permission.camera]!.isGranted;
    is_location_enable = statuses[Permission.location]!.isGranted;
  }

  bool isCameraEnable() {
    return is_camera_enable;
  }

  bool isLocationEnable() {
    return is_camera_enable;
  }
}
