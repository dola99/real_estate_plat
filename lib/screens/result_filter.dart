import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/real_estate.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/screens/ad_of_Home.dart';
import 'package:real_estate/widgets/card_of_ad_view.dart';
import 'package:real_estate/widgets/drawer.dart';

class ResultFilter extends StatefulWidget {
  final String goverment;
  final String place;
  final String pay;
  final String buyorsell;
  final int priceform;
  final int priceto;
  final int areafrom;
  final int areato;
  final int floorfrom;
  final int floorto;
  final int roomfrom;
  final int roomto;

  static const routeName = '/Result_filter';

  ResultFilter({
    this.goverment,
    this.place,
    this.pay,
    this.buyorsell,
    this.priceform,
    this.priceto,
    this.areafrom,
    this.areato,
    this.floorfrom,
    this.floorto,
    this.roomfrom,
    this.roomto,
  });
  @override
  _ResultFilterState createState() => _ResultFilterState();
}

class _ResultFilterState extends State<ResultFilter> {
  List<Home> displayHome = [];
  var _isinit = true;
  var _isLoading = false;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
        Provider.of<Homes>(context).fetchAndSetProducts().then((_) {
          setState(() {
            _isLoading = true;
          });
        });
      });
    }
    _isinit = false;
    final _avaliablebhomes = Provider.of<Homes>(context, listen: false).items;
    if (_loadedInitData == false) {
      displayHome = _avaliablebhomes.where((element) {
        return element.govermnet == widget.goverment && widget.place == null
            ? element.place
            : element.place == widget.place &&
                element.buyorRent == widget.buyorsell &&
                element.cashordespost == widget.pay &&
                element.price >= widget.priceform &&
                element.price <= widget.priceto &&
                element.area >= widget.areafrom &&
                element.area <= widget.areato &&
                element.floor >= widget.floorfrom &&
                element.floor <= widget.floorto &&
                element.countroom >= widget.roomfrom &&
                element.countroom <= widget.roomto;
      }).toList();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'All Home',
              style: TextStyle(
                  fontSize: 17, fontFamily: "Lora", color: Colors.black),
            ),
            Text(
              'Selected Items',
              style: TextStyle(
                  fontSize: 8, fontFamily: "Lora", color: Colors.blue),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(
                Icons.filter_list,
                color: Colors.blue,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
        ],
        elevation: 0.0,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: displayHome.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: displayHome[index],
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    // ignore: missing_return
                    .push(
                  MaterialPageRoute(
                    builder: (context) => AdofHome(
                      index: index,
                    ),
                  ),
                );
              },
              child: CardOfAdView(
                  //  title: _product[index].title,
                  //  goverment: _product[index].govermnet,
                  //  mainimage: _product[index].mainimage,
                  //  place: _product[index].place,
                  //  price: _product[index].price,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
