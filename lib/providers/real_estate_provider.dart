import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'real_estate.dart';
import 'package:http/http.dart' as http;

class Homes with ChangeNotifier {
  List<Home> _items = [];
  final String authToken;
  final String userId;

  Homes(this.authToken, this.userId, this._items);
  List<Home> get items {
    return [..._items];
  }

  List<Home> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Home findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchAndSetProducts([bool filterByUser = false]) async {
    final filterString = filterByUser
        ? '?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'
        : '';

    var url =
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Homes.json$filterString';

    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/Homes/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Home> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Home(
          id: prodId,
          adcount: prodData['AdCount'],
          area: prodData['Area'],
          asanser: prodData['Asanser'],
          countroom: prodData['CountRooms'],
          countwc: prodData['CountWc'],
          electric: prodData['Electric'],
          floor: prodData['Floor'],
          gardern: prodData['Garden'],
          buyorRent: prodData['BuyOrRent'],
          cashordespost: prodData['CashorDepost'],
          gas: prodData['Gas'],
          govermnet: prodData['Goverment'],
          place: prodData['Place'],
          security: prodData['Security'],
          views: prodData['Views'],
          water: prodData['Water'],
          title: prodData['title'],
          description: prodData['description'],
          price: prodData['price'],
          mainimage: prodData['imageUrl'],
          image1: prodData['Image1'],
          image2: prodData['Image2'],
          image3: prodData['Image3'],
          image4: prodData['Image4'],
          image5: prodData['Image5'],
          isFavorite:
              favoriteData == null ? false : favoriteData[prodId] ?? false,
        ));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addproduct(Home home) async {
    var url =
        "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Homes.json?auth=$authToken";
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'AdCount': home.adcount,
          'Area': home.area,
          'Asanser': home.asanser,
          'CountRooms': home.countroom,
          'CountWc': home.countwc,
          'Electric': home.electric,
          'Floor': home.floor,
          'Garden': home.gardern,
          'Gas': home.gas,
          'Goverment': home.govermnet,
          'imageUrl': home.mainimage,
          'Image1': home.image1,
          'Image2': home.image2,
          'Image3': home.image3,
          'Image4': home.image4,
          'Image5': home.image5,
          'creatorId': userId,
          'BuyOrRent': home.buyorRent,
          'CashorDepost': home.cashordespost,
          'Place': home.place,
          'Security': home.security,
          'Views': home.views,
          'Water': home.water,
          'title': home.title,
          'description': home.description,
          'price': home.price,
          'isFavorite': home.isFavorite,
        }),
      );
      final newHome = Home(
        adcount: home.adcount,
        area: home.area,
        asanser: home.asanser,
        countroom: home.countroom,
        countwc: home.countwc,
        electric: home.electric,
        floor: home.floor,
        gardern: home.gardern,
        buyorRent: home.buyorRent,
        cashordespost: home.cashordespost,
        gas: home.gas,
        govermnet: home.govermnet,
        place: home.place,
        security: home.security,
        views: home.views,
        water: home.water,
        title: home.title,
        description: home.description,
        mainimage: home.mainimage,
        image1: home.image1,
        image2: home.image2,
        image3: home.image3,
        image4: home.image4,
        image5: home.image5,
        price: home.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newHome);
      //items.insert(0, newproduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateproduct(String id, Home newHome) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Homes/$id.json?auth=$authToken";
      await http.patch(url,
          body: json.encode({
            'AdCount': newHome.adcount,
            'Area': newHome.area,
            'Asanser': newHome.asanser,
            'CountRooms': newHome.countroom,
            'CountWc': newHome.countwc,
            'Electric': newHome.electric,
            'Floor': newHome.floor,
            'Garden': newHome.gardern,
            'Gas': newHome.gas,
            'Goverment': newHome.govermnet,
            'Place': newHome.place,
            'Security': newHome.security,
            'Views': newHome.views,
            'Water': newHome.water,
            'BuyOrRent': newHome.buyorRent,
            'CashorDepost': newHome.cashordespost,
            'title': newHome.title,
            'description': newHome.description,
            'imageUrl': newHome.mainimage,
            'Image1': newHome.image1,
            'Image2': newHome.image2,
            'Image3': newHome.image3,
            'Image4': newHome.image4,
            'Image5': newHome.image5,
            'price': newHome.price,
          }));
      _items[prodIndex] = newHome;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Homes/$id.json?auth=$authToken";
    final exsitingProductInedx = _items.indexWhere((prod) => prod.id == id);
    var existingProduct = _items[exsitingProductInedx];
    _items.elementAt(exsitingProductInedx);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(exsitingProductInedx, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete Product.');
    }
    existingProduct = null;
  }
}
