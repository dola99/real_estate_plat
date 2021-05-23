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

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  int index;
  @override
  void didChangeDependencies() {
    Provider.of<Users>(context, listen: false).fetchAndSetUsers();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    bool _islogin = Provider.of<Auth>(context).isAuth;
    var users = Provider.of<Users>(context, listen: false).items;
    returnData(users);

    var drawerHeader = UserAccountsDrawerHeader(
      accountName: _islogin
          ? Text("${users[index].firstName + ' ' + users[index].lastName}")
          : Text(
              "You Need To Login!!!",
              style: TextStyle(color: Colors.red, fontFamily: 'Oswald'),
            ),
      accountEmail: _islogin
          ? Text("${users[index].phoneNumber}")
          : Text(
              "join Us Now",
              style: TextStyle(fontFamily: 'Oswald'),
            ),
      currentAccountPicture: _islogin
          ? users[index].imageurl != null
              ? CircleAvatar(
                  backgroundColor: Colors.white,
                  backgroundImage: NetworkImage(users[index].imageurl))
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
                    arguments: users[index].id);
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
        ListTile(
          leading: Icon(Icons.logout),
          title: const Text("LogOut"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');

            // Navigator.of(context)
            //     .pushReplacementNamed(UserProductsScreen.routeName);
            Provider.of<Auth>(context, listen: false).logout();
          },
        ),
      ],
    );
    return Drawer(
      child: drawerItems,
    );
  }

  int returnData(List<User> users) {
    final id = Provider.of<Auth>(context, listen: false).userId;
    if (id != null) {
      for (int i = 0; i < users.length; i++) {
        if (id == users[i].userId) {
          print(i);
          index = i;
        }
      }
    } else {
      return null;
    }
  }
}
