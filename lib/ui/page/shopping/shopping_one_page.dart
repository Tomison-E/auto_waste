import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_waste/logic/bloc/product_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';
import 'package:auto_waste/ui/page/shopping/shopping_two/product_card2.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/utils/uidata.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_waste/ui/widgets/ios_page.dart';
import 'package:auto_waste/ui/page/shopping/shopping_details_page.dart';

class ShoppingOnePage extends StatelessWidget {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  Size deviceSize;
  //stack1
  Widget imageStack(String img) => Image.network(
        img,
        fit: BoxFit.cover,
      );

  //stack2
  Widget descStack(Product product) => Positioned(
        bottom: 0.0,
        left: 0.0,
        right: 0.0,
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.name,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text("₦${product.price}",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold))
              ],
            ),
          ),
        ),
      );

  //stack3
  Widget ratingStack(double rating) => Positioned(
        top: 0.0,
        left: 0.0,
        child: Container(
          padding: EdgeInsets.all(4.0),
          decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0))),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.star,
                color: Colors.cyanAccent,
                size: 10.0,
              ),
              SizedBox(
                width: 2.0,
              ),
              Text(
                rating.toString(),
                style: TextStyle(color: Colors.white, fontSize: 10.0),
              )
            ],
          ),
        ),
      );

  Widget productGrid(List<Product> products) => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        children: products
            .map((product) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    splashColor: Colors.yellow,
                    onDoubleTap: () => showSnackBar(),
                    child: Material(
                      elevation: 2.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          imageStack(product.image),
                          descStack(product),
                          ratingStack(product.rating),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
  Widget quantityCard(Size deviceSize, CartBloc cartBloc) => new Positioned(
    top: (deviceSize.height - deviceSize.height * 0.1),
    left: deviceSize.width / 2 - deviceSize.width / 5,
    width: deviceSize.width / 2 - 30,
    child: new Material(
      shape: new StadiumBorder(),
      shadowColor: Colors.black,
      elevation: 2.0,
      color: Colors.transparent,
      child: Ink(
        decoration: new BoxDecoration(
          gradient: new LinearGradient(colors: UIData.kitGradients),
        ),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new IconButton(
              icon: new Icon(
                Icons.remove,
                color: Colors.white,
              ),
              onPressed: () => cartBloc.subtractionController.add(true),
            ),
            StreamBuilder<int>(
              stream: cartBloc.getCount,
              initialData: 0,
              builder: (context, snapshot) => new Text(
                snapshot.data.toString(),
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
            ),
            new IconButton(
              icon: new Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () => cartBloc.additionalController.add(true),
            )
          ],
        ),
      ),
    ),
  );
  Widget bodyData(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
    var deviceSize = MediaQuery.of(context).size;
    return  StreamBuilder<List<Product>>(
        stream: productBloc.productItems,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? SingleChildScrollView(

          child:Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child:
                      Card(
                      child:Column(
                        children: [
                          Container(
                            child: ProductCard(product: snapshot.data[0])),
                        ]
                      )
                      ),
                      //height: 350.0,
                      alignment: Alignment.center,
                    ),
                    ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Card(
                                child:Column(
                                    children: [
                                    Container(
                                        child: ProductCard(product: snapshot.data[1])),

                                    ]
                                ),
           // color: Colors.grey
          ),
                           // height: 300.0,
                            alignment: Alignment.center,
                          ),
                        ),
              SizedBox(height: 100.0)
              ]))

              : Center(child: CircularProgressIndicator());
          });
  }

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

  @override
  Widget build(BuildContext context) {
    //deviceSize = MediaQuery.of(context).size;
    return defaultTargetPlatform == TargetPlatform.iOS?
         Ios_page(title: UIData.products,leading: const Icon(Icons.person),
           trailing: GestureDetector(child:const Icon(Icons.shopping_cart),onTap:(){
             Navigator.of(context,rootNavigator: true).pushNamed(UIData.shoppingThreeRoute);
           }
           ,),
           body: bodyData(context),color: CupertinoColors.lightBackgroundGray,):
     CommonScaffold(
      scaffoldKey: scaffoldKey,
      backGroundColor: new Color(0xffeeeeee),
      bodyData: bodyData(context),
      actionFirstIcon: Icons.shopping_cart,
      leading: true,
     // appTitle: "Products",
    );
  }
}
