// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:auto_waste/ui/page/home_page.dart';
import 'package:auto_waste/ui/widgets/ios_bottom.dart';
import 'package:auto_waste/ui/widgets/android_bottom.dart';
import 'package:auto_waste/ui/widgets/sliver_scaffold.dart';
import 'package:auto_waste/ui/widgets/ios_page.dart';

// This demo displays one Category at a time. The backdrop show a list
// of all of the categories and the selected category is displayed
// (CategoryView) on top of the backdrop.

class Category {
  const Category({ this.title, this.route });
  final String title;
  final List<String> route;
  @override
  String toString() => '$runtimeType("$title")';
}

const List<Category> allCategories = const <Category>[
  const Category(
    title: 'Accessories',
    route: const <String>[
      'assets/I.jpg',
    ],
  ),
  const Category(
    title: 'Blue',
    route: const <String>[
      'assets/I,jpg'
    ],
  ),
];

class CategoryView extends StatelessWidget  {
   CategoryView({ Key key, this.category, this.body,this.bot_view }) : super(key: key);

  final Category category;
  final List<NavigationIconView> bot_view;
  final List <Widget> body;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    //return BottomNavigationDemo(bot_view,body);
  }
}

class ios_CategoryView extends StatelessWidget  {
  ios_CategoryView({ Key key, this.category, this.body,this.bot_view }) : super(key: key);

  final Category category;
  final List<BottomNavigationBarItem> bot_view;
  final List <Widget> body;

  @override
  Widget build(BuildContext context) {
    //final ThemeData theme = Theme.of(context);

    return Bottom_nav(bot_view,body);
  }
}
// One BackdropPanel is visible at a time. It's stacked on top of the
// the BackdropDemo.
class BackdropPanel extends StatelessWidget {
  const BackdropPanel({
    Key key,
    this.onTap,
    this.onVerticalDragUpdate,
    this.onVerticalDragEnd,
    this.title,
    this.child,
  }) : super(key: key);

  final VoidCallback onTap;
  final GestureDragUpdateCallback onVerticalDragUpdate;
  final GestureDragEndCallback onVerticalDragEnd;
  final Widget title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new Material(
      /*elevation: 2.0,
      borderRadius: const BorderRadius.only(
        topLeft: const Radius.circular(16.0),
        topRight: const Radius.circular(16.0),
      ),*/
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
      /*    new GestureDetector(
            behavior: HitTestBehavior.opaque,
            onVerticalDragUpdate: onVerticalDragUpdate,
            onVerticalDragEnd: onVerticalDragEnd,
            onTap: onTap,
            child: new Container(
              height: 48.0,
              padding: const EdgeInsetsDirectional.only(start: 16.0),
              alignment: AlignmentDirectional.centerStart,
              child: new DefaultTextStyle(
                style: theme.textTheme.subhead,
                child: new Tooltip(
                  message: 'Tap to dismiss',
                  child: title,
                ),
              ),
            ),
          ),
          const Divider(height: 1.0),*/
          new Expanded(child: child),
        ],
      ),
    );
  }
}

// Cross fades between 'Select a Category' and 'Asset Viewer'.
class BackdropTitle extends AnimatedWidget {
  const BackdropTitle({
    Key key,
    Listenable listenable,
  }) : super(key: key, listenable: listenable);

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new DefaultTextStyle(
      style: Theme.of(context).primaryTextTheme.title,
      softWrap: false,
      overflow: TextOverflow.ellipsis,
      child: new Stack(
        children: <Widget>[
          new Opacity(
            opacity: new CurvedAnimation(
              parent: new ReverseAnimation(animation),
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Select a Category'),
          ),
          new Opacity(
            opacity: new CurvedAnimation(
              parent: animation,
              curve: const Interval(0.5, 1.0),
            ).value,
            child: const Text('Asset Viewer'),
          ),
        ],
      ),
    );
  }
}

// This widget is essentially the backdrop itself.
class BackdropDemo extends StatefulWidget {
  static const String routeName = '/material/backdrop';

  @override
  _BackdropDemoState createState() => new _BackdropDemoState();
}

