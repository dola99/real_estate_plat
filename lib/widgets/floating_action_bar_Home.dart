import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/screens/add_Home_foreSell.dart';
import 'package:real_estate/screens/login_please.dart';
import 'package:real_estate/screens/welcome_screen.dart';

class FloatingActionBarHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        WelcomeScreen.indexuser != null
            ? Navigator.of(context).pushNamed(AddNewHomeForSell.routename)
            : Navigator.of(context).pushNamed(LoginPlease.routeName);
      },
    );
  }
}
