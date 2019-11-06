import 'package:flutter/material.dart';
import 'package:auto_waste/model/product.dart';

class ProductDesc extends StatelessWidget {
  final List<Product> products;

  const ProductDesc({Key key, this.products}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return new SingleChildScrollView(child:
      new Column(children: products.map((Product product)=> new Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: new ListTile(
            title: new Text(
              product.name,
              style: new TextStyle(
                  fontSize: 18.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: new Text(
              product.brand,
              style: new TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
            trailing: new Text("₦${product.price}",
                style: new TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow)),
          ),
        ),
        new SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28.0),
          child: new Text(
            "Quantity: X${product.quantity}",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        new SizedBox(
          height: 30.0,
        ),
        new Card(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          color: Colors.white,
          child: new Ink(
            height: deviceSize.height * 0.1,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text(
                      "Your Size",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    new SizedBox(height: 10.0),
                    new RawChip(
                        label: new Text(
                          product.sizes[0],
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.cyan)
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Color",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    new SizedBox(height: 10.0),
                    new RawChip(
                      label: new Text(
                        product.colors[0].colorName,
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: product.colors[0].color,
                    )
                  ],
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Text("Product ID",
                        style: TextStyle(fontWeight: FontWeight.w700)),
                    new SizedBox(height: 10.0),
                    new RawChip(
                      label: new Text(
                        product.rating.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.green,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
        new Divider(color: Colors.white,height: 30.0,indent: 20.0,),
      ],
      ),
      ).toList()
    ));
  }
}
