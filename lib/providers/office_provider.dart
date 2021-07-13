import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/http_exception.dart';
import 'office.dart';
import 'package:http/http.dart' as http;

class Offices with ChangeNotifier {
  List<Office> _items = [];
  final String authToken;
  final String userId;

  Offices(this.authToken, this.userId, this._items);
  List<Office> get items {
    return [..._items];
  }

  List<Office> get favoriteItems {
    return _items.where((element) => element.isFavorite).toList();
  }

  Office findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchandsetOffices([bool filterByUser = false]) async {
    final filterString = filterByUser
      ? '?auth=$authToken&orderBy="creatorId"&equalTo="$userId"'
      : '';

    var url =
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Offices.json$filterString';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      url =
          'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/Offices/$userId.json?auth=$authToken';
      final favoriteResponse = await http.get(url);
      final favoriteData = json.decode(favoriteResponse.body);
      final List<Office> loadedoffice = [];
      extractedData.forEach((prodId, prodData) {
        loadedoffice.add(Office(
          id: prodId,
          adcount: prodData['AdCount'],
          area: prodData['Area'],
          asanser: prodData['Asanser'],
          countroom: prodData['CountRooms'],
          counttables: prodData['CountOfTable'],
          countwc: prodData['CountWc'],
          electric: prodData['Electric'],
          floor: prodData['Floor'],
          gardern: prodData['Garden'],
          buyorrent: prodData['BuyOrRent'],
          cashordeposit: prodData['CashorDepost'],
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
      _items = loadedoffice;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addproduct(Office office) async {
    var url =
        "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Offices.json?auth=$authToken";
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'AdCount': office.adcount,
          'Area': office.area,
          'Asanser': office.asanser,
          'CountRooms': office.countroom,
          'CountWc': office.countwc,
          'Electric': office.electric,
          'Floor': office.floor,
          'Garden': office.gardern,
          'CountOfTable': office.counttables,
          'Goverment': office.govermnet,
          'imageUrl': office.mainimage,
          'Image1': office.image1,
          'Image2': office.image2,
          'Image3': office.image3,
          'Image4': office.image4,
          'Image5': office.image5,
          'creatorId': userId,
          'BuyOrRent': office.buyorrent,
          'CashorDepost': office.cashordeposit,
          'Place': office.place,
          'Security': office.security,
          'Views': office.views,
          'Water': office.water,
          'title': office.title,
          'description': office.description,
          'price': office.price,
          'isFavorite': office.isFavorite,
        }),
      );
      final newOffice = Office(
        adcount: office.adcount,
        area: office.area,
        asanser: office.asanser,
        countroom: office.countroom,
        countwc: office.countwc,
        electric: office.electric,
        floor: office.floor,
        gardern: office.gardern,
        buyorrent: office.buyorrent,
        cashordeposit: office.cashordeposit,
        counttables: office.counttables,
        govermnet: office.govermnet,
        place: office.place,
        security: office.security,
        views: office.views,
        water: office.water,
        title: office.title,
        description: office.description,
        mainimage: office.mainimage,
        image1: office.image1,
        image2: office.image2,
        image3: office.image3,
        image4: office.image4,
        image5: office.image5,
        price: office.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newOffice);
      //items.insert(0, newproduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateproduct(String id, Office newOffice) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Offices/$id.json?auth=$authToken";
      await http.patch(url,
          body: json.encode({
            'AdCount': newOffice.adcount,
            'Area': newOffice.area,
            'Asanser': newOffice.asanser,
            'CountRooms': newOffice.countroom,
            'CountWc': newOffice.countwc,
            'Electric': newOffice.electric,
            'Floor': newOffice.floor,
            'Garden': newOffice.gardern,
            'CountOfTable': newOffice.counttables,
            'Goverment': newOffice.govermnet,
            'Place': newOffice.place,
            'Security': newOffice.security,
            'Views': newOffice.views,
            'Water': newOffice.water,
            'BuyOrRent': newOffice.buyorrent,
            'CashorDepost': newOffice.cashordeposit,
            'title': newOffice.title,
            'description': newOffice.description,
            'imageUrl': newOffice.mainimage,
            'Image1': newOffice.image1,
            'Image2': newOffice.image2,
            'Image3': newOffice.image3,
            'Image4': newOffice.image4,
            'Image5': newOffice.image5,
            'price': newOffice.price,
          }));
      _items[prodIndex] = newOffice;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> deleteProduct(String id) async {
    final url =
        "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Offices/$id.json?auth=$authToken";
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
