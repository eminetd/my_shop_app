import 'package:flutter/material.dart';
import 'package:my_shop_app/color/colors.dart';

class CartModel extends ChangeNotifier {
  //list item
  final List _shopItems = [
    //[itemname,itemprice,imagepath,color]
    ['Banana', '100', 'assets/banana.png', colors.mybluegrey],
    ['Kiwi', '130', 'assets/kiwi.png', colors.mygrey],
    ['Chicken', '230', 'assets/chicken.png', colors.mygrey],
    ['Oranges', '150', 'assets/ora.png', colors.mybluegrey],
    ['Strawberry', '200', 'assets/straw.png', colors.mybluegrey],
    ['Water', '10', 'assets/water.png', colors.mygrey],
  ];

  //List cart

  final List _cartItems = [];
  get shopitem => _shopItems;
  get cartItems => _cartItems;

  void addItemToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  void showItemToCart(int index) {
    _cartItems.contains(_shopItems[index]);
    notifyListeners();
  }

  void removeItemfromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  //calculate
  String calculatetotal() {
    double totalprice = 0;
    for (int i = 0; i < _cartItems.length; i++) {
      totalprice += double.parse(_cartItems[i][1]);
    }
    return totalprice.toStringAsFixed(2);
  }
}
