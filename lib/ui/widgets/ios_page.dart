import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Ios_page  extends StatelessWidget{
  final _scaffoldState = GlobalKey<ScaffoldState>();
Ios_page({this.leading,this.trailing,@required this.title,@required this.body, this.color=CupertinoColors.white});

    final String title;
    final Widget leading;
    final Widget trailing;
    final Widget body;
    final Color color;
  Widget build(BuildContext context) {
    return new CupertinoPageScaffold(child: new CustomScrollView(
      slivers: <Widget>[
         CupertinoSliverNavigationBar(
          largeTitle: Text(title),
          leading: leading,
          //middle: const Text("Waste Management"),
          trailing: trailing,
          backgroundColor: CupertinoColors.white,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index){
                return body;
              },
              childCount: 1
          ),
        ),

      ],
    ),
      backgroundColor: color,
    );
  }
}