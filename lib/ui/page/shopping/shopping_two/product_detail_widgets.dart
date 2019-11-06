import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/page/shopping/shopping_two/product_card.dart';
import 'package:auto_waste/utils/uidata.dart';

class ProductDetailWidgets extends StatelessWidget {
  final List<Product> products;

  const ProductDetailWidgets({Key key, this.products}) : super(key: key);

  Widget appBarColumn(BuildContext context) => new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new SizedBox(
            height: 10.0,
          ),
          ProductCard(products: products)
        ],
      );
  Widget  quantityCard(Size deviceSize, CartBloc cartBloc) => new Positioned(
        top: (deviceSize.height - deviceSize.height * 0.3),
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
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    //CartBloc cartBloc = CartBloc(product);
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        appBarColumn(context),
        //quantityCard(deviceSize, cartBloc),
      ],
    );
  }
}
