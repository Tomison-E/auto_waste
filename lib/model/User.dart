import 'package:flutter/material.dart';

class User {
  String title;
  String subtitle;
  IconData icon;
  String image;
  List<String> items;
  BuildContext context;
  Color menuColor;

  User(
      {this.title,
        this.subtitle,
        this.icon,
        this.image,
        this.items,
        this.context,
        this.menuColor = Colors.black});
}
// adress email number sms notification tag name lastname password
