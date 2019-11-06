import 'package:flutter/material.dart';

class ProfileTile extends StatelessWidget {
  final title;
  final subtitle;
  final textColor;
  ProfileTile({this.title, this.subtitle, this.textColor = Colors.black});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
              fontSize: 20.0, fontWeight: FontWeight.w700, color: textColor),
        ),
        SizedBox(
          height: 4.0,
        ),

        Text(
          subtitle,
          style: TextStyle(
              fontSize: 15.0, fontWeight: FontWeight.normal, color: textColor),
        ),
      ],
    );
  }
}

/*
*
*
* import 'package:flutter/material.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/widgets/common_divider.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_waste/ui/widgets/label_icon.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';
import 'package:auto_waste/logic/bloc/shoppingCart_bloc.dart';

class ShoppingAction extends StatefulWidget {
  final Product product;
  ShoppingCart sc = ShoppingCart();
  ShoppingAction({@required this.product});
 var cart;
 var removeItem;
 Product selectedProduct;
  @override
  ShoppingActionState createState() {
    return new ShoppingActionState();
  }
}

class ShoppingActionState extends State<ShoppingAction> {
  String _value = "Cyan";
  String _sizeValue = "M";
  //Product selectedProduct;
  ProductColor paint;
  CartBloc cartBloc;
  var deviceSize;


  Widget colorsCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Colors",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            children: widget.product.colors
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: pc.color,
                          label: Text(
                            pc.colorName,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: _value == pc.colorName,
                          onSelected: (selected) {
                            setState(() {
                              paint = pc;
                              _value = selected ? pc.colorName : null;
                            });
                          }),
                    ))
                .toList(),
          ),
        ],
      );


  Widget sizesCard() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Sizes",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
          ),
          SizedBox(
            height: 10.0,
          ),
          Wrap(
            alignment: WrapAlignment.spaceEvenly,
            children: widget.product.sizes
                .map((pc) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ChoiceChip(
                          selectedColor: Colors.yellow,
                          label: Text(
                            pc,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          selected: _sizeValue == pc,
                          onSelected: (selected) {
                            setState(() {
                              _sizeValue = selected ? pc : null;
                            });
                          }),
                    ))
                .toList(),
          ),
        ],
      );
  addToCart(){
    widget.selectedProduct = new Product(
      name: widget.product.name,
      image: widget.product.image,
      brand: widget.product.brand,
      price: widget.product.price,
      rating: widget.product.rating,
      description: widget.product.description,
      totalReviews: widget.product.totalReviews,
      sizes: [_sizeValue],
      colors: [this.paint],
      //quantity: cartBloc.getCount.forEach((int p)=> p)
    );
    //widget.sc.additionalController.add(widget.selectedProduct);
    //widget.sc.subtractionController.add(true);
    widget.sc.onAddItem(widget.selectedProduct);
  }

  removeFromCart(){
    widget.sc.onRemoveItem(true);
  }


  Widget quantityCard() {
     cartBloc = CartBloc(widget.product);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Sizes",
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
        SizedBox(
          height: 10.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
           new CustomFloat(
              isMini: true,
              tag:"Decrement",
              icon: FontAwesomeIcons.minus,
              qrCallback: () => cartBloc.subtractionController.add(true),
            ),

            StreamBuilder<int>(
              stream: cartBloc.getCount,
              initialData: 0,
              builder: (context, snapshot) => Text(
                    snapshot.data.toString(),
                    style:
                        TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
                  ),
            ),
            new CustomFloat(
              isMini: true,
              tag: "Increment",
              icon: FontAwesomeIcons.plus,
              qrCallback: () => cartBloc.additionalController.add(true),
            ),
          ],
        )
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    widget.cart = addToCart();
   // widget.removeItem = removeFromCart();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        colorsCard(),
        CommonDivider(),
        SizedBox(
          height: 5.0,
        ),
        sizesCard(),
        CommonDivider(),
        SizedBox(
          height: 5.0,
        ),
        quantityCard(),
        SizedBox(
          height: 20.0,
        ),
      ],
    );
  }
}
*/