import 'package:flutter/material.dart';
import 'package:auto_waste/logic/bloc/cart_bloc.dart';
import 'package:auto_waste/model/product.dart';
import 'package:auto_waste/ui/widgets/common_divider.dart';
import 'package:auto_waste/ui/widgets/custom_float.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_waste/ui/widgets/label_icon.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_waste/ui/widgets/login_background.dart';
import 'package:auto_waste/logic/bloc/shoppingCart_bloc.dart';
import 'package:auto_waste/utils/uidata.dart';

class ShoppingAction extends StatefulWidget {
  final Product product;
  final _scaffoldState = GlobalKey<ScaffoldState>();

   String bottom_leading = "ADD TO CART";

  ShoppingCart sc = ShoppingCart();
  int counter;
  String text;
  int items = 0;
  int quantity=1;
  ShoppingAction({@required this.product});
  //var cart;
  @override
  ShoppingActionState createState() {
     counter = sc.getCount();

    return new ShoppingActionState();
  }
}

class ShoppingActionState extends State<ShoppingAction> {
  String _value = "Cyan";
  String _sizeValue = "M";
  Product selectedProduct;
  ProductColor paint = new ProductColor(colorName: "Cyan",color: Colors.cyan);
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
                "₦${widget.product.price}",
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
                  print("the new size is $_sizeValue");
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
        quantity: widget.quantity
        //quantity: cartBloc.getCount.forEach((int p)=> p)
      );
      //this.selectedProduct.colors  = [this.paint];
      //this.selectedProduct.sizes = [_sizeValue];
      widget.sc.onAddItem(this.selectedProduct);
      //print (selectedProduct.sizes[0]);
      //this.selectedProduct.quantity = cartBloc.getCount.toString();
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
              qrCallback: () {
                if (widget.quantity > 0) {
                  setState(() {
                    widget.quantity--;
                  //  widget.product.quantity = widget.quantity;
                  });
                }
              }
            ),

           Text(
                widget.quantity.toString(),
                style:
                TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
              ),

            new CustomFloat(
              isMini: true,
              tag: "Increment",
              icon: FontAwesomeIcons.plus,
              qrCallback: () {
                if(widget.quantity < 10) {
                  setState(() {
                    widget.quantity++;
                   // widget.product.quantity = widget.quantity;
                  });

                }
              },
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

  void showSnackBar() {
    widget._scaffoldState.currentState.showSnackBar(SnackBar(
      content: Text(
        widget.text,
      ),
      action: SnackBarAction(
        label: "Undo",
        onPressed: () {
          if(widget.items==1) {
            removeFromCart();
            widget.items--;
            setState(() {
              widget.counter = widget.sc.getCount();
            });
          }

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
                if(widget.items<1 && widget.quantity>0){
                 addToCart();
                 widget.items++;
                setState(() {
                  widget.counter = widget.sc.getCount();
                  widget.text="Added to cart";
                });
                showSnackBar();}
                else if (widget.quantity>0){
                  widget.text = "Item is already in cart";
                  showSnackBar();
                }
                else{
                  widget.text = "Indicate the quantity required";
                  showSnackBar();
                }
              },
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
                  child: new IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white), onPressed:(){
                  Navigator.of(context, rootNavigator:true).
                  pushNamed(UIData.shoppingThreeRoute);},tooltip: "ORDER PAGE",)
              ),
            ),
          ),
        ],
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      key: widget._scaffoldState != null ? widget._scaffoldState : null,
      //backgroundColor: widget.backGroundColor != null ? widget.backGroundColor : null,
      appBar:  AppBar(
        elevation: 4.0,
        backgroundColor: Colors.black,
        title: Text("Product Detail"),
        leading: Icon(Icons.arrow_back_ios),
        actions: <Widget>[
          SizedBox(
            width: 5.0,
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert),
          )
        ],
      ),
      //drawer: widget.showDrawer ? CommonDrawer() : null,
      body: bodyData(),
      floatingActionButton: CustomFloat(
        builder:  Text(
          "${widget.counter}",
          style: TextStyle(color: Colors.white, fontSize: 10.0),
        )
            ,
        icon: Icons.add_shopping_cart,
        qrCallback: (){},
      )
          ,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar:  myBottomBar() ,
    );
  }
}