import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
//import 'package:universal_html/html.dart';
import 'package:get/get.dart';

class CreatePDFfile {
  final pw.Document _pdf;
  final String _fileName;

  CreatePDFfile(this._pdf, this._fileName);

  void create() async {
    print(requestFilePermission().toString());
    print("Using notweb");
    var status = await Permission.camera.status;
    print(status);
    if (!await Permission.contacts.request().isGranted) return;
    if (!status.isGranted) {
      await Permission.camera.request();
      print("asked");
    }
    if (await Permission.storage.isPermanentlyDenied) {
      // The user opted to never again see the permission request dialog for this
      // app. The only way to change the permission's status now is to let the
      // user manually enable it in the system settings.
      openAppSettings();
    }
    String? path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }
    print(path);
    final file = io.File("$path/$_fileName.pdf");
    await file.writeAsBytes(await _pdf.save());
  }
}

Future<bool> requestFilePermission() async {
  PermissionStatus result;
  // In Android we need to request the storage permission,
  // while in iOS is the photos permission
  if (GetPlatform.isAndroid) {
    result = await Permission.storage.request();
  } else {
    result = await Permission.photos.request();
  }

  if (result.isGranted) {
    //imageSection = ImageSection.browseFiles;
    return true;
  } else if (GetPlatform.isIOS || result.isPermanentlyDenied) {
    //imageSection = ImageSection.noStoragePermissionPermanent;
  } else {
    //imageSection = ImageSection.noStoragePermission;
  }
  return false;
}
