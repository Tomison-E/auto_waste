import 'package:flutter/material.dart';
import 'package:auto_waste/ui/widgets/common_drawer.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:auto_waste/utils/uidata.dart';

class CommonScaffold extends StatefulWidget {
  final appTitle;
  final Widget bodyData;
  final showFAB;
  final showDrawer;
  final backGroundColor;
  final actionFirstIcon;
  final scaffoldKey;
  final showBottomNav;
  final floatingIcon;
  final centerDocked;
  final elevation;
  final leading;
  final bottom_leading;
  final bottom_trailing;
  final floatingIconAction;
  final snackbarAction;
  final bottomTrailingAction;
  final undoAction;
  int counter;

  CommonScaffold({this.appTitle,
    this.bodyData,
    this.showFAB = false,
    this.showDrawer = false,
    this.backGroundColor,
    this.actionFirstIcon = Icons.search,
    this.scaffoldKey,
    this.counter = 0,
    this.snackbarAction,
    this.undoAction,
    this.bottomTrailingAction=null,
    this.floatingIconAction = null,
    this.showBottomNav = false,
    this.centerDocked = false,
    this.floatingIcon,
    this.leading = false,
    this.bottom_leading = "ADD TO CART",
    this.bottom_trailing = "ADD TO WISHLIST",
    this.elevation = 4.0});

  @override
  _CommonScaffoldState createState() => new _CommonScaffoldState();
}

class _CommonScaffoldState extends State<CommonScaffold>{

  void showSnackBar() {
    widget.scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        "Added to cart.",
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          widget.undoAction;
          setState(() {
            widget.counter--;
          });
        },
      ),
    ));
  }

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
                  onTap: () {

                    setState(() {
                      widget.snackbarAction;
                    widget.counter++;
                  });
                  showSnackBar();},
                  child: Center(
                    child: new Text(
                      widget.bottom_leading,
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
                    child: new IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white), onPressed: widget.bottomTrailingAction,tooltip: "ORDER PAGE",)
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey != null ? widget.scaffoldKey : null,
      backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
      appBar: widget.appTitle!= null ? AppBar(
        elevation: widget.elevation,
        backgroundColor: Colors.black,
        title: Text(widget.appTitle),
        leading: widget.leading?Icon(Icons.arrow_back_ios):null,
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(widget.actionFirstIcon),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ): null,
      drawer: widget.showDrawer ? CommonDrawer() : null,
      body: widget.bodyData,
      floatingActionButton: widget.showFAB
          ? CustomFloat(
              builder: widget.centerDocked
                  ? Text(
                      "${widget.counter}",
                      style: TextStyle(color: Colors.white, fontSize: 10.0),
                    )
                  : null,
              icon: widget.floatingIcon,
              qrCallback: widget.floatingIconAction,
            )
          : null,
      floatingActionButtonLocation: widget.centerDocked
          ? FloatingActionButtonLocation.centerDocked
          : FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: widget.showBottomNav ? myBottomBar() : null,
    );
  }
}
