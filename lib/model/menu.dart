import 'package:flutter/material.dart';
import 'User.dart';

class Menu {
  String title;
  IconData icon;
  String image;
  List<String> items;
  BuildContext context;
  Color menuColor;
  User user;

  Menu(
      {this.title,
      this.icon,
      this.image,
      this.items,
        this.user,
      this.context,
      this.menuColor = Colors.black});
}
