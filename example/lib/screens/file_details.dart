


import 'dart:io';

import 'package:file_support/file_support.dart';
import 'package:flutter/material.dart';

class FileDetails extends StatefulWidget {
 late File file;
   FileDetails(File file,{Key? key}){
     this.file=file;
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


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        SizedBox(height: 50,),
          Text("Name of file = ${FileSupport().getFileName(widget.file)}"),
        SizedBox(height: 50,),
        Text("File name without Extension = ${FileSupport().getFileNameWithoutExtension(widget.file)}"),
        SizedBox(height: 50,),
        Text("File base64 = ${FileSupport().getBase64FromFile(widget.file)}"),
      ],),
    );
  }

  void setupFileData(File file) {
    FileSupport().getFileName(file);


  }
}
