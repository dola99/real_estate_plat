import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/Users.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/providers/open_apps.dart';
import 'package:real_estate/providers/real_estate.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/screens/AdsOfUser_screen.dart';
import 'package:real_estate/screens/Ads_Of_Client_Office.dart';
import 'package:real_estate/screens/Ads_Of_Client_home.dart';
import 'package:real_estate/screens/Edit_user.dart';
import 'package:real_estate/screens/FavoriteAds_Screen.dart';
import 'package:real_estate/screens/Signup.dart';
import 'package:real_estate/screens/ad_of_Home.dart';
import 'package:real_estate/screens/add_Home_foreSell.dart';
import 'package:real_estate/screens/add_office_foreSell_screen.dart';
import 'package:real_estate/screens/favorite_home_screen.dart';
import 'package:real_estate/screens/favortie_Office_screen.dart';
import 'package:real_estate/screens/filter_screen.dart';
import 'package:real_estate/screens/filter_screen_office.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import 'package:real_estate/screens/login_screen.dart';
import 'package:real_estate/screens/login_please.dart';
import 'package:real_estate/screens/result_filter.dart';
import 'package:real_estate/screens/second_signup.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';
import 'package:real_estate/screens/welcome_screen.dart';
import './screens/ad_of_Home.dart';

void main() {
  runApp(StartPoint());
}

class StartPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        // ignore: missing_required_param
        //ChangeNotifierProvider.value(value: Home()),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Users>(
          update: (ctx, auth, allusers) => Users(
            auth.token,
            auth.userId,
            allusers == null ? [] : allusers.items,
          ),
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Homes>(
          update: (ctx, auth, previousHomes) {
            return Homes(
              auth.token,
              auth.userId,
              previousHomes == null ? [] : previousHomes.items,
            );
          },
        ),
        // ignore: missing_required_param
        ChangeNotifierProxyProvider<Auth, Offices>(
          update: (ctx, auth, previousHomes) {
            return Offices(
              auth.token,
              auth.userId,
              previousHomes == null ? [] : previousHomes.items,
            );
          },
        ),
        ChangeNotifierProvider(
          create: (context) => OpenApps(),
        ),
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) {
        print(auth.isAuth);
        print(auth.tryAutoLogin());
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Plat App",
            theme: ThemeData(
                primaryColor: Colors.white,
                accentColor: Colors.black,
                fontFamily: 'LoraM'),
            home: auth.isAuth
                ? WelcomeScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, authResultSnapShot) =>
                        authResultSnapShot.connectionState ==
                                ConnectionState.waiting
                            ? Scaffold(
                                body: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : WelcomeScreen()),
            routes: {
              WelcomeScreen.routeName: (ctx) => WelcomeScreen(),
              LoginScreen.routeName: (ctx) => LoginScreen(),
              SignUpScreen.routeName: (ctx) => SignUpScreen(),
              SellHome.routeName: (ctx) => SellHome(),
              EditUserProfile.routeName: (ctx) => EditUserProfile(),
              Selloffice.routeName: (ctx) => Selloffice(),
              AddNewHomeForSell.routename: (ctx) => AddNewHomeForSell(),
              SecondStepSignUp.routeName: (ctx) => SecondStepSignUp(),
              LoginPlease.routeName: (ctx) => LoginPlease(),
              FavoritesAds.routeName: (ctx) => FavoritesAds(),
              FavoriteHomes.routeName: (ctx) => FavoriteHomes(),
              FavoriteOffice.routeName: (ctx) => FavoriteOffice(),
              AdsOfUser.routeName: (ctx) => AdsOfUser(),
              AdsOfYourHomes.routeName: (ctx) => AdsOfYourHomes(),
              AdsOfClientOffice.routeName: (ctx) => AdsOfClientOffice(),
              AddOfficeForSell.routeName: (ctx) => AddOfficeForSell(),
              AdofHome.routeName: (ctx) => AdofHome(),
              FilterScreen.routeName: (ctx) => FilterScreen(),
              FilterScreenOffice.routeName: (ctx) => FilterScreenOffice(),
              ResultFilter.routeName: (ctx) => ResultFilter(),
            });
      }),
    );
  }
}
