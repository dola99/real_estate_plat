import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/providers/office_provider.dart';
import 'package:real_estate/widgets/Card_of_ads_item_office.dart';

class AdsOfClientOffice extends StatefulWidget {
  static const routeName = '/Ads_of_Office';
  @override
  _AdsOfClientOfficeState createState() => _AdsOfClientOfficeState();
}

class _AdsOfClientOfficeState extends State<AdsOfClientOffice> {
    Future<void> _refreshedProducts(BuildContext context) async {
    await Provider.of<Offices>(context, listen: false).fetchandsetOffices(true);
  }

  @override
  Widget build(BuildContext context) {
    //final homesDate = Provider.of<Homes>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Ads Offices"),
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
                    child: Consumer<Offices>(
                      builder: (ctx, officedate, _) => ListView.builder(
                        itemCount: officedate.items.length,
                        itemBuilder: (_, i) => ChangeNotifierProvider.value(
                          value: officedate.items[i],
                          child: CardOfItemAdsOffice(),
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
