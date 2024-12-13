import 'package:permission_handler/permission_handler.dart';

Future<bool> getLocationPermission() async {
  bool hasPermission = false;

  if (await Permission.location.serviceStatus.isEnabled) {
    var status = await Permission.location.status;
    hasPermission = status.isGranted;
    if (!hasPermission) {
      await Permission.location.request().then((value) {
        hasPermission = value == PermissionStatus.granted;
      });
    }
  }

  return hasPermission;
}
