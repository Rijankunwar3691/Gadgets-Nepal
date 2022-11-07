import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/model/cart_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> cartList = [];
  CartModel? cartModel;
  Future getCartData() async {
    List<CartModel> newCartList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('usercart')
        .get();

    querySnapshot.docs.forEach((element) {
      cartModel = CartModel.fromDocument(element);
      notifyListeners();
      newCartList.add(cartModel!);
    });
    cartList = newCartList;
    notifyListeners();
  }

  List<CartModel> get getCartList {
    return cartList;
  }

  double subTotal() {
    double subtotal = 0.0;
    cartList.forEach((element) {
     subtotal += element.productprice * element.productquantity;
    });
    return subtotal;
  }
}
