import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_waste/inherited/product_provider.dart';
import 'package:auto_waste/logic/bloc/product_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/page/shopping/shopping_two/product_detail_widgets.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/logic/bloc/shoppingCart_bloc.dart';
import 'package:auto_waste/utils/uidata.dart';

class ProductDetailPage extends StatelessWidget {
  double amount=0.00;
  Widget productScaffold(Stream<List<Product>> products, double amount, BuildContext context) => new CommonScaffold(
      backGroundColor: new Color(0xffeeeeee),
      centerDocked: true,
      appTitle: "Cart",
      floatingIcon: Icons.add_shopping_cart,
      showBottomNav: true,
      bottom_leading: "TOTAL: ₦$amount" ,
      bottom_trailing: "Shipping",
      bodyData: StreamBuilder<List<Product>>(
          stream: products,
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      LoginBackground(
                        showIcon: false,
                      ),
                      ProductDetailWidgets(products:ShoppingCart.products),
                    ],
                  )
                : Center(child: CircularProgressIndicator());
          }),
  bottomTrailingAction: ()=> Navigator.of(context).pushNamed(UIData.payment),);

  @override
  initState(){

  }
  @override
  Widget build(BuildContext context) {
    ProductBloc productBloc = ProductBloc();
   for(Product p in ShoppingCart.products){
     amount+=double.parse(p.price)*p.quantity;
   }
    return ProductProvider(
        productBloc: productBloc,
        child: productScaffold(productBloc.productItems,amount,context));
  }
}
