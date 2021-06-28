import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/screens/ad_of_office.dart';
import 'package:real_estate/screens/filter_screen_office.dart';

import 'package:real_estate/widgets/card_of_item_office.dart';
import 'package:real_estate/widgets/drawer.dart';

import 'package:real_estate/widgets/floating_action_bar_office.dart';

class Selloffice extends StatefulWidget {
  static const routeName = '/Sell_office_screen';
  static String userid;
  static List<Office> offices = [];
  @override
  _SellofficeState createState() => _SellofficeState();
}

class _SellofficeState extends State<Selloffice> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Offices>(context, listen: false)
          .fetchandsetOffices()
          .then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _refreshedProducts(BuildContext context) async {
    await Provider.of<Offices>(context, listen: false).fetchandsetOffices();
  }

  @override
  Widget build(BuildContext context) {
    final _alloffices = Provider.of<Offices>(context);
    final _product = _alloffices.items.reversed.toList();
    Selloffice.offices = _product;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'All Office',
              style: TextStyle(
                  fontSize: 17, fontFamily: "Lora", color: Colors.black),
            ),
            Text(
              'All Selected',
              style: TextStyle(
                  fontSize: 8, fontFamily: "Lora", color: Colors.black),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.filter_list),
              onPressed: () {
                Navigator.of(context).pushNamed(FilterScreenOffice.routeName);
              }),
        ],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionBarOffice(),
      body: RefreshIndicator(
        onRefresh: () => _refreshedProducts(context),
        child: SafeArea(
          child: _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemCount: _product.length,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: _product[index],
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
      ),
    );
  }
}
