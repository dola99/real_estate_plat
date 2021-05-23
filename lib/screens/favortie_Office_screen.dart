import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/widgets/card_of_ad_view.dart';
import 'package:real_estate/widgets/card_of_item_office.dart';

class FavoriteOffice extends StatefulWidget {
  static const routeName = '/Favorite_Office';

  @override
  _FavoriteOfficeState createState() => _FavoriteOfficeState();
}

class _FavoriteOfficeState extends State<FavoriteOffice> {
  var _isInit = true;

  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Offices>(context).fetchandsetOffices().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final office = Provider.of<Offices>(context);
    final _product = office.favoriteItems;
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites Ads In Home"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: _product.length,
                itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: _product[index],
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
    );
  }
}
