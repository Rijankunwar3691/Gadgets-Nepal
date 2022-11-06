import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];
  List<OrderModel> allorderList = [];

  late OrderModel orderModel;
  Future getOrderData() async {
    List<OrderModel> neworderList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orderhistory')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userhistory')
        .get();

    querySnapshot.docs.forEach((element) {
      orderModel = OrderModel(
          productimage: element.get('productimage'),
          productname: element.get('productname'),
          productprice: element.get('productprice'),
          productid: element.get('productid'),
          productquantity: element.get('productquantity'));

      neworderList.add(orderModel);
    });
    orderList = neworderList;
    notifyListeners();
  }

  List<OrderModel> get getOrderList {
    return orderList;
  }

   getallOrderData() async {
    List<OrderModel> newallorderList = [];

    QuerySnapshot querySnapshots =
        await FirebaseFirestore.instance.collection('orderhistory').get();

    querySnapshots.docs.forEach((element) {
      orderModel = OrderModel(
          productimage: element.get('productimage'),
          productname: element.get('productname'),
          productprice: element.get('productprice'),
          productid: element.get('productid'),
          productquantity: element.get('productquantity'));
      newallorderList.add(orderModel);
    });
    allorderList = newallorderList;
    notifyListeners();
  }

  List<OrderModel> get getallOrderList {
    return allorderList;
  }
}
