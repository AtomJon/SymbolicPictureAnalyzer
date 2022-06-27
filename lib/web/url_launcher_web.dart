import 'dart:async';
import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import '../channel_const.dart';


class UrlLauncherPlugin {
  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      SaveScreenshotPlugin.channel,
      const StandardMethodCodec(),
      registrar, // the registrar is used as the BinaryMessenger
    );
    final UrlLauncherPlugin instance = UrlLauncherPlugin();
    channel.setMethodCallHandler(instance.handleMethodCall);
  }

  Future<dynamic> handleMethodCall(MethodCall call) async {
        final Uint8List byteData = call.arguments as Uint8List;
    
    switch (call.method) {
      case SaveScreenshotPlugin.method:
        await saveData(byteData);
        break;
      default:
    }
  }
  
  Future<void> saveData(Uint8List byteData) async {
    final content = base64Encode(byteData);
    AnchorElement(
        href: 'data:application/octet-stream;charset=utf-16le;base64,$content')
      ..setAttribute('download', 'billede.png')
      ..click();
  }
}
