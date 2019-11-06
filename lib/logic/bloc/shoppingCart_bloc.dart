import 'dart:async';

import 'package:auto_waste/logic/viewmodel/cart_view_model.dart';
import 'package:auto_waste/model/product.dart';

class ShoppingCart {
  CartViewModel _cartViewModel;
  final additionalController = StreamController<Product>();
  final subtractionController = StreamController<bool>();
  final countController = StreamController<int>();
  static List<Product> products = [];
  Sink<Product> get addItem => additionalController.sink;
  Sink<bool> get subtractItem => subtractionController.sink;
 // Stream<int> get getCount => countController.stream;

  ShoppingCart() {
    //_cartViewModel = CartViewModel(product: p);
    //additionalController.stream.listen(onAddItem);
    //subtractionController.stream.listen(onRemoveItem);
  }

  void onAdd(bool done) {
    _cartViewModel.addQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void onDelete(bool done) {
    _cartViewModel.deleteQuantity();
    countController.add(_cartViewModel.totalQuantity);
  }

  void onAddItem(Product p){
    products.add(p);
   // countController.add(products.length);
    print(products[products.length - 1].sizes[0]);
    print(products.length);
    //print("boy");
  }

  void onRemoveItem(bool done){
    products.removeLast();
    print("removal");
    //countController.add(products.length);
    print(products.length);
    //print("foooool");
  }

  int getCount(){
    return products.length;
  }

  void dispose() {
    additionalController?.close();
    subtractionController?.close();
    countController?.close();
  }
}
