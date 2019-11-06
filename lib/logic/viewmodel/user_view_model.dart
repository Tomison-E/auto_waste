import 'package:flutter/material.dart';
import 'package:auto_waste/model/User.dart';
import 'package:auto_waste/utils/uidata.dart';

class UserViewModel {
  List<User> users;

  UserViewModel({this.users});

  getMenuItems() {
    return users = <User>[
      User(
          title: "ESAN OLUWATOMISIN",
          subtitle: "SOFTWARE ENGINEER",
          icon: Icons.person,
          image: UIData.user1,
          items: ["www.Tomisin.com/about", "08166569680", "www.Github.com/Tomsin","Ibadan North", "tomiesan@yahoo.com","facebook.com/tomisin"]),

      User(
          title: "SANYA",
          subtitle: "WEB DEVELOPER",
          icon: Icons.person,
          image: UIData.user2,
          items: ["www.Sanya.com/about", "08166569680", "www.Github.com/Sanya","Ibadan North", "Sanya@yahoo.com","facebook.com/Sanya"]),

    User(
    title: "GEORGE",
    subtitle: "FRONT END DEVELOPER",
    icon: Icons.person,
    image: UIData.user3,
    items: ["www.George.com/about", "08166569680", "www.Github.com/George","Ibadan North", "george@yahoo.com","facebook.com/george"]),

      User(
          title: "YUSUF",
          subtitle: "SERVER ENGINEER",
          icon: Icons.person,
          image: UIData.user4,
          items: ["www.Yusuf.com/about", "08166569680", "www.Github.com/Yusuf","Ibadan North", "Yusuf@yahoo.com","facebook.com/Yusuf"]),

    ];
  }
}
