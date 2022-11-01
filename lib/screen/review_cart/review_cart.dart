import 'package:ecommercenepal/provider/cart_provider.dart';
import 'package:ecommercenepal/screen/check_out/deliverydetails/deliverydetail_page.dart';
import 'package:ecommercenepal/widgets/single_item.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReviewCart extends StatefulWidget {
  const ReviewCart({
    Key? key,
  }) : super(key: key);

  @override
  State<ReviewCart> createState() => _ReviewCartState();
}

class _ReviewCartState extends State<ReviewCart> {
  late CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    double subTotal = cartProvider.subTotal();

    return Scaffold(
      bottomNavigationBar: cartProvider.getCartList.isEmpty
          ? const Text("")
          : ListTile(
              title: const Text('Total Amount'),
              subtitle: Text('Rs.$subTotal'.toString(),
                  style: const TextStyle(color: Colors.red)),
              trailing: SizedBox(
                width: 160,
                child: MaterialButton(
                  color: Colors.yellow[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadiusDirectional.circular(30)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DeliveryDetailPage(),
                        ));
                  },
                  child: const Text('Check Out'),
                ),
              ),
            ),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text(
            'Review Cart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true),
      body: cartProvider.getCartList.isEmpty
          ? const Center(
              child: Text(
                "Cart is Empty",
                style: TextStyle(fontSize: 30),
              ),
            )
          : ListView.builder(
              itemCount: cartProvider.getCartList.length,
              itemBuilder: (ctx, index) {
                var data = cartProvider.cartList[index];
                return SingleItem(
                  isbool: false,
                  availablequantity: data.availablequantity,
                  productid: data.productid,
                  productimage: data.productimage,
                  productprice: data.productprice,
                  productquantity: data.productquantity,
                  productname: data.productname,
                );
              },
            ),
    );
  }
}
