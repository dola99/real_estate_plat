import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';
import '../widgets/User_image_ad_picker.dart';
import '../models/list_of_Governorates.dart';

class AddOfficeForSell extends StatefulWidget {
  static const routeName = '/Add_Office_for_Sell';
  @override
  _AddOfficeForSellState createState() => _AddOfficeForSellState();
}

class _AddOfficeForSellState extends State<AddOfficeForSell> {
  List<String> places = [];
  bool _uplodephoto = false;
  String _drowdownvalue = 'Cairo';
  String _drowdownvalue2 = '15 May city';
  String _drowdownvalue3 = 'Buy';
  String _drowdownvalue4 = 'Cash';
  //  bool _gas = false;
  //  bool _security = false;
  // bool _electric = false;
  // bool _water = false;
  // bool _garden = false;
  // bool _elevator = false;
  dynamic _uploadedimage1URL;
  dynamic __uploadedimage2URL;
  dynamic __uploadedimage3URL;
  dynamic __uploadedimage4URL;
  dynamic __uploadedimage5URL;
  dynamic _mainuploadedimageURL;
  File _userImageFile;
  File _userImageFile1;
  File _userImageFile2;
  File _userImageFile3;
  File _userImageFile4;
  File _userImageFile5;

  final _form = GlobalKey<FormState>();
  final _titleFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _govermnetFocusNode = FocusNode();
  final _placeFocusNode = FocusNode();
  final _cashordespostFocusNode = FocusNode();
  final _buyorRentFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
  final _floorFocusNode = FocusNode();
  final _areaFocusNode = FocusNode();
  final _countroomFocusNode = FocusNode();
  final _countwcFocusNode = FocusNode();
  final _adcountFocusNode = FocusNode();
  final _viewsFocusNode = FocusNode();
  final _countTablesFocusNode = FocusNode();
  final _asanserFocusNode = FocusNode();
  final _securityFocusNode = FocusNode();
  final _electricFocusNode = FocusNode();
  final _waterFcusNode = FocusNode();
  final _gardernFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  var _editedNewOffice = Office(
      id: null,
      title: '',
      govermnet: '',
      place: '',
      cashordeposit: '',
      buyorrent: '',
      floor: 0,
      area: 0,
      countroom: 0,
      countwc: 0,
      views: 0,
      adcount: 000000 + Selloffice.offices.length ?? 1,
      counttables: 0,
      asanser: false,
      security: false,
      electric: false,
      water: false,
      gardern: false,
      price: 0,
      mainimage: '',
      description: '',
      image1: '',
      image2: '',
      image3: '',
      image4: '',
      image5: '');