class _BackdropDemoState extends State<BackdropDemo> with TickerProviderStateMixin {
  final GlobalKey _backdropKey = new GlobalKey(debugLabel: 'Backdrop');
  AnimationController _controller;
  Category _category = allCategories[0];
  List<Widget> body;
  List<NavigationIconView> bot_view;
  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 300),
      value: 1.0,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _changeCategory(Category category) {
    setState(() {
      _category = category;
      _controller.fling(velocity: 2.0);
    });
  }

  bool get _backdropPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed || status == AnimationStatus.forward;
  }

  void _toggleBackdropPanelVisibility() {
    _controller.fling(velocity: _backdropPanelVisible ? -2.0 : 2.0);
  }

  double get _backdropHeight {
    final RenderBox renderBox = _backdropKey.currentContext.findRenderObject();
    return renderBox.size.height;
  }

  // By design: the panel can only be opened with a swipe. To close the panel
  // the user must either tap its heading or the backdrop's menu icon.

  void _handleDragUpdate(DragUpdateDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    _controller.value -= details.primaryDelta / (_backdropHeight ?? details.primaryDelta);
  }

  void _handleDragEnd(DragEndDetails details) {
    if (_controller.isAnimating || _controller.status == AnimationStatus.completed)
      return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dy / _backdropHeight;
    if (flingVelocity < 0.0)
      _controller.fling(velocity: math.max(2.0, -flingVelocity));
    else if (flingVelocity > 0.0)
      _controller.fling(velocity: math.min(-2.0, -flingVelocity));
    else
      _controller.fling(velocity: _controller.value < 0.5 ? -2.0 : 2.0);
  }

  // Stacks a BackdropPanel, which displays the selected category, on top
  // of the backdrop. The categories are displayed with ListTiles. Just one
  // can be selected at a time. This is a LayoutWidgetBuild function because
  // we need to know how big the BackdropPanel will be to set up its
  // animation.
  Widget _buildStack(BuildContext context, BoxConstraints constraints) {
    const double panelTitleHeight = 48.0;
    final Size panelSize = constraints.biggest;
    final double panelTop = panelSize.height - panelTitleHeight;

    final Animation<RelativeRect> panelAnimation = new RelativeRectTween(
      begin: new RelativeRect.fromLTRB(
        0.0,
        panelTop - MediaQuery.of(context).padding.bottom,
        0.0,
        panelTop - panelSize.height,
      ),
      end: const RelativeRect.fromLTRB(0.0, 0.0, 0.0, 0.0),
    ).animate(
      new CurvedAnimation(
        parent: _controller,
        curve: Curves.linear,
      ),
    );

    final ThemeData theme = Theme.of(context);
    bot_view = [
      NavigationIconView(icon: const Icon(Icons.access_alarm),color:theme.bottomAppBarColor,title: "Account",vsync: this),
      NavigationIconView(icon: const Icon(Icons.account_balance_wallet),color:theme.bottomAppBarColor,title: "Profile",vsync:this),
      NavigationIconView(icon: const Icon(Icons.voice_chat),color:theme.bottomAppBarColor,title: "Settings",vsync:this),
    ];

   body = [
      Text("surf"),
      Text ("scale"),
      Text ("base")
    ];

    List<BottomNavigationBarItem> bottom_view = [
      BottomNavigationBarItem(icon: const Icon(Icons.access_alarm),backgroundColor:theme.bottomAppBarColor,title: new Text("Account")),
      BottomNavigationBarItem(icon: const Icon(Icons.account_balance_wallet),backgroundColor:theme.bottomAppBarColor,title: new Text("Profile")),
      BottomNavigationBarItem(icon: const Icon(Icons.voice_chat),backgroundColor:theme.bottomAppBarColor,title: new Text("Settings"))
    ];

    final List<Widget> backdropItems = allCategories.map<Widget>((Category category) { // top view
      final bool selected = category == _category;
      return new Material(
        shape: const RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(const Radius.circular(4.0)),
        ),
        color: selected
            ? Colors.white.withOpacity(0.25)
            : Colors.transparent,
        child: new ListTile(
          title: new Text(category.title),
          selected: selected,
          onTap: () {
            _changeCategory(category);
          },
        ),
      );
    }).toList();

    return new Container( // bottom view
      key: _backdropKey,
      color: theme.primaryColor,
      child: new Stack(
        children: <Widget>[
          new ListTileTheme(
            iconColor: theme.primaryIconTheme.color,
            textColor: theme.primaryTextTheme.title.color.withOpacity(0.6),
            selectedColor: theme.primaryTextTheme.title.color,
            child: new Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: backdropItems,
              ),
            ),
          ),
          new PositionedTransition(
            rect: panelAnimation,
            child: new BackdropPanel(
              onTap: _toggleBackdropPanelVisibility,
              onVerticalDragUpdate: _handleDragUpdate,
              onVerticalDragEnd: _handleDragEnd,
             // title: new Text(_category.title),
              child:
             new ios_CategoryView(category: _category,body: body,bot_view: bottom_view,),
            ),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        title:  new BackdropTitle(
          listenable: _controller.view,
        ),
        actions: <Widget>[
          new IconButton(
            onPressed: _toggleBackdropPanelVisibility,
            icon: new AnimatedIcon(
              icon: AnimatedIcons.close_menu,
              progress: _controller.view,
            ),
          ),
        ],
        backgroundColor: Colors.pink,
      ),
      body: new LayoutBuilder(
        builder: _buildStack,
      ),
    );
  }
}
