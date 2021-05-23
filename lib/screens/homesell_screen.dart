import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/widgets/card_of_ad_view.dart';
import 'package:real_estate/widgets/drawer.dart';
import 'package:real_estate/widgets/floating_action_bar_Home.dart';

class SellHome extends StatefulWidget {
  static const routeName = '/See_all_home';
  static String userid;
  @override
  _SellHomeState createState() => _SellHomeState();
}

class _SellHomeState extends State<SellHome> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Homes>(context, listen: false)
          .fetchAndSetProducts()
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
    await Provider.of<Homes>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final _allhomes = Provider.of<Homes>(context);
    final _product = _allhomes.items.reversed.toList();
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(
          'All Home',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.filter_list), onPressed: () {}),
        ],
        elevation: 0.0,
      ),
      floatingActionButton: FloatingActionBarHome(),
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
