import 'package:flutter/material.dart';
import 'package:real_estate/screens/login_screen.dart';

class LoginPlease extends StatelessWidget {
  static const routeName = '/LoginFirstPlease';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * .1,
                child: Center(
                  child: Text(
                    "You Must Login First To visit This Page",
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .4,
              child: Image.asset('assets/images/Mobile-login-Cristina.jpg'),
            ),
            SizedBox(
              height: 100,
            ),
            GestureDetector(
              onTap: () => Navigator.of(context)
                  .pushReplacementNamed(LoginScreen.routeName),
              child: Container(
                width: MediaQuery.of(context).size.width * .5,
                height: MediaQuery.of(context).size.height * .06,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue),
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white),
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
