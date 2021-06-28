import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/http_exception.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/screens/second_signup.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/Signup_screen';

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, String> _authData = {
    'email': '',
    'password': '',
  };
  var isLoading = false;
  final _passwordController = TextEditingController();
  bool _eyetrue = true;
  bool _eyetrue2 = true;
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();
    setState(() {
      isLoading = true;
    });
    try {
      // Sign user up
      await Provider.of<Auth>(context, listen: false).signup(
        _authData['email'],
        _authData['password'],
      );
      Navigator.of(context).pushNamed(SecondStepSignUp.routeName);
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
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Center(
                  child: Text(
                    "create an account",
                    style: TextStyle(
                        color: Colors.black, fontSize: 30, fontFamily: "Lora"),
                  ),
                ),
              ),
              //   Container(
              //     width: double.infinity,
              //     height: mediaquery.height * .13,
              //     child: Padding(
              //       padding: EdgeInsets.only(left: mediaquery.width * .28),
              //       child: Row(
              //         children: [
              //           Padding(
              //             padding: EdgeInsets.only(right: mediaquery.width * .08),
              //             child: Container(
              //               width: mediaquery.width * .175,
              //               height: mediaquery.height * .08,
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(30),
              //                 color: Color.fromRGBO(238, 238, 255, 1),
              //               ),
              //               child: Center(
              //                   child: SvgPicture.asset(
              //                 'assets/images/f.svg',
              //                 width: mediaquery.height * .025,
              //                 fit: BoxFit.cover,
              //               )),
              //             ),
              //           ),
              //           Container(
              //             width: mediaquery.width * .175,
              //             height: mediaquery.height * .08,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(30),
              //               color: Color.fromRGBO(238, 238, 255, 1),
              //             ),
              //             child: Center(
              //                 child: SvgPicture.asset(
              //               'assets/images/Group 66.svg',
              //               width: mediaquery.height * .035,
              //               fit: BoxFit.cover,
              //             )),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Email",
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: "LoraM"),
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
                      keyboardType: TextInputType.emailAddress,
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
                        color: Colors.black, fontSize: 20, fontFamily: "LoraM"),
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
                            controller: _passwordController,
                            // ignore: missing_return
                            validator: (value) {
                              if (value.isEmpty || value.length < 5) {
                                return 'Password is too short!';
                              }
                            },
                            onSaved: (value) {
                              _authData['password'] = value;
                            },
                            obscureText: _eyetrue,
                            decoration: InputDecoration(
                              hintText: "************",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
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
              Padding(
                padding: const EdgeInsets.all(17.0),
                child: Container(
                  width: double.infinity,
                  child: Text(
                    "Confirm Your Password",
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                        color: Colors.black, fontSize: 20, fontFamily: "LoraM"),
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
                            obscureText: _eyetrue2,
                            decoration: InputDecoration(
                              hintText: "************",
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                            // ignore: missing_return
                            validator: (value) {
                              if (value != _passwordController.text) {
                                return 'Passwords do not match!';
                              }
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
                              _eyetrue2 = !_eyetrue2;
                            });
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GestureDetector(
                      onTap: () {
                        _submit();
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
                            "Next",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'LoraM'),
                          ),
                        ),
                      ),
                    ),
            ],
          )),
        ),
      ),
    );
  }
}
