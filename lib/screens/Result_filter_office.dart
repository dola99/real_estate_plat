import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/screens/ad_of_office.dart';
import 'package:real_estate/widgets/card_of_item_office.dart';
import 'package:real_estate/widgets/drawer.dart';

class ResultFilterOffice extends StatefulWidget {
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
  final int tablefrom;
  final int tableto;

  ResultFilterOffice(
      {this.goverment,
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
      this.tablefrom,
      this.tableto});

  @override
  _ResultFilterOfficeState createState() => _ResultFilterOfficeState();
}

class _ResultFilterOfficeState extends State<ResultFilterOffice> {
  List<Office> displayoffice = [];
  var _isinit = true;
  var _isLoading = false;
  var _loadedInitData = false;
  @override
  void didChangeDependencies() {
    if (_isinit) {
      setState(() {
        _isLoading = true;
        Provider.of<Offices>(context).fetchandsetOffices().then((_) {
          setState(() {
            _isLoading = true;
          });
        });
      });
    }
    _isinit = false;
    final _avaliableboffice =
        Provider.of<Offices>(context, listen: false).items;
    if (_loadedInitData == false) {
      displayoffice = _avaliableboffice.where((element) {
        return element.govermnet == widget.goverment && widget.place == null
            ? element.place
            : element.place == widget.place &&
                element.buyorrent == widget.buyorsell &&
                element.cashordeposit == widget.pay &&
                element.price >= widget.priceform &&
                element.price <= widget.priceto &&
                element.area >= widget.areafrom &&
                element.area <= widget.areato &&
                element.floor >= widget.floorfrom &&
                element.floor <= widget.floorto &&
                element.countroom >= widget.roomfrom &&
                element.countroom <= widget.roomto &&
                element.counttables >= widget.tablefrom &&
                element.counttables <= widget.tableto;
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
          itemCount: displayoffice.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: displayoffice[index],
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    // ignore: missing_return
                    .push(
                  MaterialPageRoute(
                    builder: (context) => AdOfOffice(
                      index: index,
                    ),
                  ),
                );
              },
              child: CardOfAdViewOffice(
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
