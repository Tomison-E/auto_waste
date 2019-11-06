import 'package:flutter/material.dart';
class androidPage extends StatelessWidget{
  String route = "/page";

  final _scaffoldState = GlobalKey<ScaffoldState>();

  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              leading: Text ("love"),
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Collapsing Toolbar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Center(
          child: Text("Sample Text"),
        ),
      ),
    );}}


    class androidPage_view {
      androidPage_view({String leading, Color color, Widget background, String route, Widget body, Key key, String title })
          :
            _leading = leading,
            _color = color,
            _background = background,
            _route = route,
            _body = body,
            _title = title,
            _scaffoldState = key;


      final String _leading;
      final Color _color;
      final Widget _background;
      final String _route  ;
      final Widget _body;
      final String _title;

      final GlobalKey<ScaffoldState> _scaffoldState;

      Widget build(BuildContext context) {
        return Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  leading: Text (_leading),
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text(_title,
                          style: TextStyle(
                            color: _color,
                            fontSize: 16.0,
                          )),
                      background: _background),
                ),
              ];
            },
            body: _body,
          ),
        );}

    }