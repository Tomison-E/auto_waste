import 'package:flutter/material.dart';
import 'package:auto_waste/model/users.dart';
import 'package:auto_waste/utils/uidata.dart';

class UserViewModel {
  List<Users> users;

  UserViewModel({this.users});

  getMenuItems() {
    return users = <Users>[
      Users(
        title: "Mr",
        name: "LANRE",
        lastName: "ESAN",
        address: "NO 6, ROYAL ESTATE, MAGADA-MAGBORO, OGUN STATE",
        lga: "OWODE LOCAL GOVERNMENT",
        state: "OGUN",
        email: "emmanuel.esan@yahoo.com",
        number: "08033157531",
        notification: "SMS",
        image: UIData.user1,
        password: "12345678"
      )

    ];
  }
}
