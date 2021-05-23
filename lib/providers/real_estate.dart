import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Home with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  String govermnet;
  String place;
  String cashordespost;
  String buyorRent;
  final double price;
  final int floor;
  final int area;
  final int countroom;
  final int countwc;
  int adcount;
  int views;
  String image1;
  String image2;
  String image3;
  String image4;
  String image5;
  String mainimage;
  bool gas;
  bool asanser;
  bool security;
  bool electric;
  bool water;
  bool gardern;

  bool isFavorite;

  Home(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.mainimage,
      @required this.price,
      this.govermnet,
      this.place,
      this.cashordespost,
      this.buyorRent,
      this.adcount,
      this.area,
      this.asanser,
      this.countroom,
      this.countwc,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.electric = false,
      this.floor,
      this.gardern = false,
      this.gas = false,
      this.security = false,
      this.views,
      this.water,
      this.isFavorite = false});

  void _setFavValue(bool newValue) {
    isFavorite = newValue;
    notifyListeners();
  }

  Future<void> toggleFavoriteStatus(String token, String userId) async {
    final oldStatus = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    final url =
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/Homes/$userId/$id.json?auth=$token';
    try {
      final response = await http.put(
        url,
        body: json.encode(
          isFavorite,
        ),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }
}
