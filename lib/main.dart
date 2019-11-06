import 'package:flutter/material.dart';
import 'package:auto_waste/di/dependency_injection.dart';
import 'package:auto_waste/myapp.dart';

void main() {
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Injector.configure(Flavor.MOCK);
  runApp(MyApp());
}
