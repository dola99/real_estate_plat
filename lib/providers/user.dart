import 'package:flutter/material.dart';

class User with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String userId;
  final String imageurl;
  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.phoneNumber,
      this.userId,
      this.imageurl});
}
