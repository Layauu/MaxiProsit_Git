import 'dart:io' as io;
import 'package:file_picker/file_picker.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';

class CreatePDFfile {
  final pw.Document _pdf;
  final String _fileName;

  CreatePDFfile(this._pdf, this._fileName);

  void create() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    String? path = await FilePicker.platform.getDirectoryPath();
    if (path == null) {
      return;
    }
    final file = io.File("$path/$_fileName.pdf");
    await file.writeAsBytes(await _pdf.save());
  }
}
