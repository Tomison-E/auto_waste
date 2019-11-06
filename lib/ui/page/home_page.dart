import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_waste/logic/bloc/menu_bloc.dart';
import 'package:auto_waste/model/menu.dart';
import 'package:auto_waste/model/User.dart';
import 'package:auto_waste/ui/widgets/about_tile.dart';
import 'package:auto_waste/ui/widgets/profile_tile.dart';
import 'package:auto_waste/utils/uidata.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_waste/ui/page/profile/profile_one_page.dart';
import 'package:auto_waste/ui/page/profile/profile_two_page.dart';
import 'package:auto_waste/ui/page/dashboard/dashboard_two_page.dart';
import 'package:auto_waste/ui/page/timeline/timeline_two_page.dart';
import 'package:auto_waste/ui/page/payment/credit_card_page.dart';
import 'package:auto_waste/ui/widgets/ios_bottom.dart';
import 'package:auto_waste/ui/widgets/android_bottom.dart';
import 'package:auto_waste/ui/page/shopping/shopping_one_page.dart';
import 'package:auto_waste/ui/widgets/calendar.dart';
import 'package:auto_waste/ui/page/settings/settings_one_page.dart';

class HomePage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  Size deviceSize;
  List<BottomNavigationBarItem> bottom_view;
  List<Widget> body;
  List<BottomNavigationBarItem> bot_view;
  //menuStack
   void push(String route, BuildContext context, Menu menu){
switch (route){
  case 'Profile':
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileOnePage(user:menu.user)),
    );
    break;
  case 'Dashboard':
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DashboardTwoPage()),
    );
    break;
  case 'Contact':
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfileTwoPage(user:menu.user)),
    );
    break;
  case 'Tweets':
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TimelineTwoPage()),
    );
    break;
    case 'Credit Card':
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CreditCardPage()),
  );
  break;
  default:
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
}
  }
  Widget menuStack(BuildContext context, Menu menu) => InkWell(
        onTap: () => _showModalBottomSheet(context, menu),
        splashColor: Colors.orange,
        child: Card(
          elevation: 5.0,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              menuImage(menu),
              menuColor(),
              menuData(menu),
            ],
          ),
        ),
      );

  //stack 1/3
  Widget menuImage(Menu menu) => AspectRatio(
        aspectRatio: 1.0,
        child: Image.asset(
          menu.image,
          fit: BoxFit.cover,
        ),
      );

  //stack 2/3
  Widget menuColor() => new Container(
        decoration: BoxDecoration(boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.8),
            blurRadius: 5.0,
          ),
        ]),
      );

  //stack 3/3
  Widget menuData(Menu menu) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            menu.icon,
            color: Colors.white,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            menu.title,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )
        ],
      );

  //appbar
  Widget appBar() => SliverAppBar(
        backgroundColor: Colors.black,
        pinned: true,
        elevation: 10.0,
        forceElevated: true,
        expandedHeight: 150.0,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          background: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: UIData.kitGradients)),
          ),
          title: Row(
            children: <Widget>[
              FlutterLogo(
                colors: Colors.yellow,
                textColor: Colors.white,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(UIData.appName)
            ],
          ),
        ),
      );

  //bodygrid
  Widget bodyGrid(List<Menu> menu) => SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 0.0,
          crossAxisSpacing: 0.0,
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
          return menuStack(context, menu[index]);
        }, childCount: menu.length),
      );

  Widget homeScaffold(BuildContext context) => Theme(
        data: Theme.of(context).copyWith(
              canvasColor: Colors.transparent,
            ),
        child: Scaffold(key: _scaffoldState, body: bodySliverList()),
      );

  Widget bodySliverList() {
    MenuBloc menuBloc = MenuBloc();
    return StreamBuilder<List<Menu>>(
        stream: menuBloc.menuItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? CustomScrollView(
                  slivers: <Widget>[
                    appBar(),
                    bodyGrid(snapshot.data),
                  ],
                )
              : Center(child: CircularProgressIndicator());
        });
  }

  Widget header(User user) => Ink(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: UIData.kitGradients2)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                radius: 25.0,
                backgroundImage: AssetImage(user.image),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ProfileTile(
                  title: user.title,
                  subtitle: user.subtitle,
                  textColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      );

  void _showModalBottomSheet(BuildContext context, Menu menu) {
    showModalBottomSheet(
        context: context,
        builder: (context) => Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.only(
                    topLeft: new Radius.circular(15.0),
                    topRight: new Radius.circular(15.0))),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                header(menu.user),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: menu.items.length,
                    itemBuilder: (context, i) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: ListTile(
                              title: Text(
                                menu.items[i],
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                push(menu.items[i], context,menu);
                              }),
                        ),
                  ),
                ),
                MyAboutTile()
              ],
            )));
  }

  Widget iosCardBottom(Menu menu, BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
             Expanded(
            child:Container(
              width: 40.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(width: 3.0, color: Colors.white),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        menu.image,
                      ))),
            )),
            SizedBox(
              width: 20.0,
            ),
            Text(
              menu.title,
              textAlign: TextAlign.start,
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 20.0,
            ),
            FittedBox(
              child: CupertinoButton(
                onPressed: () => _showModalBottomSheet(context, menu),
                borderRadius: BorderRadius.circular(50.0),
                child: Text(
                  "Go",
                  textAlign: TextAlign.left,
                  style: TextStyle(color: CupertinoColors.activeBlue),
                ),
                color: Colors.white,
              ),
            )
          ],
        ),
      );

  Widget menuIOS(Menu menu, BuildContext context) {
    return Container(
      height: deviceSize.height / 2,
      child: Card(
        elevation: 0.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
        margin: EdgeInsets.all(16.0),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            menuImage(menu),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                menu.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              height: 60.0,
              child: Container(
                width: double.infinity,
                color: menu.menuColor,
                child: iosCardBottom(menu, context),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bodyDataIOS(List<Menu> data, BuildContext context) => SliverList(
        delegate: SliverChildListDelegate(
            data.map((menu) => menuIOS(menu, context)).toList()),
      );

  Widget homeBodyIOS(BuildContext context) {
    MenuBloc menuBloc = MenuBloc();
    return StreamBuilder<List<Menu>>(
        stream: menuBloc.menuItems,
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? bodyDataIOS(snapshot.data, context)
              : Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget homeIOS(BuildContext context) => Theme(
        data: ThemeData(
          fontFamily: '.SF Pro Text',
        ).copyWith(canvasColor: Colors.transparent),
        child: CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: <Widget>[
              CupertinoSliverNavigationBar(
               // border: Border(bottom: BorderSide.none),
                backgroundColor: CupertinoColors.white,
                largeTitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(UIData.appName),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: CircleAvatar(
                        radius: 15.0,
                        backgroundColor: CupertinoColors.black,
                        child: FlutterLogo(
                          size: 15.0,
                          colors: Colors.yellow,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              homeBodyIOS(context)
            ],
          ),
        ),
      );

Widget androidHome (BuildContext context) {
  final ThemeData theme = Theme.of(context);
  DateTime _currentDate = DateTime(2018, 8, 1);
  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  MenuBloc menuBloc = MenuBloc();
  bot_view = [
    BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart,color:Colors.grey),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.request,style:TextStyle(color: UIData.outfit)),activeIcon: Icon(Icons.shopping_cart,color: UIData.outfit)),
    BottomNavigationBarItem(icon: const Icon(Icons.message,color: Colors.grey),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.messages,style:TextStyle(color: UIData.outfit)),activeIcon: Icon(Icons.message,color: UIData.outfit)),
    BottomNavigationBarItem(icon: const Icon(Icons.event,color: Colors.grey),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.schedule,style:TextStyle(color: UIData.outfit)),activeIcon: Icon(Icons.event,color: UIData.outfit)),
    BottomNavigationBarItem(icon: const Icon(Icons.payment,color: Colors.grey),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.payments,style:TextStyle(color: UIData.outfit)),activeIcon: Icon(Icons.payment,color: UIData.outfit,semanticLabel: "pay")),
    BottomNavigationBarItem(icon: const Icon(Icons.account_balance,color: Colors.grey),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.account,style:TextStyle(color: UIData.outfit)),activeIcon: Icon(Icons.account_balance,color: UIData.outfit))
  ];
  body = [
    new ShoppingOnePage(),
    TimelineTwoPage(),
    Scaffold(appBar:AppBar(title: new Text("Schedule"),backgroundColor: CupertinoColors.lightBackgroundGray,actions:[
      Icon(Icons.edit),
      SizedBox(width: 10.0)
    ],centerTitle: true),
        body:Calendar(_currentDate, marked_date: _markedDate)),
   ProfileOnePage(user: User(
              title: "ESAN OLUWATOMISIN",
              subtitle: "SOFTWARE ENGINEER",
              icon: Icons.person,
              image: UIData.user1,
              items: ["www.Tomisin.com/about", "08166569680", "www.Github.com/Tomsin","Ibadan North", "tomiesan@yahoo.com","facebook.com/tomisin"]),),

    SettingsOnePage(),
    //  new Ios_page(title: UIData.appName,leading: const Icon(Icons.person), trailing: const Icon(Icons.settings),body: Text("Under development",style: TextStyle(color: CupertinoColors.black))),
    //  Text ("scale"),
    //Text ("base"),
    // Text ("scale"),
    //Text ("base"),
  ];
  return Theme(
    data: Theme.of(context),
    child: androidPageView(bot_view: bot_view, appTitle: UIData.appName,scaffoldKey: _scaffoldState, backGroundColor: Colors.white,
      actionFirstIcon: Icons.person, showFAB: false, currentIndex: 2, floatingIcon: Icons.edit,body: body),
  );

}
  Widget iosHome (BuildContext context) => Theme(
      data: ThemeData(
        fontFamily: '.SF Pro Text',
      ).copyWith(canvasColor: Colors.transparent),
  child: Bottom_nav(bottom_view, body),
  );

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    DateTime _currentDate = DateTime(2018, 8, 1);
    List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
    MenuBloc menuBloc = MenuBloc();
    body = [
      new ShoppingOnePage(),
      TimelineTwoPage(),
      Scaffold(appBar:AppBar(title: new Text("Schedule"),backgroundColor: CupertinoColors.lightBackgroundGray,actions:[
        Icon(Icons.edit),
        SizedBox(width: 10.0)
      ],centerTitle: true),
    body:Calendar(_currentDate, marked_date: _markedDate)),
     StreamBuilder<List<Menu>>(
    stream: menuBloc.menuItems,
    initialData: null,
    builder: (context, snapshot) {
    return snapshot.hasData
    ? ProfileOnePage(user: snapshot.data[0].user)
        : Center(
    child: CircularProgressIndicator(),
    );
    }),
     SettingsOnePage(),
    //  new Ios_page(title: UIData.appName,leading: const Icon(Icons.person), trailing: const Icon(Icons.settings),body: Text("Under development",style: TextStyle(color: CupertinoColors.black))),
    //  Text ("scale"),
      //Text ("base"),
     // Text ("scale"),
      //Text ("base"),
    ];

    bottom_view = [
      BottomNavigationBarItem(icon: const Icon(Icons.shopping_cart),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.request)),
      BottomNavigationBarItem(icon: const Icon(Icons.message),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.messages)),
      BottomNavigationBarItem(icon: const Icon(Icons.event),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.schedule)),
      BottomNavigationBarItem(icon: const Icon(Icons.person),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.account)),
      BottomNavigationBarItem(icon: const Icon(Icons.settings),backgroundColor:theme.bottomAppBarColor,title: new Text(UIData.settings))
    ];


    deviceSize = MediaQuery.of(context).size;
    return defaultTargetPlatform == TargetPlatform.iOS
        ? iosHome(context)
        : androidHome(context);
  }

  //push navigator routes

}
