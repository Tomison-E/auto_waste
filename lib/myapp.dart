import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:auto_waste/ui/page/home_page.dart';
import 'package:auto_waste/ui/page/notfound/notfound_page.dart';
import 'package:auto_waste/ui/page/payment/credit_card_page.dart';
import 'package:auto_waste/ui/page/shopping/product_detail_page.dart';
import 'package:auto_waste/utils/translations.dart';
import 'package:auto_waste/utils/uidata.dart';
import 'package:auto_waste/ui/page/register/register.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyApp extends StatelessWidget {



  final materialApp = MaterialApp(
      title: UIData.appName,
      theme: ThemeData(
          primaryColor: Colors.green,
          fontFamily: UIData.quickFont,
          primarySwatch: Colors.amber),
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      home:  HomePage(),
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("hi", "IN"),
      ],

      // initialRoute: UIData.notFoundRoute,

      //routes
      routes: <String, WidgetBuilder>{
        UIData.homeRoute: (BuildContext context) => HomePage(),
        UIData.register: (BuildContext context) => Register(),
        UIData.shoppingThreeRoute: (BuildContext context) => ProductDetailPage(),
        UIData.payment:(BuildContext context)=> CreditCardPage(),
      },
      //initialRoute: "/home",
      onUnknownRoute: (RouteSettings rs) => new MaterialPageRoute(
          builder: (context) => new NotFoundPage(
                appTitle: UIData.coming_soon,
                icon: FontAwesomeIcons.solidSmile,
                title: UIData.coming_soon,
                message: "Under Development",
                iconColor: Colors.green,
              )));

  @override
  Widget build(BuildContext context) {
    return materialApp;
  }
}
