
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class bottom_navView {
  bottom_navView({this.bar_items, this.body}):assert(bar_items!=null),assert(body!=null);

  List<BottomNavigationBarItem> bar_items;
  List<Widget> body;

}
class Bottom_nav extends StatelessWidget {
  //Bottom_nav()
Bottom_nav(this.bar_items, this.body):assert(bar_items!=null),assert(body!=null);

List<BottomNavigationBarItem> bar_items;
List<Widget> body;

  static const String routeName = '/cupertino/navigation';


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
      // Prevent swipe popping of this page. Use explicit exit buttons only.
    // onWillPop: () => new Future<bool>.value(true),
   return new CupertinoTabScaffold(
        tabBar: new CupertinoTabBar(
          items:  bar_items,
        ),
        tabBuilder: (BuildContext context, int index) {
          return new DefaultTextStyle(
            style: const TextStyle(
              fontFamily: '.SF UI Text',
              fontSize: 17.0,
              color: CupertinoColors.white,
            ),
            child: new CupertinoTabView(
              builder: (BuildContext context) {
                return body[index];
              },
            ),
          );
        },

    );
  }
}