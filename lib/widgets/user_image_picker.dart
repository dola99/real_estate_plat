import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as Path;

class UserImagePicker extends StatefulWidget {
  UserImagePicker(this.imagePickFn);

  final void Function(File pickedImage) imagePickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;
  String _uploadedFileURL;
  bool _isloading;
  void _pickImage() async {
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
        _uploadedFileURL = fileURl;
      });
    });
  }

  void _pickImageStorge() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      imageQuality: 50,
      maxWidth: 150,
    );
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
    return Column(
      children: <Widget>[
        _isloading
            ? CircularProgressIndicator()
            : CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage:
                    _pickedImage != null ? FileImage(_pickedImage) : null,
              ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton.icon(
              textColor: Colors.black,
              onPressed: () {
                _pickImage();
                uploadFile();
              },
              icon: Icon(Icons.camera),
              label: Text(
                'Camera',
                style: TextStyle(fontSize: 13),
              ),
            ),
            FlatButton.icon(
              textColor: Colors.black,
              onPressed: () {
                _pickImageStorge();
                uploadFile();
              },
              icon: Icon(Icons.image),
              label: Text('Add Image', style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
      ],
    );
  }
}
