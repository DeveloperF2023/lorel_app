import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  if (await Permission.storage.isGranted) {
    return true;
  }

  if (await Permission.manageExternalStorage.request().isGranted) {
    return true;
  }

  if (await Permission.storage.request().isGranted) {
    return true;
  }

  return false;
}
