import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'dart:ui';
import 'dart:ui' as ui;

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
        contentType:
            http.MediaType.parse("image/${file.path.split(".").last}"));
    return pic;
  }

  String? getFileName(File file) {
    return file.path.split('/').last;
  }

  String? getFileNameWithoutExtension(File file) {
    return file.path.split("/").last;
  }

  Future<String?> getBase64FromFile(File file) async {
    Uint8List imageBytes = await file.readAsBytes();
    debugPrint(base64Encode(imageBytes));
    String base64String = base64Encode(imageBytes);
    return base64String;
  }

  Future<File?> getFileFromBase64(
      {required String base64string,
      required String name,
      required String extension}) async {
    final decodedBytes = base64Decode(base64string);
    Directory tempdirectory = await getTemporaryDirectory();

    File file = File("${tempdirectory.path}/${name}.${extension}");
    file.writeAsBytes(decodedBytes);
    return file;
  }

  // get file size
  String? getFileSize({required File file}) {
    print(file.lengthSync());
    return "${FileSize().getSize(file.lengthSync())}";
  }

  void generateImage() async {
    final Random rd = new Random();
    double kCanvasSize=500;
    final color = Colors.primaries[rd.nextInt(Colors.primaries.length)];

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder,
        Rect.fromPoints(Offset(0.0, 0.0), Offset(kCanvasSize, kCanvasSize)));

    final stroke = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Rect.fromLTWH(0.0, 0.0, kCanvasSize, kCanvasSize), stroke);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(
        Offset(
          rd.nextDouble() * kCanvasSize * 0.5,
          rd.nextDouble() * kCanvasSize * 0.5,
        ),
        70.0,
        paint);

    final picture = recorder.endRecording();
    final img = await picture.toImage(200, 200);
    final pngBytes = await img.toByteData(format: ImageByteFormat.png);
  /*  setState(() {
      imgBytes = pngBytes!;
    });*/
  }

  //todo https://www.google.com/search?q=create+file+from+byte+data+dart&sxsrf=ALeKk00bUDfyUeaQ2mwlk1PFpJiPrWMTSg%3A1622358697007&ei=qDqzYLuHPIvbz7sPpoew2Ac&oq=create+file+from+byte+data+dart&gs_lcp=Cgdnd3Mtd2l6EAMyCAghEBYQHRAeOgcIIxCwAxAnOgcIABBHELADOgUIIRCgAVCJDVj-GWDwGmgCcAJ4AIAB2AKIAe8JkgEHMC4yLjIuMZgBAKABAaoBB2d3cy13aXrIAQnAAQE&sclient=gws-wiz&ved=0ahUKEwi7-9OO7fDwAhWL7XMBHaYDDHsQ4dUDCA4&uact=5
  Future<File> writeFiletoTemporaryDirectory(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
