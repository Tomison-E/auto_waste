import 'dart:async';

import 'package:auto_waste/di/dependency_injection.dart';
import 'package:auto_waste/model/login.dart';
import 'package:auto_waste/model/otp.dart';
import 'package:auto_waste/services/abstract/i_otp_service.dart';
import 'package:auto_waste/services/network_service_response.dart';
import 'package:meta/meta.dart';
import 'package:auto_waste/logic/viewmodel/users_view_model.dart';
import 'package:auto_waste/model/users.dart';
class UserLoginModel {
  String email;
  String password;

  NetworkServiceResponse apiResult;
  IOTPService otpRepo = new Injector().otpService;

  //for otp
  UserLoginModel({@required this.email, @required this.password});

/*
  Future<Null> performLogin(UserLoginViewModel userLogin) async {
    NetworkServiceResponse<OTPResponse> result =
    await otpRepo.fetchOTPLoginResponse(
        Login(phonenumber: userLogin.phonenumber, otp: userLogin.otp));
    this.apiResult = result;
  }*/


  Users login() {
    List<Users> users = new UserViewModel().getMenuItems();
    for (Users p in users){
      if ((p.password == this.password) && (p.email == this.email)){
        return p;
      }
    }
    return null;
  }
}