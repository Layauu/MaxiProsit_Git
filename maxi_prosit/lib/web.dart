// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;

class CreatePDFfile {
  final pw.Document _pdf;
  final String _fileName;

  CreatePDFfile(this._pdf, this._fileName);

  void create() async {
    Uint8List bytes = await _pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }
}
