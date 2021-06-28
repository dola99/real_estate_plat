import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UserAdImagePicker extends StatefulWidget {
  UserAdImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;
  @override
  _UserAdImagePickerState createState() => _UserAdImagePickerState();
}

class _UserAdImagePickerState extends State<UserAdImagePicker> {
  File _pickedImage;
  bool _isloading;
  void pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  Future uploadFile() async {
    setState(() {
      _isloading = true;
    });
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_pickedImage.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_pickedImage);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        _isloading = false;
      });
    });
  }

  void _pickImageStorge() async {
    final pickedImageFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(File(pickedImageFile.path));
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _isloading = false;
    });
    final mediaquery = MediaQuery.of(context).size;
    return _isloading
        ? Center(child: CircularProgressIndicator())
        : Container(
            width: mediaquery.width,
            height: mediaquery.height * .15,
            child: _pickedImage == null
                ? Center(
                    child: TextButton.icon(
                      icon: Icon(Icons.upload_file),
                      onPressed: () {
                        _pickImageStorge();
                        uploadFile();
                      },
                      label: Text("Upload Main Image"),
                    ),
                  )
                : Column(
                    children: [
                      Container(
                        width: mediaquery.width,
                        height: mediaquery.height * .1,
                        child: Image(
                            image: FileImage(_pickedImage), fit: BoxFit.cover),
                      ),
                      Container(
                        height: mediaquery.height * .05,
                        child: Center(
                          child: TextButton.icon(
                            icon: Icon(Icons.upload_file,color: Colors.red,),
                            onPressed: () {
                              _pickImageStorge();
                              uploadFile();
                            },
                            label: Text("Upload Another Image",
                                style: TextStyle(color: Colors.red)),
                          ),
                        ),
                      )
                    ],
                  ));
  }
}
