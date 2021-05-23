import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/providers/real_estate.dart';

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
            SizedBox(
              height: height * .015,
            ),
            Row(
              children: [
                Padding(
                  padding:  EdgeInsets.only(right: 35),
                  child: Container(
                    width: width * .25,
                    child: Center(
                      child: Consumer<Home>(
                        builder: (ctx, home, child) => IconButton(
                          icon: Icon(
                            home.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: Theme.of(context).accentColor,
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
                Container(
                  width: width * .25,
                  child: Center(
                    child: Text("${home.title}"),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    width: width * .25,
                    child: Center(
                      child: Text("${home.govermnet}"),
                    ),
                  ),
                  Container(
                    width: width * .25,
                    child: Center(
                      child: Text("${home.place}"),
                    ),
                  ),
                  Container(
                    width: width * .25,
                    child: Center(
                      child: Text("${home.price}.EG"),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
