import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/screens/add_Home_foreSell.dart';

class CardOfItemAdsOffice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    final office = Provider.of<Office>(context);
    final mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        width: mediaQuery.width,
        height: mediaQuery.height * .25,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: mediaQuery.width * .4,
              height: mediaQuery.height * .25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    office.mainimage,
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              width: mediaQuery.width * .5,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [Text('Title:'), Text(" ${office.title}")],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [Text('Place: '), Text("${office.place}")],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [Text('floor: '), Text("${office.floor}")],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [Text('Area: '), Text("${office.area}")],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [Text('Price: '), Text('${office.price}')],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            color: Colors.grey,
                          ),
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                                AddNewHomeForSell.routename,
                                arguments: office.id);
                          },
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () async {
                            try {
                              await Provider.of<Homes>(context, listen: false)
                                  .deleteProduct(office.id);
                            } catch (error) {
                              // ignore: deprecated_member_use
                              scaffold.showSnackBar(SnackBar(
                                content: Text(
                                  'Deleting Failed!',
                                  textAlign: TextAlign.center,
                                ),
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
