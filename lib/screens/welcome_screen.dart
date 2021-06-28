import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/Users.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/user.dart';
import 'package:real_estate/screens/Edit_user.dart';
import 'package:real_estate/screens/Signup.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  static const routeName = '/WelcomeScreen';
  static List<User> allusers = [];
  static int indexuser;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int index;
  bool _isloading = false;
  bool _auth = false;
  List<User> users = [];
  String _isauth;
  @override
  void didChangeDependencies() async {
    _isauth = Provider.of<Auth>(context, listen: false).userId;
    if (_isauth == null) {
      _auth = false;
      WelcomeScreen.indexuser = null;
    } else {
      await Provider.of<Users>(context, listen: false)
          .fetchAndSetUsers()
          .then((value) {
        setState(() {
          _isloading = true;
        });
      });
      users = Provider.of<Users>(context, listen: false).items;
      WelcomeScreen.allusers = users;
      _auth = true;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
    returnData();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: width,
              height: hight * .35,
              child: Center(
                child: Image.asset(
                  'assets/images/Logo.png',
                ),
              ),
            ),
            Container(
              width: width,
              height: hight * .20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(SellHome.routeName);
                    },
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(SellHome.routeName);
                          },
                          child: Container(
                            width: width * .22,
                            height: hight * .1,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(70),
                                color: Color.fromRGBO(25, 118, 210, .24)),
                            child: Center(
                              child: SvgPicture.asset(
                                'assets/images/Home.svg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: hight * .01,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(fontFamily: "Oswald", fontSize: 20),
                        )
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(Selloffice.routeName),
                    child: Column(
                      children: [
                        Container(
                          width: width * .22,
                          height: hight * .1,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(70),
                              color: Color.fromRGBO(25, 118, 210, .24)),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/images/Office.svg',
                            ),
                          ),
                        ),
                        SizedBox(
                          height: hight * .01,
                        ),
                        Text(
                          "Office",
                          style: TextStyle(fontFamily: "Oswald", fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            _auth
                ? _isloading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(
                                EditUserProfile.routeName,
                                arguments: users[index].id);
                          },
                          child: Center(
                            child: Container(
                              width: width,
                              height: hight * .35,
                              child: Column(
                                children: [
                                  Container(
                                    width: width * .22,
                                    height: hight * .1,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(70),
                                        color:
                                            Color.fromRGBO(25, 118, 210, .24)),
                                    child: users[index].imageurl != null
                                        ? CircleAvatar(
                                            backgroundColor: Colors.white,
                                            backgroundImage: NetworkImage(
                                              users[index].imageurl,
                                            ),
                                          )
                                        : CircleAvatar(),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Center(
                                    child: Text(
                                      "${users[index].firstName + ' ' + users[index].lastName}",
                                      style: TextStyle(
                                          fontFamily: "Oswald", fontSize: 20),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      "${users[index].phoneNumber}",
                                      style: TextStyle(
                                          fontFamily: "Oswald", fontSize: 15),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                : Expanded(
                    child: Container(
                      width: double.infinity,
                      height: hight * .35,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName);
                            },
                            child: Center(
                              child: Container(
                                width: width * .22,
                                height: hight * .1,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(70),
                                    color: Color.fromRGBO(25, 118, 210, .24)),
                                child: Center(
                                  child: Image.asset(
                                      'assets/images/iconlogin.png'),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: hight * .01,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context)
                                  .pushNamed(LoginScreen.routeName);
                            },
                            child: Center(
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontFamily: "Oswald", fontSize: 20),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: hight * .06,
                          ),
                          Text(
                            "Not A Member",
                            style:
                                TextStyle(fontFamily: "Oswald", fontSize: 13),
                          ),
                          SizedBox(
                            height: hight * .005,
                          ),
                          _auth
                              ? Text("")
                              : GestureDetector(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(SignUpScreen.routeName);
                                  },
                                  child: Center(
                                    child: Container(
                                      width: width * .50,
                                      height: hight * .07,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          color: Color.fromRGBO(
                                              25, 118, 210, .24)),
                                      child: Container(
                                        width: width * .3,
                                        height: hight * .01,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          color: Colors.blue,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Register Now",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  void returnData() {
    for (int i = 0; i < users.length; i++) {
      if (_isauth == users[i].userId) {
        index = i;
        WelcomeScreen.indexuser = i;
        setState(() {
          _isloading = false;
          
        });
        break;
      }
    }
  }
}
