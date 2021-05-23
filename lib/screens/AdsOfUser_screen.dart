import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:real_estate/screens/Ads_Of_Client_Office.dart';
import 'package:real_estate/screens/Ads_Of_Client_home.dart';

class AdsOfUser extends StatelessWidget {
  static const routeName = 'Ads_Of_user';
  @override
  Widget build(BuildContext context) {
    final mediaquery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ads"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AdsOfYourHomes.routeName),
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
                      "Ads Of Homes",
                      style: TextStyle(fontFamily: 'Oswald'),
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () =>
                  Navigator.of(context).pushNamed(AdsOfClientOffice.routeName),
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
                      "Ads Of Offices",
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
