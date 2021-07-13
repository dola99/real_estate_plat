import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/real_estate.dart';
import 'package:path/path.dart' as Path;
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import '../widgets/User_image_ad_picker.dart';
import '../models/list_of_Governorates.dart';

class AddNewHomeForSell extends StatefulWidget {
  static const routename = '/Add_New_Home';
  @override
  _AddNewHomeForSellState createState() => _AddNewHomeForSellState();
}

class _AddNewHomeForSellState extends State<AddNewHomeForSell> {
  List<String> places = [];
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
  final _gasFocusNode = FocusNode();
  final _asanserFocusNode = FocusNode();
  final _securityFocusNode = FocusNode();
  final _electricFocusNode = FocusNode();
  final _waterFcusNode = FocusNode();
  final _gardernFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  var _editedNewHome = Home(
      id: null,
      title: '',
      govermnet: '',
      place: '',
      cashordespost: '',
      buyorRent: '',
      floor: 0,
      area: 0,
      countroom: 0,
      countwc: 0,
      views: 0,
      adcount: 000000 + SellHome.homes.length ?? 1,
      gas: false,
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
    'Gas': '',
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
        _editedNewHome = Provider.of<Homes>(context).findById(adId);
        _initvalues = {
          'AdCount': _editedNewHome.adcount.toString(),
          'Area': _editedNewHome.area.toString(),
          'Asanser': _editedNewHome.asanser.toString(),
          'CountRooms': _editedNewHome.countroom.toString(),
          'CountWc': _editedNewHome.countwc.toString(),
          'Electric': _editedNewHome.electric.toString(),
          'Floor': _editedNewHome.floor.toString(),
          'Garden': _editedNewHome.gardern.toString(),
          'Gas': _editedNewHome.gas.toString(),
          'Goverment': _editedNewHome.govermnet,
          'Place': _editedNewHome.place,
          'Security': _editedNewHome.security.toString(),
          'Views': _editedNewHome.views.toString(),
          'Water': _editedNewHome.water.toString(),
          'BuyOrRent': _editedNewHome.buyorRent,
          'CashorDepost': _editedNewHome.cashordespost,
          'title': _editedNewHome.title,
          'description': _editedNewHome.description,
          'imageUrl': _editedNewHome.mainimage,
          'Image1': _editedNewHome.image1,
          'Image2': _editedNewHome.image2,
          'Image3': _editedNewHome.image3,
          'Image4': _editedNewHome.image4,
          'Image5': _editedNewHome.image5,
          'price': _editedNewHome.price.toString(),
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
    _gasFocusNode.dispose();
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
      return "plese see the problem";
    }
    _form.currentState.save();
    setState(() {
      _isloading = true;
    });
    if (_editedNewHome.id != null) {
      Provider.of<Homes>(context, listen: false)
          .updateproduct(_editedNewHome.id, _editedNewHome);
          Navigator.of(context).pop();
    } else {
      try {
        await Provider.of<Homes>(context, listen: false)
            .addproduct(_editedNewHome);
        Navigator.of(context).pop();
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
          ),
        );
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
        _mainuploadedimageURL = fileURl;
      

        
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
        __uploadedimage3URL = fileURl;
       
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
        __uploadedimage4URL = fileURl;
        
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
        __uploadedimage5URL = fileURl;
       
      });
    });
  }

  @override
  Widget build(BuildContext co11ntext) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('New  Home Ad'),
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
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          _editedNewHome.mainimage != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.mainimage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : UserAdImagePicker(_pickedImage),
                          TextFormField(
                            initialValue: _initvalues['title'],
                            focusNode: _titleFocusNode,
                            decoration: InputDecoration(hintText: 'Title'),
                            textInputAction: TextInputAction.next,
                            maxLength: 17,
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
                              _editedNewHome = Home(
                                adcount: _editedNewHome.adcount,
                                area: _editedNewHome.area,
                                asanser: _editedNewHome.asanser,
                                countroom: _editedNewHome.countroom,
                                countwc: _editedNewHome.countwc,
                                electric: _editedNewHome.electric,
                                floor: _editedNewHome.floor,
                                gardern: _editedNewHome.gardern,
                                buyorRent: _editedNewHome.buyorRent,
                                cashordespost: _editedNewHome.cashordespost,
                                gas: _editedNewHome.gas,
                                govermnet: _editedNewHome.govermnet,
                                place: _editedNewHome.place,
                                security: _editedNewHome.security,
                                views: _editedNewHome.views,
                                water: _editedNewHome.water,
                                title: value,
                                description: _editedNewHome.description,
                                mainimage: _mainuploadedimageURL,
                                image1: _editedNewHome.image1,
                                image2: _editedNewHome.image2,
                                image3: _editedNewHome.image3,
                                image4: _editedNewHome.image4,
                                image5: _editedNewHome.image5,
                                price: _editedNewHome.price,
                                id: _editedNewHome.id,
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
                                    value: _editedNewHome.govermnet != ""
                                        ? _editedNewHome.govermnet
                                        : _drowdownvalue,
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
                                      setState(() {
                                        returnlist();
                                        if (newvalue.isNotEmpty) {
                                          _drowdownvalue = newvalue;
                                        }
                                        returnlist();
                                        _editedNewHome.govermnet =
                                            _drowdownvalue;
                                      });
                                    }),
                                DropdownButton<String>(
                                    value: _editedNewHome.place != ""
                                        ? _editedNewHome.place
                                        : _drowdownvalue2,
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

                                        _editedNewHome.place = _drowdownvalue2;
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
                                    value: _editedNewHome.buyorRent != ""
                                        ? _editedNewHome.buyorRent
                                        : _drowdownvalue3,
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    items: ['Buy', 'Rent']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
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
                                        _editedNewHome.buyorRent =
                                            _drowdownvalue3;
                                      });
                                    }),
                                DropdownButton<String>(
                                    value: _editedNewHome.cashordespost != ""
                                        ? _editedNewHome.cashordespost
                                        : _drowdownvalue4,
                                    iconSize: 24,
                                    elevation: 16,
                                    style: TextStyle(color: Colors.black),
                                    items: ['Cash', 'Deposit']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
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
                                        _editedNewHome.cashordespost =
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
                                    decoration:
                                        InputDecoration(hintText: 'Floor'),
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
                                      _editedNewHome = Home(
                                        adcount: _editedNewHome.adcount,
                                        area: _editedNewHome.area,
                                        asanser: _editedNewHome.asanser,
                                        countroom: _editedNewHome.countroom,
                                        countwc: _editedNewHome.countwc,
                                        electric: _editedNewHome.electric,
                                        floor: int.parse(value),
                                        gardern: _editedNewHome.gardern,
                                        buyorRent: _drowdownvalue3,
                                        cashordespost: _drowdownvalue4,
                                        gas: _editedNewHome.gas,
                                        govermnet: _drowdownvalue,
                                        place: _drowdownvalue2,
                                        security: _editedNewHome.security,
                                        views: _editedNewHome.views,
                                        water: _editedNewHome.water,
                                        title: _editedNewHome.title,
                                        description: _editedNewHome.description,
                                        mainimage: _editedNewHome.mainimage,
                                        image1: _editedNewHome.image1,
                                        image2: _editedNewHome.image2,
                                        image3: _editedNewHome.image3,
                                        image4: _editedNewHome.image4,
                                        image5: _editedNewHome.image5,
                                        price: _editedNewHome.price,
                                        id: _editedNewHome.id,
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
                                      _editedNewHome = Home(
                                        adcount: _editedNewHome.adcount,
                                        area: int.parse(value),
                                        asanser: _editedNewHome.asanser,
                                        countroom: _editedNewHome.countroom,
                                        countwc: _editedNewHome.countwc,
                                        electric: _editedNewHome.electric,
                                        floor: _editedNewHome.floor,
                                        gardern: _editedNewHome.gardern,
                                        buyorRent: _editedNewHome.buyorRent,
                                        cashordespost:
                                            _editedNewHome.cashordespost,
                                        gas: _editedNewHome.gas,
                                        govermnet: _editedNewHome.govermnet,
                                        place: _editedNewHome.place,
                                        security: _editedNewHome.security,
                                        views: _editedNewHome.views,
                                        water: _editedNewHome.water,
                                        title: _editedNewHome.title,
                                        description: _editedNewHome.description,
                                        mainimage: _editedNewHome.mainimage,
                                        image1: _editedNewHome.image1,
                                        image2: _editedNewHome.image2,
                                        image3: _editedNewHome.image3,
                                        image4: _editedNewHome.image4,
                                        image5: _editedNewHome.image5,
                                        price: _editedNewHome.price,
                                        id: _editedNewHome.id,
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
                                    decoration:
                                        InputDecoration(hintText: 'Rooms'),
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
                                      _editedNewHome = Home(
                                        adcount: _editedNewHome.adcount,
                                        area: _editedNewHome.area,
                                        asanser: _editedNewHome.asanser,
                                        countroom: int.parse(value),
                                        countwc: _editedNewHome.countwc,
                                        electric: _editedNewHome.electric,
                                        floor: _editedNewHome.floor,
                                        gardern: _editedNewHome.gardern,
                                        buyorRent: _editedNewHome.buyorRent,
                                        cashordespost:
                                            _editedNewHome.cashordespost,
                                        gas: _editedNewHome.gas,
                                        govermnet: _editedNewHome.govermnet,
                                        place: _editedNewHome.place,
                                        security: _editedNewHome.security,
                                        views: _editedNewHome.views,
                                        water: _editedNewHome.water,
                                        title: _editedNewHome.title,
                                        description: _editedNewHome.description,
                                        mainimage: _editedNewHome.mainimage,
                                        image1: _editedNewHome.image1,
                                        image2: _editedNewHome.image2,
                                        image3: _editedNewHome.image3,
                                        image4: _editedNewHome.image4,
                                        image5: _editedNewHome.image5,
                                        price: _editedNewHome.price,
                                        id: _editedNewHome.id,
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
                                          .requestFocus(_descriptionFocusNode);
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
                                      _editedNewHome = Home(
                                        adcount: _editedNewHome.adcount,
                                        area: _editedNewHome.area,
                                        asanser: _editedNewHome.asanser,
                                        countroom: _editedNewHome.countroom,
                                        countwc: int.parse(value),
                                        electric: _editedNewHome.electric,
                                        floor: _editedNewHome.floor,
                                        gardern: _editedNewHome.gardern,
                                        buyorRent: _editedNewHome.buyorRent,
                                        cashordespost:
                                            _editedNewHome.cashordespost,
                                        gas: _editedNewHome.gas,
                                        govermnet: _editedNewHome.govermnet,
                                        place: _editedNewHome.place,
                                        security: _editedNewHome.security,
                                        views: _editedNewHome.views,
                                        water: _editedNewHome.water,
                                        title: _editedNewHome.title,
                                        description: _editedNewHome.description,
                                        mainimage: _editedNewHome.mainimage,
                                        image1: _editedNewHome.image1,
                                        image2: _editedNewHome.image2,
                                        image3: _editedNewHome.image3,
                                        image4: _editedNewHome.image4,
                                        image5: _editedNewHome.image5,
                                        price: _editedNewHome.price,
                                        id: _editedNewHome.id,
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          TextFormField(
                            initialValue: _initvalues['description'],
                            focusNode: _descriptionFocusNode,
                            decoration:
                                InputDecoration(hintText: 'Description'),
                            maxLines: 5,
                            textInputAction: TextInputAction.newline,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please Enter A Main Title';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _editedNewHome = Home(
                                adcount: _editedNewHome.adcount,
                                area: _editedNewHome.area,
                                asanser: _editedNewHome.asanser,
                                countroom: _editedNewHome.countroom,
                                countwc: _editedNewHome.countwc,
                                electric: _editedNewHome.electric,
                                floor: _editedNewHome.floor,
                                gardern: _editedNewHome.gardern,
                                buyorRent: _editedNewHome.buyorRent,
                                cashordespost: _editedNewHome.cashordespost,
                                gas: _editedNewHome.gas,
                                govermnet: _editedNewHome.govermnet,
                                place: _editedNewHome.place,
                                security: _editedNewHome.security,
                                views: _editedNewHome.views,
                                water: _editedNewHome.water,
                                title: _editedNewHome.title,
                                description: value,
                                mainimage: _editedNewHome.mainimage,
                                image1: _editedNewHome.image1,
                                image2: _editedNewHome.image2,
                                image3: _editedNewHome.image3,
                                image4: _editedNewHome.image4,
                                image5: _editedNewHome.image5,
                                price: _editedNewHome.price,
                                id: _editedNewHome.id,
                              );
                            },
                          ),
                          CheckboxListTile(
                              secondary: Icon(Icons.whatshot),
                              title: Text('Gas'),
                              value: _editedNewHome.gas,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.gas = !_editedNewHome.gas;
                                });
                              }),
                          CheckboxListTile(
                              secondary: Icon(Icons.security),
                              title: Text('Security'),
                              value: _editedNewHome.security,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.security =
                                      !_editedNewHome.security;
                                });
                              }),
                          CheckboxListTile(
                              secondary: Icon(Icons.wb_incandescent),
                              title: Text('Electric'),
                              value: _editedNewHome.electric,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.electric =
                                      !_editedNewHome.electric;
                                });
                              }),
                          CheckboxListTile(
                              secondary: Icon(Icons.opacity),
                              title: Text('Water'),
                              value: _editedNewHome.water,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.water = !_editedNewHome.water;
                                });
                              }),
                          CheckboxListTile(
                              secondary: Icon(Icons.deck),
                              title: Text('Garden'),
                              value: _editedNewHome.gardern,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.gardern =
                                      !_editedNewHome.gardern;
                                });
                              }),
                          CheckboxListTile(
                              secondary: Icon(Icons.clear_all),
                              title: Text('elevator'),
                              value: _editedNewHome.asanser,
                              onChanged: (value) {
                                setState(() {
                                  _editedNewHome.asanser =
                                      !_editedNewHome.asanser;
                                });
                              }),
                          const SizedBox(
                            height: 5,
                          ),
                          _editedNewHome.image1 != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.image1,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : UserAdImagePicker(_pickedImage2),
                          const SizedBox(
                            height: 10,
                          ),
                          
                          _editedNewHome.image2 != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.image2,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : UserAdImagePicker(_pickedImage3),
                          const SizedBox(
                            height: 10,
                          ),
                          _editedNewHome.image3 != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.image3,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : UserAdImagePicker(_pickedImage4),
                          const SizedBox(
                            height: 10,
                          ),
                          _editedNewHome.image4 != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.image4,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : UserAdImagePicker(_pickedImage5),
                         const SizedBox(
                            height: 10,
                          ),
                          _editedNewHome.image5 != ""
                              ? Container(
                                  width: mediaquery.width,
                                  height: mediaquery.height * .15,
                                  child: Image(
                                    image: NetworkImage(
                                      _editedNewHome.image5,
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
                              _editedNewHome = Home(
                                adcount: _editedNewHome.adcount,
                                area: _editedNewHome.area,
                                asanser: _editedNewHome.asanser,
                                countroom: _editedNewHome.countroom,
                                countwc: _editedNewHome.countwc,
                                electric: _editedNewHome.electric,
                                floor: _editedNewHome.floor,
                                gardern: _editedNewHome.gardern,
                                buyorRent: _editedNewHome.buyorRent,
                                cashordespost: _editedNewHome.cashordespost,
                                gas: _editedNewHome.gas,
                                govermnet: _editedNewHome.govermnet,
                                place: _editedNewHome.place,
                                security: _editedNewHome.security,
                                views: _editedNewHome.views,
                                water: _editedNewHome.water,
                                title: _editedNewHome.title,
                                description: _editedNewHome.description,
                                mainimage: _editedNewHome.mainimage,
                                image1: _uploadedimage1URL,
                                image2: __uploadedimage2URL,
                                image3: __uploadedimage3URL,
                                image4: __uploadedimage4URL,
                                image5: __uploadedimage5URL,
                                price: int.parse(value),
                                id: _editedNewHome.id,
                              );
                            },
                          ),
                        ],
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
