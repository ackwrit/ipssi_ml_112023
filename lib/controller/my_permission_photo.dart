import 'package:permission_handler/permission_handler.dart';

class PermissionPhoto {
  init() async {
    PermissionStatus status = await Permission.photos.status;
    checkPermission(status);
  }

  checkPermission(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.permanentlyDenied:
        Future.error("Toujours refusé");
      case PermissionStatus.denied:
        Permission.photos.request().then((value) => checkPermission(value));
      case PermissionStatus.limited:
        Permission.photos.request().then((value) => checkPermission(value));
      case PermissionStatus.provisional:
        Permission.photos.request().then((value) => checkPermission(value));
      case PermissionStatus.restricted:
        Permission.photos.request().then((value) => checkPermission(value));
      case PermissionStatus.granted:
        Permission.photos.request().then((value) => checkPermission(value));
    }
  }
}
