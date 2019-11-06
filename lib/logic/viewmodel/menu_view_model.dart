import 'package:flutter/material.dart';
import 'package:auto_waste/model/User.dart';
import 'package:auto_waste/model/menu.dart';
import 'package:auto_waste/utils/uidata.dart';
import 'user_view_model.dart';
class MenuViewModel {
  List<Menu> menuItems;
  List<User> users = new UserViewModel().getMenuItems();
  MenuViewModel({this.menuItems});

  getMenuItems() {
    return menuItems = <Menu>[
      Menu(
          title: "ESAN OLUWATOMISIN",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.user1,
          user:users[0],
          items: ["Profile", "Dashboard", "Contact","Tweets", "Credit Card"]),
      Menu(
          title: "SANYA",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.user2,
          user:users[1],
          items: ["Profile", "Dashboard", "Contact","Tweets", "Credit Card"]),
      Menu(
          title: "GEORGE",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.user3,
          user:users[2],
          items: ["Profile", "Dashboard", "Contact","Tweets", "Credit Card"]),
      Menu(
          title: "YUSUF",
          menuColor: Color(0xff050505),
          icon: Icons.person,
          image: UIData.user4,
          user:users[3],
          items: ["Profile", "Dashboard", "Contact","Tweets", "Credit Card"]),

    ];
  }
}
