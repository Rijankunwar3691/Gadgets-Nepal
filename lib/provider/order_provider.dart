import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> orderList = [];
  OrderModel? orderModel;
  Future getOrderData() async {
    List<OrderModel> neworderList = [];

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('orderhistory')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('userhistory')
        .get();

    querySnapshot.docs.forEach((element) {
      orderModel = OrderModel.fromDocument(element);
      notifyListeners();
      neworderList.add(orderModel!);
    });
    orderList = neworderList;
    notifyListeners();
  }

  List<OrderModel> get getOrderList {
    return orderList;
  }
}
