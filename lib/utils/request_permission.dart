import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<bool> checkAndRequestStoragePermission() async {
  AndroidDeviceInfo info = await DeviceInfoPlugin().androidInfo;

  if (info.version.sdkInt >= 30) {
    if ((await Permission.manageExternalStorage.request()).isGranted) {
      return true;
    } else {
      return false;
    }
  } else {
    if (await Permission.storage.request().isGranted) {
      return true;
    } else {
      var status = await Permission.storage.request();

      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
