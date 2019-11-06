// Copyright 2016 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:auto_waste/ui/widgets/common_drawer.dart';
import 'package:auto_waste/utils/uidata.dart';
class NavigationIconView {
  NavigationIconView({
    Widget icon,
    Widget activeIcon,
    String title,
    Color color,
    TickerProvider vsync,
  }) : _icon = icon,
        _color = color,
        _title = title,
        item = new BottomNavigationBarItem(
          icon: icon,
          //activeIcon: activeIcon,
          title: new Text(title),
          backgroundColor: color,
        ),
        controller = new AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = new CurvedAnimation(
      parent: controller,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
  }

  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  CurvedAnimation _animation;

  FadeTransition transition(BottomNavigationBarType type, BuildContext context) {
    Color iconColor;
    if (type == BottomNavigationBarType.shifting) {
      iconColor = _color;
    } else {
      final ThemeData themeData = Theme.of(context);
      iconColor = themeData.brightness == Brightness.light
          ? themeData.primaryColor
          : themeData.accentColor;
    }

    return new FadeTransition(
      opacity: _animation,
      child: new SlideTransition(
        position: new Tween<Offset>(
          begin: const Offset(0.0, 0.02), // Slightly down.
          end: Offset.zero,
        ).animate(_animation),
        child: new IconTheme(
          data: new IconThemeData(
            color: iconColor,
            size: 120.0,
          ),
          child: new Semantics(
            label: 'Placeholder for $_title tab',
            child: _icon,
          ),
        ),
      ),
    );
  }
}

class CustomIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
      margin: const EdgeInsets.all(4.0),
      width: iconTheme.size - 8.0,
      height: iconTheme.size - 8.0,
      color: iconTheme.color,
    );
  }
}

class CustomInactiveIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    return new Container(
        margin: const EdgeInsets.all(4.0),
        width: iconTheme.size - 8.0,
        height: iconTheme.size - 8.0,
        decoration: new BoxDecoration(
          border: new Border.all(color: iconTheme.color, width: 2.0),
        )
    );
  }
}

class androidPageView extends StatefulWidget {
  static const String routeName = '/material/bottom_navigation';

  androidPageView({this.bot_view, this.body, this.scaffoldKey,this.showDrawer=false,this.backGroundColor, this.elevation=4.0,this.appTitle, this.leading=false, this.actionFirstIcon,this.showFAB=false,this.currentIndex,this.centerDocked=false,this.floatingIcon});


  final List<BottomNavigationBarItem> bot_view;
  final List<Widget> body;
  final GlobalKey scaffoldKey;
   int currentIndex;
   final Color backGroundColor;
   final elevation;
   final String appTitle;
   final bool leading;
   final IconData actionFirstIcon;
   final bool showFAB;
   final bool centerDocked;
   final IconData floatingIcon;
   final bool showDrawer;
  @override
  _androidPageViewState createState() => new _androidPageViewState();
}

class _androidPageViewState extends State<androidPageView>
    with TickerProviderStateMixin {

  _androidPageViewState();

  BottomNavigationBarType _type = BottomNavigationBarType.shifting;


  @override
  void initState() {
    super.initState();

    //for (BottomNavigationBarItem view in widget.bot_view)
      //view.controller.addListener(_rebuild);

    //widget.bot_view[widget.currentIndex].controller.value = 1.0;
  }

  @override
  void dispose() {
    for (BottomNavigationBarItem view in widget.bot_view)
     // view.controller.dispose();
    super.dispose();
  }

  void _rebuild() {
    setState(() {
      // Rebuild in order to animate views.
    });
  }

  Widget _buildTransitionsStack() {
    final List<FadeTransition> transitions = <FadeTransition>[];

    for (BottomNavigationBarItem view in widget.bot_view)
    //  transitions.add(view.transition(_type, context));

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
    final ThemeData theme = Theme.of(context);
    final BottomNavigationBar botNavBar = new BottomNavigationBar(
      items: widget.bot_view
          .map((BottomNavigationBarItem navigationView) => navigationView)
          .toList(),
      currentIndex: widget.currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
        //  widget.bot_view[widget.currentIndex].controller.reverse();
          widget.currentIndex = index;
        //  widget.bot_view[widget.currentIndex].controller.forward();
        });
      },
    );

    return new Scaffold(
      key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
      backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
      appBar: AppBar(
        elevation: widget.elevation,
        backgroundColor: theme.bottomAppBarColor,
        title: Text(widget.appTitle,style: TextStyle(color: Colors.black)),
        leading: widget.leading?Icon(Icons.arrow_back_ios):null,
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(widget.actionFirstIcon,color: Colors.blue),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, UIData.shoppingTwoRoute);
            },
            icon: Icon(Icons.settings,color:Colors.blue),
          )
        ],
      ),
      drawer: widget.showDrawer ? CommonDrawer() : null,
      body: widget.body[widget.currentIndex],
      floatingActionButton: widget.showFAB
          ? CustomFloat(
        builder: widget.centerDocked
            ? Text(
          "5",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
            : null,
        icon: widget.floatingIcon,
        qrCallback: () {},

      )
          : null,
      floatingActionButtonLocation: widget.centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: botNavBar,
    );
  }
}
