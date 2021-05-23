import 'package:flutter/material.dart';
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
            SizedBox(
              height: height * .015,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 35),
                  child: Container(
                    width: width * .25,
                    child: Center(
                      child: Consumer<Office>(
                        builder: (ctx, office, child) => IconButton(
                          icon: Icon(
                            office.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                          ),
                          color: Theme.of(context).accentColor,
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
                Container(
                  width: width * .25,
                  child: Center(
                    child: Text("${office.title}"),
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
                      child: Text("${office.govermnet}"),
                    ),
                  ),
                  Container(
                    width: width * .25,
                    child: Center(
                      child: Text("${office.place}"),
                    ),
                  ),
                  Container(
                    width: width * .25,
                    child: Center(
                      child: Text("${office.price}.EG"),
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