  var _initvalues = {
    'AdCount': '',
    'Area': '',
    'Asanser': '',
    'CountRooms': '',
    'CountWc': '',
    'Electric': '',
    'Floor': '',
    'Garden': '',
    'CountOfTable': '',
    'Goverment': '',
    'Place': '',
    'Security': '',
    'Views': '',
    'Water': '',
    'BuyOrRent': '',
    'CashorDepost': '',
    'title': '',
    'description': '',
    'imageUrl': '',
    'Image1': '',
    'Image2': '',
    'Image3': '',
    'Image4': '',
    'Image5': '',
    'price': '',
  };
  var _isInit = true;
  var _isloading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final adId = ModalRoute.of(context).settings.arguments as String;
      if (adId != null) {
        _editedNewOffice = Provider.of<Offices>(context).findById(adId);
        _initvalues = {
          'AdCount': _editedNewOffice.adcount.toString(),
          'Area': _editedNewOffice.area.toString(),
          'Asanser': _editedNewOffice.asanser.toString(),
          'CountRooms': _editedNewOffice.countroom.toString(),
          'CountWc': _editedNewOffice.countwc.toString(),
          'Electric': _editedNewOffice.electric.toString(),
          'Floor': _editedNewOffice.floor.toString(),
          'Garden': _editedNewOffice.gardern.toString(),
          'CountOfTable': _editedNewOffice.counttables.toString(),
          'Goverment': _editedNewOffice.govermnet,
          'Place': _editedNewOffice.place,
          'Security': _editedNewOffice.security.toString(),
          'Views': _editedNewOffice.views.toString(),
          'Water': _editedNewOffice.water.toString(),
          'BuyOrRent': _editedNewOffice.buyorrent,
          'CashorDepost': _editedNewOffice.cashordeposit,
          'title': _editedNewOffice.title,
          'description': _editedNewOffice.description,
          'imageUrl': _editedNewOffice.mainimage,
          'Image1': _editedNewOffice.image1,
          'Image2': _editedNewOffice.image2,
          'Image3': _editedNewOffice.image3,
          'Image4': _editedNewOffice.image4,
          'Image5': _editedNewOffice.image5,
          'price': _editedNewOffice.price.toString(),
        };
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _titleFocusNode..dispose();
    _descriptionFocusNode.dispose();
    _govermnetFocusNode.dispose();
    _placeFocusNode.dispose();
    _cashordespostFocusNode.dispose();
    _buyorRentFocusNode.dispose();
    _priceFocusNode.dispose();
    _floorFocusNode.dispose();
    _areaFocusNode.dispose();
    _countroomFocusNode.dispose();
    _countwcFocusNode.dispose();
    _adcountFocusNode.dispose();
    _viewsFocusNode.dispose();
    _countTablesFocusNode.dispose();
    _asanserFocusNode.dispose();
    _securityFocusNode.dispose();
    _electricFocusNode.dispose();
    _waterFcusNode.dispose();
    _gardernFocusNode.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_editedNewOffice.id != null) {
      Provider.of<Offices>(context, listen: false)
          .updateproduct(_editedNewOffice.id, _editedNewOffice);
    } else {
      try {
        await Provider.of<Offices>(context, listen: false)
            .addproduct(_editedNewOffice)
            .then((_) {
          setState(() {});
        });
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("An error occurred"),
                  content: Text("Something Went Error"),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Okay"))
                  ],
                ));
      }
    }
    setState(() {
      _isloading = false;
    });
  }

  void _pickedImage(File image) {
    _userImageFile = image;
    uploadFile();
  }

  void _pickedImage2(File image) {
    _userImageFile1 = image;
    uploadFile1();
  }

  void _pickedImage3(File image) {
    _userImageFile2 = image;
    uploadFile2();
  }

  void _pickedImage4(File image) {
    _userImageFile3 = image;
    uploadFile3();
  }

  void _pickedImage5(File image) {
    _userImageFile4 = image;
    uploadFile4();
  }

  void _pickedImage6(File image) {
    _userImageFile5 = image;
    uploadFile5();
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
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        _mainuploadedimageURL = fileURl;
        //print(imageurl);
      });
    });
  }

  Future uploadFile1() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile1.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile1);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        _uploadedimage1URL = fileURl;
        //print(imageurl);
      });
    });
  }

  Future uploadFile2() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile2.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile2);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        __uploadedimage2URL = fileURl;

        //print(imageurl);
      });
    });
  }

  Future uploadFile3() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile3.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile3);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        __uploadedimage3URL = fileURl;
        //print(imageurl);
      });
    });
  }

  Future uploadFile4() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile4.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile4);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        __uploadedimage4URL = fileURl;
        //print(imageurl);
      });
    });
  }

  Future uploadFile5() async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('${Path.basename(_userImageFile5.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_userImageFile5);
    await uploadTask.onComplete;
    print("File Uploaded");
    storageReference.getDownloadURL().then((fileURl) {
      setState(() {
        print(storageReference.getDownloadURL().toString());
        print(fileURl);
        __uploadedimage5URL = fileURl;
        //print(imageurl);
      });
    });
  }

  @override
  Widget build(BuildContext co11ntext) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('New Ad Office'),
        centerTitle: true,
        elevation: 0.0,
        actions: [
          IconButton(icon: Icon(Icons.save), onPressed: _saveForm),
        ],
      ),
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _editedNewOffice.mainimage != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.mainimage,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage),
                      UserAdImagePicker(_pickedImage),
                      TextFormField(
                        initialValue: _initvalues['title'],
                        focusNode: _titleFocusNode,
                        decoration: InputDecoration(hintText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onTap: () {
                          print(_mainuploadedimageURL);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Main Title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNewOffice = Office(
                            adcount: _editedNewOffice.adcount,
                            area: _editedNewOffice.area,
                            asanser: _editedNewOffice.asanser,
                            countroom: _editedNewOffice.countroom,
                            countwc: _editedNewOffice.countwc,
                            electric: _editedNewOffice.electric,
                            floor: _editedNewOffice.floor,
                            gardern: _editedNewOffice.gardern,
                            buyorrent: _editedNewOffice.buyorrent,
                            cashordeposit: _editedNewOffice.cashordeposit,
                            counttables: _editedNewOffice.counttables,
                            govermnet: _editedNewOffice.govermnet,
                            place: _editedNewOffice.place,
                            security: _editedNewOffice.security,
                            views: _editedNewOffice.views,
                            water: _editedNewOffice.water,
                            title: value,
                            description: _editedNewOffice.description,
                            mainimage: _mainuploadedimageURL,
                            image1: _editedNewOffice.image1,
                            image2: _editedNewOffice.image2,
                            image3: _editedNewOffice.image3,
                            image4: _editedNewOffice.image4,
                            image5: _editedNewOffice.image5,
                            price: _editedNewOffice.price,
                            id: _editedNewOffice.id,
                          );
                        },
                      ),
                      SizedBox(
                        height: mediaquery.height * .03,
                      ),
                      Container(
                        width: mediaquery.width,
                        height: mediaquery.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DropdownButton<String>(
                                value: _drowdownvalue,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                items: Egypt.governorates
                                    .map<DropdownMenuItem<String>>(
                                        (String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String newvalue) {
                                  returnlist();
                                  setState(() {
                                    if (newvalue.isNotEmpty) {
                                      _drowdownvalue = newvalue;
                                    }
                                    returnlist();
                                    _editedNewOffice.govermnet = _drowdownvalue;
                                  });
                                }),
                            DropdownButton<String>(
                                value: _drowdownvalue2,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                items: places.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String newvalue) {
                                  setState(() {
                                    if (newvalue.isNotEmpty) {
                                      _drowdownvalue2 = newvalue;
                                    }

                                    _editedNewOffice.place = _drowdownvalue2;
                                  });
                                }),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaquery.width,
                        height: mediaquery.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            DropdownButton<String>(
                                value: _drowdownvalue3,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                items: [
                                  'Buy',
                                  'Rent'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String newvalue) {
                                  setState(() {
                                    if (newvalue.isNotEmpty) {
                                      _drowdownvalue3 = newvalue;
                                    }
                                    _editedNewOffice.buyorrent =
                                        _drowdownvalue3;
                                  });
                                }),
                            DropdownButton<String>(
                                value: _drowdownvalue4,
                                iconSize: 24,
                                elevation: 16,
                                style: TextStyle(color: Colors.black),
                                items: [
                                  'Cash',
                                  'Deposit'
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem(
                                    child: Text(value),
                                    value: value,
                                  );
                                }).toList(),
                                onChanged: (String newvalue) {
                                  setState(() {
                                    if (newvalue.isNotEmpty) {
                                      _drowdownvalue4 = newvalue;
                                    }
                                    _editedNewOffice.cashordeposit =
                                        _drowdownvalue4;
                                  });
                                }),
                          ],
                        ),
                      ),
                      Container(
                        width: mediaquery.width,
                        height: mediaquery.height * .1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _initvalues['Floor'],
                                focusNode: _floorFocusNode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(hintText: 'Floor'),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_areaFocusNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter A Main Title';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedNewOffice = Office(
                                    adcount: _editedNewOffice.adcount,
                                    area: _editedNewOffice.area,
                                    asanser: _editedNewOffice.asanser,
                                    countroom: _editedNewOffice.countroom,
                                    countwc: _editedNewOffice.countwc,
                                    electric: _editedNewOffice.electric,
                                    floor: int.parse(value),
                                    gardern: _editedNewOffice.gardern,
                                    buyorrent: _editedNewOffice.buyorrent,
                                    cashordeposit:
                                        _editedNewOffice.cashordeposit,
                                    counttables: _editedNewOffice.counttables,
                                    govermnet: _editedNewOffice.govermnet,
                                    place: _editedNewOffice.place,
                                    security: _editedNewOffice.security,
                                    views: _editedNewOffice.views,
                                    water: _editedNewOffice.water,
                                    title: _editedNewOffice.title,
                                    description: _editedNewOffice.description,
                                    mainimage: _editedNewOffice.mainimage,
                                    image1: _editedNewOffice.image1,
                                    image2: _editedNewOffice.image2,
                                    image3: _editedNewOffice.image3,
                                    image4: _editedNewOffice.image4,
                                    image5: _editedNewOffice.image5,
                                    price: _editedNewOffice.price,
                                    id: _editedNewOffice.id,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _initvalues['Area'],
                                focusNode: _areaFocusNode,
                                decoration:
                                    InputDecoration(hintText: 'Area(m2)'),
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_countroomFocusNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter A Main Title';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedNewOffice = Office(
                                    adcount: _editedNewOffice.adcount,
                                    area: int.parse(value),
                                    asanser: _editedNewOffice.asanser,
                                    countroom: _editedNewOffice.countroom,
                                    countwc: _editedNewOffice.countwc,
                                    electric: _editedNewOffice.electric,
                                    floor: _editedNewOffice.floor,
                                    gardern: _editedNewOffice.gardern,
                                    buyorrent: _editedNewOffice.buyorrent,
                                    cashordeposit:
                                        _editedNewOffice.cashordeposit,
                                    counttables: _editedNewOffice.counttables,
                                    govermnet: _editedNewOffice.govermnet,
                                    place: _editedNewOffice.place,
                                    security: _editedNewOffice.security,
                                    views: _editedNewOffice.views,
                                    water: _editedNewOffice.water,
                                    title: _editedNewOffice.title,
                                    description: _editedNewOffice.description,
                                    mainimage: _editedNewOffice.mainimage,
                                    image1: _editedNewOffice.image1,
                                    image2: _editedNewOffice.image2,
                                    image3: _editedNewOffice.image3,
                                    image4: _editedNewOffice.image4,
                                    image5: _editedNewOffice.image5,
                                    price: _editedNewOffice.price,
                                    id: _editedNewOffice.id,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _initvalues['CountRooms'],
                                focusNode: _countroomFocusNode,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(hintText: 'Rooms'),
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_countwcFocusNode);
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter A Main Title';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedNewOffice = Office(
                                    adcount: _editedNewOffice.adcount,
                                    area: _editedNewOffice.area,
                                    asanser: _editedNewOffice.asanser,
                                    countroom: int.parse(value),
                                    countwc: _editedNewOffice.countwc,
                                    electric: _editedNewOffice.electric,
                                    floor: _editedNewOffice.floor,
                                    gardern: _editedNewOffice.gardern,
                                    buyorrent: _editedNewOffice.buyorrent,
                                    cashordeposit:
                                        _editedNewOffice.cashordeposit,
                                    counttables: _editedNewOffice.counttables,
                                    govermnet: _editedNewOffice.govermnet,
                                    place: _editedNewOffice.place,
                                    security: _editedNewOffice.security,
                                    views: _editedNewOffice.views,
                                    water: _editedNewOffice.water,
                                    title: _editedNewOffice.title,
                                    description: _editedNewOffice.description,
                                    mainimage: _editedNewOffice.mainimage,
                                    image1: _editedNewOffice.image1,
                                    image2: _editedNewOffice.image2,
                                    image3: _editedNewOffice.image3,
                                    image4: _editedNewOffice.image4,
                                    image5: _editedNewOffice.image5,
                                    price: _editedNewOffice.price,
                                    id: _editedNewOffice.id,
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: TextFormField(
                                initialValue: _initvalues['CountWc'],
                                focusNode: _countwcFocusNode,
                                keyboardType: TextInputType.number,
                                onFieldSubmitted: (_) {
                                  FocusScope.of(context)
                                      .requestFocus(_countTablesFocusNode);
                                },
                                decoration: InputDecoration(hintText: 'Wc'),
                                textInputAction: TextInputAction.next,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please Enter A Main Title';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  _editedNewOffice = Office(
                                    adcount: _editedNewOffice.adcount,
                                    area: _editedNewOffice.area,
                                    asanser: _editedNewOffice.asanser,
                                    countroom: _editedNewOffice.countroom,
                                    countwc: int.parse(value),
                                    electric: _editedNewOffice.electric,
                                    floor: _editedNewOffice.floor,
                                    gardern: _editedNewOffice.gardern,
                                    buyorrent: _editedNewOffice.buyorrent,
                                    cashordeposit:
                                        _editedNewOffice.cashordeposit,
                                    counttables: _editedNewOffice.counttables,
                                    govermnet: _editedNewOffice.govermnet,
                                    place: _editedNewOffice.place,
                                    security: _editedNewOffice.security,
                                    views: _editedNewOffice.views,
                                    water: _editedNewOffice.water,
                                    title: _editedNewOffice.title,
                                    description: _editedNewOffice.description,
                                    mainimage: _editedNewOffice.mainimage,
                                    image1: _editedNewOffice.image1,
                                    image2: _editedNewOffice.image2,
                                    image3: _editedNewOffice.image3,
                                    image4: _editedNewOffice.image4,
                                    image5: _editedNewOffice.image5,
                                    price: _editedNewOffice.price,
                                    id: _editedNewOffice.id,
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      TextFormField(
                        initialValue: _initvalues['CountOfTable'],
                        focusNode: _countTablesFocusNode,
                        keyboardType: TextInputType.number,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        decoration: InputDecoration(hintText: 'Tables'),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Main Title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNewOffice = Office(
                            adcount: _editedNewOffice.adcount,
                            area: _editedNewOffice.area,
                            asanser: _editedNewOffice.asanser,
                            countroom: _editedNewOffice.countroom,
                            countwc: _editedNewOffice.countwc,
                            electric: _editedNewOffice.electric,
                            floor: _editedNewOffice.floor,
                            gardern: _editedNewOffice.gardern,
                            buyorrent: _editedNewOffice.buyorrent,
                            cashordeposit: _editedNewOffice.cashordeposit,
                            counttables: int.parse(value),
                            govermnet: _editedNewOffice.govermnet,
                            place: _editedNewOffice.place,
                            security: _editedNewOffice.security,
                            views: _editedNewOffice.views,
                            water: _editedNewOffice.water,
                            title: _editedNewOffice.title,
                            description: _editedNewOffice.description,
                            mainimage: _editedNewOffice.mainimage,
                            image1: _editedNewOffice.image1,
                            image2: _editedNewOffice.image2,
                            image3: _editedNewOffice.image3,
                            image4: _editedNewOffice.image4,
                            image5: _editedNewOffice.image5,
                            price: _editedNewOffice.price,
                            id: _editedNewOffice.id,
                          );
                        },
                      ),
                      TextFormField(
                        initialValue: _initvalues['description'],
                        focusNode: _descriptionFocusNode,
                        decoration: InputDecoration(hintText: 'Description'),
                        maxLines: 5,
                        textInputAction: TextInputAction.newline,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Main Title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNewOffice = Office(
                            adcount: _editedNewOffice.adcount,
                            area: _editedNewOffice.area,
                            asanser: _editedNewOffice.asanser,
                            countroom: _editedNewOffice.countroom,
                            countwc: _editedNewOffice.countwc,
                            electric: _editedNewOffice.electric,
                            floor: _editedNewOffice.floor,
                            gardern: _editedNewOffice.gardern,
                            buyorrent: _editedNewOffice.buyorrent,
                            cashordeposit: _editedNewOffice.cashordeposit,
                            counttables: _editedNewOffice.counttables,
                            govermnet: _editedNewOffice.govermnet,
                            place: _editedNewOffice.place,
                            security: _editedNewOffice.security,
                            views: _editedNewOffice.views,
                            water: _editedNewOffice.water,
                            title: _editedNewOffice.title,
                            description: value,
                            mainimage: _editedNewOffice.mainimage,
                            image1: _editedNewOffice.image1,
                            image2: _editedNewOffice.image2,
                            image3: _editedNewOffice.image3,
                            image4: _editedNewOffice.image4,
                            image5: _editedNewOffice.image5,
                            price: _editedNewOffice.price,
                            id: _editedNewOffice.id,
                          );
                        },
                      ),
                      CheckboxListTile(
                          secondary: Icon(Icons.security),
                          title: Text('Security'),
                          value: _editedNewOffice.security,
                          onChanged: (value) {
                            setState(() {
                              _editedNewOffice.security =
                                  !_editedNewOffice.security;
                            });
                          }),
                      CheckboxListTile(
                          secondary: Icon(Icons.wb_incandescent),
                          title: Text('Electric'),
                          value: _editedNewOffice.electric,
                          onChanged: (value) {
                            setState(() {
                              _editedNewOffice.electric =
                                  !_editedNewOffice.electric;
                            });
                          }),
                      CheckboxListTile(
                          secondary: Icon(Icons.opacity),
                          title: Text('Water'),
                          value: _editedNewOffice.water,
                          onChanged: (value) {
                            setState(() {
                              _editedNewOffice.water = !_editedNewOffice.water;
                            });
                          }),
                      CheckboxListTile(
                          secondary: Icon(Icons.deck),
                          title: Text('Garden'),
                          value: _editedNewOffice.gardern,
                          onChanged: (value) {
                            setState(() {
                              _editedNewOffice.gardern =
                                  !_editedNewOffice.gardern;
                            });
                          }),
                      CheckboxListTile(
                          secondary: Icon(Icons.clear_all),
                          title: Text('elevator'),
                          value: _editedNewOffice.asanser,
                          onChanged: (value) {
                            setState(() {
                              _editedNewOffice.asanser =
                                  !_editedNewOffice.asanser;
                            });
                          }),
                      _editedNewOffice.image1 != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.image1,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage2),
                      const SizedBox(
                        height: 10,
                      ),
                      _editedNewOffice.image2 != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.image2,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage3),
                      const SizedBox(
                        height: 10,
                      ),
                      _editedNewOffice.image3 != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.image3,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage4),
                      const SizedBox(
                        height: 10,
                      ),
                      _editedNewOffice.image4 != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.image4,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage5),
                      const SizedBox(
                        height: 10,
                      ),
                      _editedNewOffice.image5 != ""
                          ? Container(
                              width: mediaquery.width,
                              height: mediaquery.height * .15,
                              child: Image(
                                image: NetworkImage(
                                  _editedNewOffice.image5,
                                ),
                                fit: BoxFit.cover,
                              ),
                            )
                          : UserAdImagePicker(_pickedImage6),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        initialValue: _initvalues['price'],
                        focusNode: _priceFocusNode,
                        decoration: InputDecoration(hintText: 'Price'),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter A Main Title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedNewOffice = Office(
                            adcount: _editedNewOffice.adcount,
                            area: _editedNewOffice.area,
                            asanser: _editedNewOffice.asanser,
                            countroom: _editedNewOffice.countroom,
                            countwc: _editedNewOffice.countwc,
                            electric: _editedNewOffice.electric,
                            floor: _editedNewOffice.floor,
                            gardern: _editedNewOffice.gardern,
                            buyorrent: _editedNewOffice.buyorrent,
                            cashordeposit: _editedNewOffice.cashordeposit,
                            counttables: _editedNewOffice.counttables,
                            govermnet: _editedNewOffice.govermnet,
                            place: _editedNewOffice.place,
                            security: _editedNewOffice.security,
                            views: _editedNewOffice.views,
                            water: _editedNewOffice.water,
                            title: _editedNewOffice.title,
                            description: _editedNewOffice.description,
                            mainimage: _editedNewOffice.mainimage,
                            image1: _editedNewOffice.image1,
                            image2: _editedNewOffice.image2,
                            image3: _editedNewOffice.image3,
                            image4: _editedNewOffice.image4,
                            image5: _editedNewOffice.image5,
                            price: double.parse(value),
                            id: _editedNewOffice.id,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  void returnlist() {
    if (_drowdownvalue == 'Cairo') {
      setState(() {
        places = Egypt.cairo;
        _drowdownvalue2 = Egypt.cairo.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Giza') {
      setState(() {
        places = Egypt.giza;
        _drowdownvalue2 = Egypt.giza.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Alexandria') {
      setState(() {
        places = Egypt.alexandria;
        _drowdownvalue2 = Egypt.alexandria.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Qalyubia') {
      setState(() {
        places = Egypt.qalyubia;
        _drowdownvalue2 = Egypt.qalyubia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Monufia') {
      setState(() {
        places = Egypt.mounofia;
        _drowdownvalue2 = Egypt.mounofia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Beni Suef') {
      setState(() {
        places = Egypt.baniswief;
        _drowdownvalue2 = Egypt.baniswief.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Gharbia') {
      setState(() {
        places = Egypt.garbiea;
        _drowdownvalue2 = Egypt.garbiea.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Sharqia') {
      setState(() {
        places = Egypt.sharqia;
        _drowdownvalue2 = Egypt.sharqia.first.toString();
        return;
      });
    } else if (_drowdownvalue == 'Suez') {
      setState(() {
        places = Egypt.suez;
        _drowdownvalue2 = Egypt.suez.first.toString();
        return;
      });
    } else {
      setState(() {
        places = Egypt.cairo;
        _drowdownvalue2 = Egypt.cairo.first.toString();
      });
    }
  }
}
