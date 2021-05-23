import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/Users.dart';
import 'package:real_estate/providers/user.dart';
import 'package:real_estate/widgets/user_image_picker.dart';
import 'package:path/path.dart' as Path;

class EditUserProfile extends StatefulWidget {
  static const routeName = '/Edit_profile';
  @override
  _EditUserProfileState createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  String _uploadedFileURL;
  File _userImageFile;
  final _firstNameFocusNode = FocusNode();
  final _secondNameFocusNode = FocusNode();
  final _phoneNumeberFocusNode = FocusNode();

  final _form = GlobalKey<FormState>();

  var _editedUser =
      User(firstName: '', id: null, lastName: '', phoneNumber: '');
  var _initvalues = {
    'FirstName': '',
    'LastName': '',
    'PhoneNumber': '',
    'ImageUrl': '',
  };
  var _isInit = true;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final userId = ModalRoute.of(context).settings.arguments as String;
      if (userId != null) {
        _editedUser = Provider.of<Users>(context).findById(userId);
        _initvalues = {
          'FirstName': _editedUser.firstName,
          'LastName': _editedUser.lastName,
          'PhoneNumber': _editedUser.phoneNumber,
          'ImageUrl': _editedUser.imageurl,
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _firstNameFocusNode.dispose();
    _secondNameFocusNode.dispose();
    _phoneNumeberFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    setState(() {
      _isLoading = true;
    });
    if (_editedUser.id != null) {
      // ignore: await_only_futures
      await Provider.of<Users>(context, listen: false)
          .updateUser(_editedUser.id, _editedUser);
    } else {
      try {
        await Provider.of<Users>(context, listen: false).addUser(_editedUser);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('An error occurred!'),
            content: Text('Something went wrong.'),
            actions: <Widget>[
              // ignore: deprecated_member_use
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              )
            ],
          ),
        );
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  void _pickedImage(File image) {
    _userImageFile = image;
    uploadFile();
  }

  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(fileURl);
        _uploadedFileURL = fileURl;
        print(_uploadedFileURL);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    print(_uploadedFileURL);
    var mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Edit Profile"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Form(
        key: _form,
        child: Center(
          child: Container(
            width: mediaquery.width * .8,
            height: mediaquery.height * 0.5,
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(.4),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ListView(
                children: [
                  _editedUser.imageurl != null
                      ? CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: Image.network(
                              _editedUser.imageurl,
                              width: 80,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        )
                      : UserImagePicker(_pickedImage),
                  TextFormField(
                    initialValue: _initvalues['FirstName'],
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context).requestFocus(_secondNameFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Provide Your First Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = User(
                        firstName: value,
                        id: _editedUser.id,
                        lastName: _editedUser.lastName,
                        phoneNumber: _editedUser.phoneNumber,
                      );
                    },
                  ),
                  TextFormField(
                    initialValue: _initvalues['LastName'],
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(context)
                          .requestFocus(_phoneNumeberFocusNode);
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Provide Your First Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = User(
                        firstName: _editedUser.firstName,
                        id: _editedUser.id,
                        lastName: value,
                        phoneNumber: _editedUser.phoneNumber,
                      );
                    },
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    initialValue: _initvalues['PhoneNumber'],
                    focusNode: _phoneNumeberFocusNode,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Provide Your First Name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _editedUser = User(
                        firstName: _editedUser.firstName,
                        id: _editedUser.id,
                        lastName: _editedUser.lastName,
                        phoneNumber: value,
                        imageurl: _uploadedFileURL.toString(),
                      );
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  _isLoading
                      ? CircularProgressIndicator()
                      : GestureDetector(
                          onTap: _saveForm,
                          child: Center(
                            child: Container(
                              width: mediaquery.width * .3,
                              height: mediaquery.height * .05,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.black),
                              child: Center(
                                child: Text("Save",
                                    style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ),
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
