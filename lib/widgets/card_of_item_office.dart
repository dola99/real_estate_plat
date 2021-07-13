import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/office.dart';

class CardOfAdViewOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final office = Provider.of<Office>(context);
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
                      office.mainimage,
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
                      child: Consumer<Office>(
                        builder: (ctx, office, child) => IconButton(
                          icon: Icon(Icons.favorite),
                          color: office.isFavorite ? Colors.red : Colors.white,
                          disabledColor: Colors.red,
                          onPressed: () {
                            office.toggleFavoriteStatus(
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
                    child: Center(
                      child: Text("${office.title}",
                          style: TextStyle(fontFamily: "Lora", fontSize: 15)),
                    ),
                  ),
                ),
                Container(
                  width: width * .35,
                  child: Center(
                    child: Text(
                      "${office.price}.EG",
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
                    child: Center(
                      child: Text(
                        "${office.govermnet}",
                        style: TextStyle(
                            fontFamily: "Oswald",
                            fontSize: 13,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: width * .30,
                  child: Center(
                    child: Text(
                      "${office.place}",
                      style: TextStyle(
                          fontFamily: "Oswald",
                          fontSize: 13,
                          color: Colors.grey),
                    ),
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
                      "${office.area}",
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
                      "${office.countroom}",
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
                      "${office.countwc}",
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
                      'assets/images/table.svg',
                      color: Colors.grey,
                    ),
                  ),
                ),
                Container(
                  width: width * .05,
                  child: Center(
                    child: Text(
                      "${office.counttables}",
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
