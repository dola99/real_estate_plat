import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/screens/homesell_screen.dart';
import 'package:real_estate/screens/login_please.dart';
import 'package:real_estate/screens/page_view_topbanner.dart';
import 'package:real_estate/screens/welcome_screen.dart';
import 'package:real_estate/widgets/Row_of_ad.dart';
import 'package:real_estate/widgets/Row_of_ad_imoje.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AdofHome extends StatefulWidget {
  static const routeName = "Ad_Of_Home";
  final int index;

  AdofHome({this.index});

  @override
  _AdofHomeState createState() => _AdofHomeState();
}

class _AdofHomeState extends State<AdofHome> {
  
  List images = [];
  String phoneNumber;
  bool islogin;
  String nameofuser;
  @override
  Widget build(BuildContext context) {
    var home = SellHome.homes[widget.index];
    returnnumberphone(home.userid);
    final authData = Provider.of<Auth>(context, listen: false);
    imagepanner(
        SellHome.homes[widget.index].mainimage,
        SellHome.homes[widget.index].image1,
        SellHome.homes[widget.index].image2,
        SellHome.homes[widget.index].image3,
        SellHome.homes[widget.index].image4,
        SellHome.homes[widget.index].image5);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.2),
          elevation: 0.0,
          title: Text(
            "${home.title}",
            style: TextStyle(fontFamily: "Oswald", fontSize: 20),
          ),
          actions: [
            Center(
              child: ChangeNotifierProvider.value(
                value: home,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  color: home.isFavorite ? Colors.red : Colors.black,
                  disabledColor: Colors.red,
                  onPressed: () {
                    setState(
                      () {
                        home.toggleFavoriteStatus(
                          authData.token,
                          authData.userId,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: height * .32,
              child: Stack(
                children: [
                  Container(
                    height: height * .30,
                    child: PageviewBanner(),
                  ),
                  
                ],
              ),
            ),
            Text("Description"),
            SizedBox(
              height: 5,
            ),
            Divider(
              indent: 50,
              endIndent: 50,
              thickness: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.place,
                  color: Colors.red,
                ),
                title: "govermnet",
                text: home.govermnet,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.push_pin,
                  color: Colors.red,
                ),
                title: "Place",
                text: home.place,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.menu,
                  color: Colors.red,
                ),
                title: "Floor",
                text: home.floor.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.architecture,
                  color: Colors.red,
                ),
                title: "Area (cm2)",
                text: home.area.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.meeting_room,
                  color: Colors.red,
                ),
                title: "Rooms",
                text: home.countroom.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.shower,
                  color: Colors.red,
                ),
                title: "Wc",
                text: home.countroom.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.paid,
                  color: Colors.red,
                ),
                title: "Paid",
                text: home.cashordespost.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.sell,
                  color: Colors.red,
                ),
                title: "Sell Or Rent",
                text: home.buyorRent.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.money,
                  color: Colors.red,
                ),
                title: "Price",
                text: "${home.price.toString()} .EGP",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.tungsten,
                  color: Colors.red,
                ),
                title: "Electric",
                text: home.electric,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                ),
                title: "Gas",
                text: home.gas,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.water,
                  color: Colors.red,
                ),
                title: "Water",
                text: home.water,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                  widget: Icon(
                    Icons.elevator,
                    color: Colors.red,
                  ),
                  title: "Elevator",
                  text: home.asanser),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.yard,
                  color: Colors.red,
                ),
                title: "Garden",
                text: home.gardern,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.security,
                  color: Colors.red,
                ),
                title: "Security",
                text: home.security,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: height * .30,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.200),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Icon(
                              Icons.description,
                              color: Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4.0, top: 7),
                            child: Text(
                              "Description ",
                              style: TextStyle(fontFamily: "Oswald"),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(home.description),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: height * .10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Seller Name :'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(nameofuser??'hidden name'),
                      IconButton(
                          onPressed: () {
                            WelcomeScreen.indexuser != null
                                ? UrlLauncher.launch("tel:$phoneNumber")
                                : Navigator.of(context)
                                    .pushNamed(LoginPlease.routeName);
                          },
                          icon: Icon(
                            Icons.call,
                            color: WelcomeScreen.indexuser != null
                                ? Colors.green
                                : Colors.black,
                          ))
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void imagepanner(String mainimages, String images1, String images2,
      String images3, String images4, String images5) {
    images = [];
    if (mainimages != null) {
      images.add(mainimages);
    }
    if (images1 != null) {
      images.add(images1);
    }
    if (images2 != null) {
      images.add(images2);
    }
    if (images3 != null) {
      images.add(images3);
    }
    if (images4 != null) {
      images.add(images4);
    }
    if (images5 != null) {
      images.add(images5);
    }
    PageviewBanner.imagess = images;
    print(images);
  }

  void returnnumberphone(String id) {
    for (int i = 0; i < WelcomeScreen.allusers.length; i++) {
      if (WelcomeScreen.allusers[i].userId == id) {
        phoneNumber = WelcomeScreen.allusers[i].phoneNumber;
        nameofuser = WelcomeScreen.allusers[i].firstName +
            ' ' +
            WelcomeScreen.allusers[i].lastName;
        print(nameofuser);
        break;
      }
    }
  }
}
