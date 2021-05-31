import 'dart:io';

import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';

class FileDetails extends StatefulWidget {
  late File file;

  FileDetails(File file, {Key? key}) {
    this.file = file;
  }

  @override
  _FileDetailsState createState() => _FileDetailsState();
}

class _FileDetailsState extends State<FileDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //setupFileData(widget. file);
    performBase64Test();
    FileSupport().getMultiPartFromFile(widget.file);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Text("Name of file = ${FileSupport().getFileName(widget.file)}"),
          SizedBox(
            height: 50,
          ),
          Text(
              "File name without Extension = ${FileSupport().getFileNameWithoutExtension(widget.file)}"),
          SizedBox(
            height: 50,
          ),
          Text("File base64 = ${FileSupport().getBase64FromFile(widget.file)}"),
          SizedBox(
            height: 50,
          ),
          Text("File Size = ${FileSupport().getFileSize(file: widget.file)}"),
        ],
      ),
    );
  }

  void setupFileData(File file) {
    FileSupport().getFileName(file);
  }

  void performBase64Test() async {
    String? string = await FileSupport().getBase64FromFile(widget.file);
    print(string);

    File? file = await FileSupport().getFileFromBase64(
        base64string: string!, name: "test", extension: "jpg");

    print(file!.path);
  }
}
