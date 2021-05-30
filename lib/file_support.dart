import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart' as http;

class FileSupport {
  static const MethodChannel _channel = const MethodChannel('file_support');

/*
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
*/

  Future<MultipartFile>? getMultiPartFromFile(File file) async {
    var pic = await MultipartFile.fromFile(file.path,
        filename: file.path.split("/").last,
        contentType: http.MediaType.parse("image/${file.path.split(".").last}"));
    return pic;
  }

  String? getFileName(File file) {
    return file.path.split('/').last;
  }

  String? getFileNameWithoutExtension(File file) {
    return file.path.split("/").last;
  }

  Future<String?> getBase64FromFile(File file) async{
    Uint8List imageBytes = await file.readAsBytes();
    debugPrint(base64Encode(imageBytes));
    String base64String = base64Encode(imageBytes);
    return base64String;
  }


}
