import 'dart:async';

import 'dart:io';
import 'dart:ui';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../channel_const.dart';

class ImageSaver {
  ImageSaver({required this.image});
  
  static const platform = MethodChannel(SaveScreenshotPlugin.channel);
  
  final Image image;
  
  Future<void> save(Image image) async {         
    final ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
    if (byteData == null) return;
    
    if (_isOnWeb()) {
      // Platform is web
      saveWeb(byteData);
    }
    else if (Platform.isLinux || Platform.isMacOS || Platform.isWindows) {
      // Platforms is desktop
      saveDesktop(byteData);
    }
    else {
      throw Exception('Platform is not supported');
    }
  }
  
  bool _isOnWeb() {
    try {
      return kIsWeb;
    } catch (e) {
      return true;
    }
  }

  void saveWeb(ByteData byteData) {
    platform.invokeMethod(SaveScreenshotPlugin.method, byteData.buffer.asUint8List());
  }
  
  Future<void> saveDesktop(ByteData byteData) async {
    final filePath = await promptPngPath();
    if (filePath == null) return;
    
    await File(filePath)
      .writeAsBytes(
        byteData.buffer.asUint8List(),
        flush: true,
      );
  }
  
  Future<String?> promptPngPath() async {
    return FilePicker.platform.saveFile(
      fileName: 'billede.png',
      allowedExtensions: ['png'],
      type: FileType.image
    );
  }  
}
