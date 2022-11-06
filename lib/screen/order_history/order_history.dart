import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/provider/order_provider.dart';
import 'package:ecommercenepal/screen/order_history/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  @override
  State<OrderHistory> createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    OrderProvider orderProvider = Provider.of(context);
    orderProvider.getOrderData;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Order History',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('orderhistory')
            .doc(FirebaseAuth.instance.currentUser?.uid)
            .collection('userhistory')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: double.infinity,
              width: double.infinity,
              child: const Center(
                child: Text(
                  'No Orders yet',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomWidget(
                    purchasedatetime: snapshot.data!.docs[index]
                        ['purchasedate'],
                    productid: snapshot.data!.docs[index]['productid'],
                    productimage: snapshot.data!.docs[index]['productimage'],
                    productname: snapshot.data!.docs[index]['productname'],
                    productprice: snapshot.data!.docs[index]['productprice'],
                    productquantity: snapshot.data!.docs[index]
                        ['productquantity'],
                    productstatus: snapshot.data!.docs[index]['status']);
              },
            );
          }
        },
      ),
    );
  }
}
