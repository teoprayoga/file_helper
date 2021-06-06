import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:dio/dio.dart';
import 'package:file_support/dependency/fileutils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http_parser/http_parser.dart' as httparser;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui';
import 'dart:ui' as ui;

import 'dependency/filesize.dart';
import 'dependency/image.dart';

class FileSupport with ImageOperations, FileUtils {
  static const MethodChannel _channel = const MethodChannel('file_support');

/*
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
*/

  /// its used to get multipart file from any extension.
  Future<MultipartFile>? getMultiPartFromFile(File file) async {
    String? mimeType = mime(file.absolute.path);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    print("MIME TYPE ${mimeType}  , ${mimee}, ${type} ");
    var pic = await MultipartFile.fromFile(file.path,
        filename: file.path.split("/").last,
        contentType: MediaType(mimee, type));
    return pic;
  }

  /// This method user to get http multipart request file
  Future<http.MultipartFile>? getHttpMutipartFile(
      {required String field, required File file}) async {
    String? mimeType = mime(file.absolute.path);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    print("MIME TYPE ${mimeType}  , ${mimee}, ${type} ");

    var pic = http.MultipartFile.fromBytes('picture', file.readAsBytesSync(),
        filename: file.path.split("/").last,
        contentType: httparser.MediaType(mimee, type));
    return pic;
  }

  /// This function is used for get file name with extension
  String? getFileName(File file) {
    return file.path.split('/').last;
  }

  /// this function is used to get file name without extension
  String? getFileNameWithoutExtension(File file) {
    return file.path.split("/").last;
  }

  /// this function is used to convert any file to base 64 string
  Future<String?> getBase64FromFile(File file) async {
    Uint8List imageBytes = await file.readAsBytes();
    debugPrint(base64Encode(imageBytes));
    String base64String = base64Encode(imageBytes);
    return base64String;
  }

  /// this function convert base64 to file with 3 inputs base64 string , name for comming file, and extension
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

  /// this function return size of any file in flutter
  String? getFileSize({required File file}) {
    print(file.lengthSync());
    return "${FileSize().getSize(file.lengthSync())}";
  }

  ///todo https://www.google.com/search?q=create+file+from+byte+data+dart&sxsrf=ALeKk00bUDfyUeaQ2mwlk1PFpJiPrWMTSg%3A1622358697007&ei=qDqzYLuHPIvbz7sPpoew2Ac&oq=create+file+from+byte+data+dart&gs_lcp=Cgdnd3Mtd2l6EAMyCAghEBYQHRAeOgcIIxCwAxAnOgcIABBHELADOgUIIRCgAVCJDVj-GWDwGmgCcAJ4AIAB2AKIAe8JkgEHMC4yLjIuMZgBAKABAaoBB2d3cy13aXrIAQnAAQE&sclient=gws-wiz&ved=0ahUKEwi7-9OO7fDwAhWL7XMBHaYDDHsQ4dUDCA4&uact=5
  Future<File> writeFiletoTemporaryDirectory(ByteData data) async {
    final buffer = data.buffer;
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    var filePath =
        tempPath + '/file_01.tmp'; // file_01.tmp is dump file, can be anything
    return new File(filePath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
/// pending add on git
  /// get Image type via category like image zip etc

}
