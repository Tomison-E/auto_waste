import 'package:flutter/material.dart';
import 'package:auto_waste/ui/widgets/common_drawer.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:auto_waste/utils/uidata.dart';
import 'package:auto_waste/ui/widgets/android_bottom.dart';

class CommonScaffold extends StatelessWidget {
  final appTitle;
  final Widget bodyData;
  final List<Widget> bodyDatas;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final sliver;
  final showNav;
  final floatingIcon;
  final color;
  final backGroundImage;
  final centerDocked;
  final elevation;
  final leading;
  final top_leading;
  final top_trailing;
  final trailing;
  final bottom_leading;
  final List<NavigationIconView> botItems;
  final bottom_trailing;

  CommonScaffold(
      {this.appTitle,
        this.bodyData,
        this.trailing,
        this.sliver,
        this.color,
        this.botItems,
        this.top_leading,
        this.top_trailing,
        this.backGroundImage,
        this.bodyDatas,
        this.showFAB = false,
        this.showDrawer = false,
        this.backGroundColor,
        this.actionFirstIcon = Icons.search,
        this.scaffoldKey,
        this.showNav =  true,
        this.showBottomNav = false,
        this.centerDocked = false,
        this.floatingIcon,
        this.leading = false,
        this.bottom_leading = "ADD TO CART",
        this.bottom_trailing = "ADD TO WISHLIST",
        this.elevation = 4.0});

  void showSnackBar() {
    scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Added to cart.",
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {},
      ),
    ));
  }

  BottomNavigation BottomNav;
  Widget myBottomBar() => new BottomAppBar(
    //shape: CircularNotchedRectangle(),
    child: Ink(
      height: 50.0,
      decoration: new BoxDecoration(gradient: new LinearGradient(colors: UIData.kitGradients)),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: double.infinity,
            child: new InkWell(
              radius: 10.0,
              splashColor: Colors.yellow,
              onTap: () {showSnackBar();},
              child: Center(
                child: new Text(
                  bottom_leading,
                  style: new TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          new SizedBox(
            width: 20.0,
          ),
          SizedBox(
            height: double.infinity,
            child: new InkWell(
              onTap: () {},
              radius: 10.0,
              splashColor: Colors.yellow,
              highlightColor: Colors.white,
              child: Center(
                  child: new IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white), onPressed: null)
              ),
            ),
          ),
        ],
      ),
    ),
  );



  @override
  Widget build(BuildContext context) {
    BottomNav  =  new BottomNavigation(botItems,1);
    return Scaffold(
      key: scaffoldKey != null ? scaffoldKey : null,
      backgroundColor: backGroundColor != null ? backGroundColor : null,
      appBar: sliver ? null: AppBar(
        elevation: elevation,
        backgroundColor: Colors.black,
        title: Text(appTitle),
        leading: leading?Icon(Icons.arrow_back_ios):null,
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(actionFirstIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      drawer: showDrawer ? CommonDrawer() : null,
      body: view(),
      floatingActionButton: showFAB
          ? CustomFloat(
        builder: centerDocked
            ? Text(
          "5",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
            : null,
        icon: floatingIcon,
        qrCallback: () {},
      )
          : null,
      floatingActionButtonLocation: centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: BottomNav,
    );
  }

  Widget view(){

    if(sliver && showNav){
      print(BottomNav._currentIndex);
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: Text (top_leading),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(appTitle,
                      style: TextStyle(
                        color: color,
                        fontSize: 16.0,
                      )),
                  background: backGroundImage),
            ),
          ];
        },
        body: bodyDatas[BottomNav._currentIndex],
      );
    }
    else if (sliver== true && showNav==false){
      return NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: Text (leading),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(appTitle,
                      style: TextStyle(
                        color: color,
                        fontSize: 16.0,
                      )),
                  background: backGroundImage),
            ),
          ];
        },
        body: bodyData,
      );
    }
    else if (sliver == false && showNav== true){
      return bodyData;
    }
    else if(sliver == false && showNav== false){
      print(BottomNav._currentIndex);
      return bodyDatas[BottomNav._currentIndex];
    }
  }
}

class BottomNavigation extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';
  BottomNavigation(this._bot_view,this._currentIndex);


 final List<NavigationIconView> _bot_view;
  int _currentIndex;

  @override
  //print(_currentIndex);
  _BottomNavigationDemoState createState() => new _BottomNavigationDemoState(_bot_view,_currentIndex);
}
class _BottomNavigationDemoState extends State<BottomNavigation>
    with TickerProviderStateMixin {

  _BottomNavigationDemoState(this._bot_view, this._currentIndex);

  List<NavigationIconView> _bot_view;
  int _currentIndex;
  BottomNavigationBarType _type = BottomNavigationBarType.shifting;


  @override
  void initState() {
    super.initState();

    for (NavigationIconView view in _bot_view)
      view.controller.addListener(_rebuild);

    _bot_view[_currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (NavigationIconView view in _bot_view)
      view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (NavigationIconView view in _bot_view)
      transitions.add(view.transition(_type, context));

    // We want to have the newly animating (fading in) views on top.
    transitions.sort((FadeTransition a, FadeTransition b) {
      final Animation<double> aAnimation = a.opacity;
      final Animation<double> bAnimation = b.opacity;
      final double aValue = aAnimation.value;
      final double bValue = bAnimation.value;
      return aValue.compareTo(bValue);
    });

    return new Stack(children: transitions);
  }


  @override
  Widget build(BuildContext context) {
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: _bot_view
          .map((NavigationIconView navigationView) => navigationView.item)
          .toList(),
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _bot_view[_currentIndex].controller.reverse();
          _currentIndex = index;
          widget._currentIndex=index;
          _bot_view[_currentIndex].controller.forward();
          print(widget._currentIndex);
          print(_currentIndex);
        });
      },
    );

    return botNavBar;
    /*return new Scaffold(
      body: _body[_currentIndex],
      bottomNavigationBar: botNavBar,
    )*/;
  }
}