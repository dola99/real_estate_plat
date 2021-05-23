import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/widgets/card_of_ad_view.dart';

class FavoriteHomes extends StatefulWidget {
  static const routeName = '/Favorite_Homes';

  @override
  _FavoriteHomesState createState() => _FavoriteHomesState();
}

class _FavoriteHomesState extends State<FavoriteHomes> {
  var _isInit = true;

  var _isLoading = false;

  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Homes>(context).fetchAndSetProducts().then((_) {
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
    final homes = Provider.of<Homes>(context);
    final _product = homes.favoriteItems;
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
    );
  }
}
