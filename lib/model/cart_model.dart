import 'package:cloud_firestore/cloud_firestore.dart';

class CartModel {
  String productid;
  String productname;
  String productimage;
  int productprice;
  int productquantity;
  int availablequantity;
  CartModel(
      {required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productid,
      required this.productquantity,required this.availablequantity});

  factory CartModel.fromDocument(QueryDocumentSnapshot doc) {
    return CartModel(
      availablequantity: doc['availablequantity'],
        productid: doc['productid'],
        productquantity: doc['productquantity'],
        productimage: doc['productimage'],
        productname: doc['productname'],
        productprice: doc['productprice']);
  }
}
