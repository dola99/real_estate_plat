import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;

class Office with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  String govermnet;
  String place;
  String cashordeposit;
  String buyorrent;
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
  bool asanser;
  bool security;
  bool electric;
  bool water;
  bool gardern;
  int counttables;
  String userid;
  bool isFavorite;
  Office(
      {this.id,
      this.title,
      this.description,
      this.govermnet,
      this.place,
      this.area,
      this.cashordeposit,
      this.buyorrent,
      this.countroom,
      this.price,
      this.floor,
      this.views,
      this.adcount,
      this.asanser = false,
      this.counttables,
      this.countwc,
      this.image1,
      this.image2,
      this.image3,
      this.image4,
      this.image5,
      this.mainimage,
      this.electric = false,
      this.gardern = false,
      this.security = false,
      this.water,
      this.userid,
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
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/userFavorites/Offices/$userId/$id.json?auth=$token';
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
