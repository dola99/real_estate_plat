import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/real_estate_provider.dart';
import 'package:real_estate/widgets/card_of_ads_item.dart';

class AdsOfYourHomes extends StatefulWidget {
  static const routeName = '/Ads_Of_Your_Homes';
  @override
  _AdsOfYourHomesState createState() => _AdsOfYourHomesState();
}

class _AdsOfYourHomesState extends State<AdsOfYourHomes> {
  Future<void> _refreshedProducts(BuildContext context) async {
    await Provider.of<Homes>(context, listen: false).fetchAndSetProducts(true);
  }

  @override
  Widget build(BuildContext context) {
    //final homesDate = Provider.of<Homes>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ads Homes"),
        centerTitle: true,
        elevation: 0.0,
      ),
      body: FutureBuilder(
        future: _refreshedProducts(context),
        builder: (ctx, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: () => _refreshedProducts(context),
                    child: Consumer<Homes>(
                      builder: (ctx, homesDate, _) => ListView.builder(
                        itemCount: homesDate.items.length,
                        itemBuilder: (_, i) => ChangeNotifierProvider.value(
                          value: homesDate.items[i],
                          child: CardOfItemAds(),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
