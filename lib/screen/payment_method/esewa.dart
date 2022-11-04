import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../homepage/hompage.dart';

class Esewa extends StatefulWidget {
  @override
  State<Esewa> createState() => _EsewaState();
}

class _EsewaState extends State<Esewa> {
  ESewaPnp? _esewaPnp;
  final ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );
  @override
  void initState() {
    super.initState();
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  late CartProvider cartProvider;

  double _amount = 0;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text(
          "ESewa ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: "Enter amount",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ESewaPaymentButton(
              _esewaPnp!,
              amount: _amount,
              callBackURL: "https://example.com",
              productId: "abc123",
              productName: "Flutter SDK Example",
              onSuccess: (result) {
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
                    'paymentmethod': 'Esewa payment',
                    'purchasedate': DateFormat('yyyy/mm/dd kk:mm:ss')
                        .format(DateTime.now()),
                    'status': 'pending',
                    'paid': _amount
                  });
                  FirebaseFirestore.instance
                      .collection('cart')
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection('usercart')
                      .doc(e.productid)
                      .delete();
                }).toList();
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message.toString())));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ));
              },
              onFailure: (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
