import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/Users.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/user.dart';
import 'package:real_estate/screens/AdsOfUser_screen.dart';
import 'package:real_estate/screens/Edit_user.dart';
import 'package:real_estate/screens/FavoriteAds_Screen.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import 'package:real_estate/screens/login_please.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';
import 'package:real_estate/screens/welcome_screen.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void didChangeDependencies() {
    Provider.of<Users>(context, listen: false).fetchAndSetUsers();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool _islogin = Provider.of<Auth>(context).isAuth;

    var drawerHeader = UserAccountsDrawerHeader(
      accountName: _islogin
          ? Text(
              "${WelcomeScreen.allusers[WelcomeScreen.indexuser].firstName + ' ' + WelcomeScreen.allusers[WelcomeScreen.indexuser].lastName}")
          : Text(
              "You Need To Login!!!",
              style: TextStyle(color: Colors.red, fontFamily: 'Oswald'),
            ),
      accountEmail: _islogin
          ? Text(
              "${WelcomeScreen.allusers[WelcomeScreen.indexuser].phoneNumber}")
          : Text(
              "join Us Now",
              style: TextStyle(fontFamily: 'Oswald'),
            ),
      currentAccountPicture: _islogin
          ? WelcomeScreen.allusers[WelcomeScreen.indexuser].imageurl != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(
                      WelcomeScreen.allusers[WelcomeScreen.indexuser].imageurl))
              : CircleAvatar()
          : Text(''),
    );
    var drawerItems = ListView(
      children: [
        GestureDetector(
            onTap: () {
              if (_islogin == true) {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(EditUserProfile.routeName,
                    arguments:
                        WelcomeScreen.allusers[WelcomeScreen.indexuser].id);
              } else {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(LoginScreen.routeName);
              }
            },
            child: drawerHeader),
        ListTile(
          leading: Icon(Icons.home),
          title: const Text("Home"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(SellHome.routeName);
          },
        ),
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        ListTile(
          leading: Icon(Icons.work),
          title: const Text("Office"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed(Selloffice.routeName);
          },
        ),
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: const Text("Favorite Items"),
          onTap: () {
            if (_islogin == true) {
              Navigator.of(context).pop();
              Navigator.of(context)
                  .pushReplacementNamed(FavoritesAds.routeName);
            } else {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(LoginPlease.routeName);
            }
          },
        ),
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        ListTile(
          leading: Icon(Icons.edit),
          title: const Text("Your Items"),
          onTap: () {
            if (_islogin == true) {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed(AdsOfUser.routeName);
            } else {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(LoginPlease.routeName);
            }
          },
        ),
        Divider(
          endIndent: 50,
          indent: 50,
        ),
        _islogin
            ? ListTile(
                leading: Icon(Icons.logout),
                title: const Text("LogOut"),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacementNamed('/');

                  // Navigator.of(context)
                  //     .pushReplacementNamed(UserProductsScreen.routeName);
                  Provider.of<Auth>(context, listen: false).logout();
                },
              )
            : Text('')
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }
}
