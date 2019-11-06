import 'package:flutter/material.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/page/shopping/shopping_two/product_desc.dart';
import 'package:auto_waste/utils/uidata.dart';

class ProductCard extends StatefulWidget {
  final List<Product> products;

  const ProductCard({Key key, this.products}) : super(key: key);
  @override
  _ProductCardState createState() => new _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  var deviceSize;
  AnimationController controller;
  Animation<double> animation;

  Widget productCard() {
    var cardHeight = deviceSize.height * 0.7;
    var cardWidth = deviceSize.width * 0.85;
    return SingleChildScrollView(
        child: Card(
      elevation: 1.0,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(15.0)),
      color: Colors.white,
      child: Ink(
        height: cardHeight,
        width: cardWidth,
        child: new Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topCenter,
              child: new Container(
                width: double.infinity,
                height: cardHeight / 1 * 1.2,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: UIData.kitGradients),
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0),
                       bottomLeft:const Radius.circular(30.0),
                        bottomRight: const Radius.circular(30.0)),
                  color: Colors.white,
                ),
               child: new ProductDesc(products:widget.products),
              ),
            ),
          ],
        ),
      ),
    )
    );
  }

  @override
  initState() {
    super.initState();
    controller = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1500));
    animation = new Tween(begin: 0.0, end: 1.0).animate(
        new CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn));
    animation.addListener(() => this.setState(() {}));
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return productCard();
  }
}
