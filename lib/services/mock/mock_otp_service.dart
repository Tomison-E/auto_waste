
import 'dart:async';

import 'package:auto_waste/model/login.dart';
import 'package:auto_waste/model/otp.dart';
import 'package:auto_waste/services/abstract/i_otp_service.dart';
import 'package:auto_waste/services/network_service_response.dart';
import 'package:auto_waste/utils/uidata.dart';

class MockOTPService implements IOTPService {
  @override
  Future<NetworkServiceResponse<CreateOTPResponse>> createOTP(
      String phoneNumber) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(NetworkServiceResponse(
      success: true,
      content: null,
    ));
  }

  @override
  Future<NetworkServiceResponse<OTPResponse>> fetchOTPLoginResponse(
      Login userLogin) async {
    await Future.delayed(Duration(seconds: 2));
    return Future.value(NetworkServiceResponse(
        success: true,
        content: kOTPResponse,
        message: UIData.something_went_wrong));
  }
}

var kOTPResponse = new OTPResponse(
    data: const OTPData(authToken: "abcd", userId: "1245"), status: "success");
