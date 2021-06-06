
import 'package:file_support/dependency/fileutils.dart';
import 'package:flutter/services.dart';

import 'dependency/image.dart';

class FileSupport with ImageOperations, FileUtils {
  static const MethodChannel _channel = const MethodChannel('file_support');

/*
  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
*/

}
