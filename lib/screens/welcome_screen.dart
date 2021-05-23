import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/screens/Signup.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';

// ignore: must_be_immutable
class WelcomeScreen extends StatefulWidget {
  static const routeName = '/WelcomeScreen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  bool _auth = false;
  String id;
  @override
  void didChangeDependencies() {
    String _isauth = Provider.of<Auth>(context, listen: false).userId;
    print(_isauth);
    id = _isauth;
    if (_isauth == null) {
      _auth = false;
    } else {
      _auth = true;
    }
    print(_auth);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print(_auth);
    final width = MediaQuery.of(context).size.width;
    final hight = MediaQuery.of(context).size.height;
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
                ? Text("You Are Already Login In")
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Center(
                      child: Container(
                        width: width * .22,
                        height: hight * .1,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Color.fromRGBO(25, 118, 210, .24)),
                        child: Center(
                          child: Image.asset('assets/images/iconlogin.png'),
                        ),
                      ),
                    ),
                  ),
            SizedBox(
              height: hight * .01,
            ),
            _auth
                ? Text("")
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(LoginScreen.routeName);
                    },
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontFamily: "Oswald", fontSize: 20),
                      ),
                    ),
                  ),
            SizedBox(
              height: hight * .06,
            ),
            _auth
                ? Text("")
                : Text(
                    "Not A Member",
                    style: TextStyle(fontFamily: "Oswald", fontSize: 13),
                  ),
            SizedBox(
              height: hight * .005,
            ),
            _auth
                ? Text("")
                : GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(SignUpScreen.routeName);
                    },
                    child: Center(
                      child: Container(
                        width: width * .50,
                        height: hight * .07,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Color.fromRGBO(25, 118, 210, .24)),
                        child: Container(
                          width: width * .3,
                          height: hight * .01,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70),
                            color: Colors.blue,
                          ),
                          child: Center(
                            child: Text(
                              "Register Now",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
