import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:real_estate/models/http_exception.dart';
import 'package:real_estate/providers/user.dart';
import 'package:http/http.dart' as http;

class Users with ChangeNotifier {
  List<User> _items = [];
  final String authToken;
  final String userId;

  Users(this.authToken, this.userId, this._items);
  List<User> get items {
    return [..._items];
  }

  User findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetUsers() async {
    var url =
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Users.json';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<User> loadedProductsss = [];
      extractedData.forEach((prodId, userdata) {
        loadedProductsss.add(User(
            id: prodId,
            firstName: userdata['FirstName'],
            lastName: userdata['LastName'],
            phoneNumber: userdata['PhoneNumber'],
            imageurl: userdata['ImageUrl'],
            userId: userdata['UserId']));
      });
      _items = loadedProductsss;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addUser(User user) async {
    var url =
        'https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Users.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'FirstName': user.firstName,
          'LastName': user.lastName,
          'PhoneNumber': user.phoneNumber,
          'ImageUrl': user.imageurl,
          'UserId': userId,
        }),
      );
      final newproduct = User(
        id: json.decode(response.body)['FirstName'],
        firstName: user.firstName,
        lastName: user.lastName,
        phoneNumber: user.phoneNumber,
        imageurl: user.imageurl,
      );
      _items.add(newproduct);
      //items.insert(0, newproduct);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  void updateUser(String id, User newUser) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex >= 0) {
      final url =
          "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Users/$id.json?auth=$authToken";
      await http.patch(url,
          body: json.encode({
            'FirstName': newUser.firstName,
            'LastName': newUser.lastName,
            'PhoneNumber': newUser.phoneNumber,
            'ImageUrl': newUser.imageurl,
          }));
      _items[prodIndex] = newUser;
      notifyListeners();
    } else {
      print("...");
    }
  }

  Future<void> deleteUser(String id) async {
    final url =
        "https://plat-3f2e7-default-rtdb.europe-west1.firebasedatabase.app/Users/$id.json";
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
