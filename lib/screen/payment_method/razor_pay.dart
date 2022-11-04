import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../provider/cart_provider.dart';
import '../homepage/hompage.dart';

class RazorPay extends StatefulWidget {
  RazorPay({Key? key}) : super(key: key);

  @override
  State<RazorPay> createState() => _RazorPayState();
}

class _RazorPayState extends State<RazorPay> {
  var _razorpay = Razorpay();
  var amountController = TextEditingController();
  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    cartProvider.getCartList.map((e) {
      FirebaseFirestore.instance
          .collection('orderhistory')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('userhistory')
          .doc(e.productid)
          .set({
        'productid': e.productid,
        'productimage': e.productimage,
        'productname': e.productname,
        'productprice': e.productprice,
        'productquantity': e.productquantity,
        'paymentmethod': 'Razor pay',
        'purchasedate':
            DateFormat('yyyy/mm/dd kk:mm:ss').format(DateTime.now()),
        'status': 'pending',
        'paid': amountController.text,
      });
      FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('usercart')
          .doc(e.productid)
          .delete();
    }).toList();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content:
          Text('payment sucessfull.', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.cyanAccent,
    ));
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('payment fail.', style: TextStyle(color: Colors.black)),
      backgroundColor: Colors.cyanAccent,
    ));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  late CartProvider cartProvider;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text(
          "Razor Pay ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: TextField(
              controller: amountController,
              decoration: const InputDecoration(hintText: "Enter your Amount"),
            ),
          ),
          CupertinoButton(
              color: Colors.grey,
              child: Text("Pay Amount"),
              onPressed: () {
                ///Make payment
                var options = {
                  'key': "rzp_test_qcJAW1V0ETSGri",
                  // amount will be multiple of 100
                  'amount': (int.parse(amountController.text) * 100)
                      .toString(), //So its pay 500
                  'name': 'Rijan kunwar',
                  'description': 'Demo',
                  'timeout': 300, // in seconds
                  'prefill': {
                    'contact': '9840546019',
                    'email': 'rijankunwar@gmail.com'
                  }
                };
                _razorpay.open(options);
              })
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _razorpay.clear(); // Removes all listeners

    super.dispose();
  }
}
