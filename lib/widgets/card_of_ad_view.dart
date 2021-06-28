import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/real_estate.dart';
import 'package:real_estate/screens/ad_of_Home.dart';

class CardOfAdView extends StatelessWidget {
//  final String id;
//  final String title;
//  final String mainimage;
//  final String goverment;
//  final String place;
//  final double price;
//  CardOfAdView(
//      {this.id,
//      this.title,
//      this.mainimage,
//      this.goverment,
//      this.place,
//      this.price});
  @override
  Widget build(BuildContext context) {
    final home = Provider.of<Home>(context);
    final authData = Provider.of<Auth>(context, listen: false);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        width: width,
        height: height * .25,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.grey.withOpacity(.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: width,
                  height: height * .14,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: Image.network(
                      home.mainimage,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: width * .20,
                    child: Center(
                      child: Consumer<Home>(
                        builder: (ctx, home, child) => IconButton(
                          icon: Icon(Icons.favorite),
                          color: home.isFavorite ? Colors.red : Colors.white,
                          disabledColor: Colors.red,
                          onPressed: () {
                            home.toggleFavoriteStatus(
                              authData.token,
                              authData.userId,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: height * .015,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * .03),
                  child: Container(
                    width: width * .40,
                    child: Text(
                      "${home.title}",
                      style: TextStyle(fontFamily: "Lora", fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  width: width * .35,
                  child: Center(
                    child: Text(
                      "${home.price}.EGP",
                      style: TextStyle(fontFamily: "Lora", fontSize: 13),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * .03),
                  child: Container(
                    width: width * .25,
                    child: Text(
                      "${home.govermnet}",
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 13,
                          color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  width: width * .30,
                  child: Text(
                    "${home.place}",
                    style: TextStyle(
                        fontFamily: "Oswald",
                        fontSize: 13,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * .01),
                  child: Container(
                    width: width * .09,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/images/area.svg',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width * .07,
                  child: Center(
                    child: Text(
                      "${home.area}",
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: width * .09,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/room.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  width: width * .05,
                  child: Center(
                    child: Text(
                      "${home.countroom}",
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                ),
                Container(
                  width: width * .09,
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/images/wc.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  width: width * .05,
                  child: Center(
                    child: Text(
                      "${home.countwc}",
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 13,
                          color: Colors.black),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
