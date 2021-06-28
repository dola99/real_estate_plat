import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/auth.dart';
import 'package:real_estate/screens/login_please.dart';
import 'package:real_estate/screens/page_view_topbanner.dart';
import 'package:real_estate/screens/sellofiice_screen.dart';
import 'package:real_estate/screens/welcome_screen.dart';
import 'package:real_estate/widgets/Row_of_ad.dart';
import 'package:real_estate/widgets/Row_of_ad_imoje.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AdOfOffice extends StatefulWidget {
  final int index;

  AdOfOffice({this.index});

  @override
  _AdOfOfficeState createState() => _AdOfOfficeState();
}

class _AdOfOfficeState extends State<AdOfOffice> {
  List images = [];
  String phoneNumber;
  bool islogin;
  String nameofuser;

  @override
  Widget build(BuildContext context) {
    var office = Selloffice.offices[widget.index];
    returnnumberphone(office.userid);
    final authData = Provider.of<Auth>(context, listen: false);
    imagepanner(
        Selloffice.offices[widget.index].mainimage,
        Selloffice.offices[widget.index].image1,
        Selloffice.offices[widget.index].image2,
        Selloffice.offices[widget.index].image3,
        Selloffice.offices[widget.index].image4,
        Selloffice.offices[widget.index].image5);
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.grey.withOpacity(.2),
          elevation: 0.0,
          title: Text(
            "${office.title}",
            style: TextStyle(fontFamily: "Oswald", fontSize: 20),
          ),
          actions: [
            Center(
              child: ChangeNotifierProvider.value(
                value: office,
                child: IconButton(
                  icon: Icon(Icons.favorite),
                  color: office.isFavorite ? Colors.red : Colors.black,
                  disabledColor: Colors.red,
                  onPressed: () {
                    setState(
                      () {
                        office.toggleFavoriteStatus(
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
                text: office.govermnet,
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
                text: office.place,
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
                text: office.floor.toString(),
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
                text: office.area.toString(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAd(
                widget: Icon(
                  Icons.grid_view,
                  color: Colors.red,
                ),
                title: "Tables",
                text: "${office.counttables.toString()} .EGP",
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
                text: office.countroom.toString(),
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
                text: office.countroom.toString(),
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
                text: office.cashordeposit.toString(),
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
                text: office.buyorrent.toString(),
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
                text: "${office.price.toString()} .EGP",
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
                text: office.electric,
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
                text: office.water,
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
                  text: office.asanser),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RowofAdImoje(
                widget: Icon(
                  Icons.yard,
                  color: Colors.red,
                ),
                title: "Garden",
                text: office.gardern,
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
                text: office.security,
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
                        child: Text(office.description),
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
                      Text(nameofuser ?? 'hidden name'),
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
