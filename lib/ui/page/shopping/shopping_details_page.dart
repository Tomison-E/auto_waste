import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_waste/inherited/product_provider.dart';
import 'package:auto_waste/logic/bloc/product_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/page/shopping/shopping_details/shopping_widget.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/logic/bloc/shoppingCart_bloc.dart';

class ShoppingDetailsPage extends StatelessWidget {
  final _scaffoldState = GlobalKey<ScaffoldState>();
  ShoppingCart sc = new ShoppingCart();
  ShoppingDetailsPage({@required this.product});
  final Product product;
  Product selectedProduct;
  ShoppingWidgets sw;
  CartBloc cartBloc;



  Widget bodyData(Product product) =>
             product != null
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoginBackground(
                        showIcon: false,
                        image: product.image,
                      ),
                     sw,
                    ],
                  )
                : Center(child: CircularProgressIndicator());


  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
    sw = ShoppingWidgets(product: product);
    //sw.cart;
    selectedProduct = sw.selectedProduct;
    return ProductProvider(
      productBloc: productBloc,
      child: CommonScaffold(
        backGroundColor: Colors.grey.shade100,
        actionFirstIcon: null,
        appTitle: "Product Detail",
        showFAB: true,
        leading: true,
        scaffoldKey: _scaffoldState,
        showDrawer: false,
        centerDocked: true,
        floatingIcon: Icons.add_shopping_cart,
        bodyData: bodyData(product),
        showBottomNav: true,
       snackbarAction: ()=>sw.cart,
       undoAction:()=> sw.removeItem,
       floatingIconAction: null,
      ),
    );
  }
}
