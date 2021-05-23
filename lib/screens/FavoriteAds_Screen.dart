import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/screens/favorite_home_screen.dart';
import 'package:real_estate/screens/favortie_Office_screen.dart';

class FavoritesAds extends StatelessWidget {
  static const routeName = '/Favorite_ads';
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(" Your Favorite Ads"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(FavoriteHomes.routeName),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: mediaquery.height * .18,
                    width: mediaquery.width * .40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/Home.svg',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Homes",
                      style: TextStyle(fontFamily: 'Oswald'),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(FavoriteOffice.routeName),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: mediaquery.height * .18,
                    width: mediaquery.width * .40,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.2),
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/Office.svg',
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Offices",
                      style: TextStyle(fontFamily: 'Oswald'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
