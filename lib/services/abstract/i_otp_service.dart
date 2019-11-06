import 'dart:async';

import 'package:auto_waste/model/login.dart';
import 'package:auto_waste/model/otp.dart';
import 'package:auto_waste/services/network_service_response.dart';

abstract class IOTPService {
  Future<NetworkServiceResponse<CreateOTPResponse>> createOTP(
      String phoneNumber);
  Future<NetworkServiceResponse<OTPResponse>> fetchOTPLoginResponse(
      Login userLogin);
}
