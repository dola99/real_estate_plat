import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/screens/add_office_foreSell_screen.dart';
import 'package:real_estate/screens/login_please.dart';
import '../providers/auth.dart';

class FloatingActionBarOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var id = Provider.of<Auth>(context).isAuth;
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        id == true
            ? Navigator.of(context).pushNamed(AddOfficeForSell.routeName)
            : Navigator.of(context).pushNamed(LoginPlease.routeName);
      },
    );
  }
}
