/*
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

class Ios_page  extends StatelessWidget{
  final _scaffoldState = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(child: new CustomScrollView(
      slivers: <Widget>[
        const CupertinoSliverNavigationBar(
          largeTitle: const Text("Auto"),
          leading: const Text("back"),
          //middle: const Text("Waste Management"),
          trailing: const Text("Exit"),
          backgroundColor: CupertinoColors.white,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                return Text ("love");
              },
              childCount: 2
          ),
        ),
        new SliverStickyHeader(
          header: new Container(
            height: 60.0,
            color: Colors.lightBlue,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              'Header #0',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
                  (context, i) => new ListTile(
                leading: new CircleAvatar(
                  child: new Text('0'),
                ),
                title: new Text('List tile #$i'),
              ),
              childCount: 4,
            ),
          ),
        ),
        new SliverStickyHeader(
          header: new Container(
            height: 60.0,
            color: Colors.lightBlue,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              'Header #0',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
                  (context, i) => new ListTile(
                leading: new CircleAvatar(
                  child: new Text('0'),
                ),
                title: new Text('List tile #$i'),
              ),
              childCount: 4,
            ),
          ),
        ),
        new SliverStickyHeader(
          header: new Container(
            height: 60.0,
            color: Colors.lightBlue,
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.centerLeft,
            child: new Text(
              'Header #0',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          sliver: new SliverList(
            delegate: new SliverChildBuilderDelegate(
                  (context, i) => new ListTile(
                leading: new CircleAvatar(
                  child: new Text('0'),
                ),
                title: new Text('List tile #$i'),
              ),
              childCount: 4,
            ),
          ),
        ),
      ],
    ),
    );
  }
}*/
