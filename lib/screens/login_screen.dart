import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/http_exception.dart';
import 'package:real_estate/providers/auth.dart';
import 'Signup.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/Login_screen';
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _eyetrue = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var _isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
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

  Future<void> _submitt() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      // Log user in
      await Provider.of<Auth>(context, listen: false).login(
        _authData['email'],
        _authData['password'],
      );
    } on HttpException catch (error) {
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Could not find a user with that email.';
      } else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'Invalid password.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      const errorMessage =
          'Could not authenticate you. Please try again later.';
      _showErrorDialog(errorMessage);
    }

    setState(() {
      _isLoading = false;
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: mediaquery.height * .40,
                  child: Image.asset(
                    'assets/images/login.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Welcome Back",
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "Lora"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(17.0),
                  child: Container(
                    width: double.infinity,
                    child: Text(
                      "Email",
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
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Invalid email!';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _authData['email'] = value;
                        },
                        decoration: InputDecoration(
                          hintText: "Hello@gmail.com",
                          border:
                              UnderlineInputBorder(borderSide: BorderSide.none),
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
                      "Password",
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
                      padding: const EdgeInsets.only(left: 8, right: 1),
                      child: Row(
                        children: [
                          Container(
                            width: mediaquery.width * .720,
                            child: TextFormField(
                              obscureText: _eyetrue,
                              decoration: InputDecoration(
                                hintText: "************",
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                              validator: (value) {
                                if (value.isEmpty || value.length < 5) {
                                  return 'Password is too short!';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _authData['password'] = value;
                              },
                              style: TextStyle(
                                color: Colors.black,
                                backgroundColor: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_red_eye),
                            onPressed: () {
                              setState(() {
                                _eyetrue = !_eyetrue;
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                _isLoading
                    ? CircularProgressIndicator()
                    : GestureDetector(
                        onTap: _submitt,
                        child: Container(
                          width: mediaquery.width * .7,
                          height: mediaquery.height * .05,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              "Log in",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'LoraM'),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    "Not A Member?",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 15, fontFamily: 'LoraM'),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
