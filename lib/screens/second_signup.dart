import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/Users.dart';
import 'package:real_estate/providers/user.dart';

class SecondStepSignUp extends StatefulWidget {
  static const routeName = '/Second_Step';
  @override
  _SecondStepSignUpState createState() => _SecondStepSignUpState();
}

class _SecondStepSignUpState extends State<SecondStepSignUp> {
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
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/WelcomeScreen', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Form(
                  key: _form,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      Center(
                        child: Text(
                          " Last Step To Join us",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontFamily: "Lora"),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "First Name",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "LoraM"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17),
                        child: Container(
                          width: mediaquery.width * .9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 9, right: 9),
                            child: TextFormField(
                              initialValue: _initvalues['FirstName'],
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (_) {
                                FocusScope.of(context)
                                    .requestFocus(_secondNameFocusNode);
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
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText: "First Name",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Last Name",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "LoraM"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17),
                        child: Container(
                          width: mediaquery.width * .9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 9, right: 9),
                            child: TextFormField(
                              focusNode: _secondNameFocusNode,
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
                              decoration: InputDecoration(
                                hintText: "last Name",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(17.0),
                        child: Container(
                          width: double.infinity,
                          child: Text(
                            "Phone Number",
                            textAlign: TextAlign.left,
                            textDirection: TextDirection.ltr,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: "LoraM"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 17),
                        child: Container(
                          width: mediaquery.width * .9,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 5, bottom: 5, left: 9, right: 9),
                            child: TextFormField(
                              focusNode: _phoneNumeberFocusNode,
                              initialValue: _initvalues['PhoneNumber'],
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
                                );
                              },
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: "Phone Number",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      GestureDetector(
                        onTap: () {
                          _saveForm();
                        },
                        child: Container(
                          width: mediaquery.width * .7,
                          height: mediaquery.height * .05,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Finish",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'LoraM'),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
