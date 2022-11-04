import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  String productid;
  String productname;
  String productimage;
  int productprice;
  int productquantity;

  OrderModel(
      {required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productid,
      required this.productquantity});

  factory OrderModel.fromDocument(QueryDocumentSnapshot doc) {
    return OrderModel(
        productid: doc['productid'],
        productquantity: doc['productquantity'],
        productimage: doc['productimage'],
        productname: doc['productname'],
        productprice: doc['productprice']);
  }
}
