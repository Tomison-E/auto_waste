import 'package:flutter/material.dart';

class LabelIcon extends StatelessWidget {
  final label;
  final icon;
  final iconColor;
  final onPressed;

  LabelIcon(
      {this.label, this.icon, this.onPressed, this.iconColor = Colors.grey});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: iconColor,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}
/*
import 'package:flutter/material.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/widgets/common_divider.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_waste/ui/widgets/label_icon.dart';
import 'package:auto_waste/ui/widgets/common_scaffold.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';


class ShoppingAction extends StatefulWidget {
  final Product product;
  final _scaffoldState = GlobalKey<ScaffoldState>();
  ShoppingAction({@required this.product});
 //var cart;
  @override
  ShoppingActionState createState() {
    return new ShoppingActionState();
  }
}

class ShoppingActionState extends State<ShoppingAction> {
  String _value = "Cyan";
  String _sizeValue = "M";
  Product selectedProduct;
  ProductColor paint;
  CartBloc cartBloc;
  var deviceSize;
  Widget mainCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              widget.product.name,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(widget.product.brand),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                LabelIcon(
                  icon: Icons.star,
                  iconColor: Colors.cyan,
                  label: widget.product.rating.toString(),
                ),
                Text(
                  widget.product.price,
                  style: TextStyle(
                      color: Colors.orange.shade800,
                      fontWeight: FontWeight.w700,
                      fontSize: 25.0),
                )
              ],
            )
          ],
        ),
      ),
    ),
  );

  Widget descCard() => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Description",
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.product.description,
              style:
              TextStyle(fontSize: 15.0, fontWeight: FontWeight.normal),
            ),
          ],
        ),
      ),
    ),
  );

  Widget imagesCard() => SizedBox(
    height: deviceSize.height / 5,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0),
      child: Card(
        elevation: 2.0,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, i) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(widget.product.image),
          ),
        ),
      ),
    ),
  );

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

  Widget actionCard() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 18.0),
    child: Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:  Column(
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
      )
      ),
    ),
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
    this.selectedProduct = new Product(
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
    //this.selectedProduct.colors  = [this.paint];
    //this.selectedProduct.sizes = [_sizeValue];
    print (selectedProduct.sizes[0]);
    //this.selectedProduct.quantity = cartBloc.getCount.toString();
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

  Widget bodyData() =>
      widget.product != null
          ? Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LoginBackground(
            showIcon: false,
            image: widget.product.image,
          ),
  SingleChildScrollView(
  child: Column(
  children: <Widget>[
  SizedBox(
  height: deviceSize.height / 4,
  ),
  mainCard(),
  imagesCard(),
  descCard(),
  actionCard(),
  ],
  ),
  )],
      )
          : Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return CommonScaffold(
      backGroundColor: Colors.grey.shade100,
      actionFirstIcon: null,
      appTitle: "Product Detail",
      showFAB: true,
      leading: true,
      scaffoldKey: widget._scaffoldState,
      showDrawer: false,
      centerDocked: true,
      floatingIcon: Icons.add_shopping_cart,
      bodyData: bodyData(),
      showBottomNav: true,
      floatingIconAction: addToCart(),

    );
  }
}

 */