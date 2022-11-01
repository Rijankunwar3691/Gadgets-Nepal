import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String productid;
  String productname;
  String productimage;
  int productprice;
  int productquantity;

  CartModel(
      {required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productid,
      required this.productquantity});

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
        productid: doc['productid'],
        productquantity: doc['productquantity'],
        productimage: doc['productimage'],
        productname: doc['productname'],
        productprice: doc['productprice']);
  }
}
