import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/screen/payment_method/esewa.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../provider/cart_provider.dart';
import '../homepage/hompage.dart';
import 'razor_pay.dart';

class PayementPage extends StatefulWidget {
  final double totalamount;

  const PayementPage({Key? key, required this.totalamount}) : super(key: key);

  @override
  State<PayementPage> createState() => _PayementPageState();
}

class _PayementPageState extends State<PayementPage> {
  late CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    var totalprice = widget.totalamount;
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();

    return Scaffold(
      bottomNavigationBar: ListTile(
        tileColor: Colors.white,
        title: const Text('Total Amount'),
        trailing: Text('Rs.$totalprice'.toString(),
            style: const TextStyle(color: Colors.red)),
      ),
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Select Payement Method",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: ListView(children: [
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Recommended method(s)',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Esewa(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.abc),
              title: Text('eSewa Mobile Wallet'),
              trailing: Text('>'),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Payement method(s)',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RazorPay(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.abc),
              title: Text('Razor Pay'),
              trailing: Text('>'),
            ),
          ),
          InkWell(
            onTap: () {
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
                  'paymentmethod': 'cash on delivery',
                  'purchasedate':
                      DateFormat('yyyy/mm/dd kk:mm:ss').format(DateTime.now()),
                  'status': 'pending',
                });
                FirebaseFirestore.instance
                    .collection('cart')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection('usercart')
                    .doc(e.productid)
                    .delete();
              }).toList();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Order Confirmed.Thank you.',
                    style: TextStyle(color: Colors.black)),
                backgroundColor: Colors.cyanAccent,
              ));
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.home),
              title: Text('Cash on Delivery'),
              trailing: Text('>'),
            ),
          ),
        ]),
      ),
    );
  }
}
