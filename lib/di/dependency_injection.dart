import 'package:auto_waste/services/abstract/i_otp_service.dart';
import 'package:auto_waste/services/mock/mock_otp_service.dart';
import 'package:auto_waste/services/real/real_otp_service.dart';
import 'package:auto_waste/services/restclient.dart';

enum Flavor { MOCK, PRO }

//Simple DI
class Injector {
  static final Injector _singleton = new Injector._internal();
  static Flavor _flavor;

  static void configure(Flavor flavor) async {
    _flavor = flavor;
  }

  factory Injector() => _singleton;

  Injector._internal();

  IOTPService get otpService {
    switch (_flavor) {
      case Flavor.MOCK:
        return MockOTPService();
      default:
        return OTPService(new RestClient());
    }
  }
}
