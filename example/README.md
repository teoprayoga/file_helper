# File Support 

File support is plugin that allow you to perform file handling operations. Like convert file to multipart.Perform file related activities.

- Get file name from file.
- Convert file to multipart file
- Create random file for testing puroses.
- Create random image for flutter.
- Get file extension from file.

**Get Multipart for Dio**
Speciallity is that no need to define mime.It simply return any file to multipart to sent multipart object on dio request
```dart
await getMultiPartFromFile(File file) ;
```
###### return object is Multipart Object


------------


**Get File Name Without Extension.**
It return name of file without extension.
```dart
 getFileNameWithoutExtension(File file) ;
```
###### return object is String.

------------

**Get File Name With Extension.**
It return name of file with extension.
```dart
  getFileName(File file)
```
###### return object is String.

------------


**Get Base64 for any file.(Future)**
It used to convert any file to base64 format just sent file object in paramter.

```dart
 getBase64FromFile(File file)  ;
```
###### return object is future String.

------------

**Get File from any Base64**
This method return file from base64  just pass mention parameter.Extension is required to tell in order to decode.
```dart
 getFileFromBase64(
     {required String base64string,
      required String name,
      required String extension})
```
###### return object is Future File

------------


**Get Multipart for http module**

```dart
  getHttpMutipartFile({required String field, required File file})
```
###### return object is Future http.MultipartFile

------------

### Features and bugs
Please file feature requests and bugs at the[ issue tracker](https://github.com/parmeetmaster/file_support/issueshttp:// " issue tracker").
# Editor.md

![](https://pandao.github.io/editor.md/images/logos/editormd-logo-180x180.png)

![](https://img.shields.io/github/issues/parmeetmaster/file_support) ![](	https://img.shields.io/github/forks/parmeetmaster/file_support) ![](	https://img.shields.io/github/stars/parmeetmaster/file_support) ![](https://img.shields.io/github/license/parmeetmaster/file_support) 

