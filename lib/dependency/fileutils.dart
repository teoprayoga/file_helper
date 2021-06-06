import 'dart:io';

import 'package:logger/logger.dart';
import 'package:mime_type/mime_type.dart';
import '../utils/utils.dart';

mixin FileUtils {
  /// its help to get file category like image zip etc
  static getImageType(File? file) {
    if (file == null) {
      "File can'nt be null".printerror;
    }
    String? mimeType = mime(file!.absolute.path);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    "MIME TYPE ${mimeType}  , ${mimee}, ${type} ".printinfo;
    return type;
  }
}
