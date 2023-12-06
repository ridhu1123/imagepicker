import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homescreen(),
    );
  }
}

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String image = "";
  File? _image;
  String _image1 = "";
  // Directory? directory;

  Future getImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image1 = pickedFile.path;
        _image = File(pickedFile.path);
        print(json.encode(_image1));
        print("file path...");
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String image = "";
    return Scaffold(
      appBar: AppBar(
        title: Text("IMAGE PICKER"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          image.isEmpty ? Container() : Image.file(File(image)),
          ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.request();
                if (status == PermissionStatus.granted) {
                  getImage();
                }

                //   var status = await Permission.storage.request();
                //   var image =
                //       await ImagePicker().pickImage(source: ImageSource.gallery);
                //   if (image != null) {
                //     setState(() {
                //       this.image = image.path;
                //     });
                //   } else {
                //     print("no image selected");
              },
              child: Text(
                "PICK AN IMAGE",
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 10,
          ),
          Flexible(
              child: _image != null
                  ? Image.file(_image!)
                  : Text("No image found !")),
          SizedBox(
            height: 10,
          ),
          ElevatedButton(
              onPressed: () async {
                var status = await Permission.storage.request();
                if (status == PermissionStatus.granted) {
                  Directory appDocDirectory =
                      await getApplicationDocumentsDirectory();
                  new Directory(appDocDirectory.path + '/' + 'dir')
                      .create(recursive: true);
                  
                  // void checkDirs() async {
                  //   Directory tempDir =
                  //       await getApplicationDocumentsDirectory();
                  //   List<FileSystemEntity> directory = tempDir.listSync();
                  //   directory.forEach((x) => debugPrint(x.path));
                  // }

                  // Future<File> readImage(String path) async {
                  //   return File(path);
                  // }
                  // newfile.rename('/storage/emulated/0/ridhun.png');
                }
              },
              child: Text("STORE THE SELECTED IMAGE "))
        ],
      ),
    );
  }
}
