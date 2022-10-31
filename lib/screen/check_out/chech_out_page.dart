import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../widgets/single_item.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  late CartProvider cartProvider;

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    cartProvider.getCartData();
    double subTotal = cartProvider.subTotal();

    double discount = 5;
    int shipping = 80;

    double discountValue = (subTotal * discount) / 100;

    double value = subTotal - discountValue;

    var totalPrice = value += shipping;
    if (cartProvider.getCartList.isEmpty) {
      setState(() {
        totalPrice = 0.0;
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          'Check Out',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: cartProvider.getCartList.isEmpty
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
                        productid: data.productid,
                        productimage: data.productimage,
                        productprice: data.productprice,
                        productquantity: data.productquantity,
                        productname: data.productname,
                      );
                    },
                  ),
          ),
          Expanded(
              child: Column(
            children: [
              ListTile(
                leading: const Text('Sub Total'),
                trailing: Text('Rs.$subTotal '.toString()),
              ),
              const ListTile(
                leading: Text('Discount'),
                trailing: Text('5%'),
              ),
              const ListTile(
                leading: Text('shipping'),
                trailing: Text('Rs 80'),
              ),
              const Divider(
                thickness: 2,
              ),
              ListTile(
                leading: const Text('Total'),
                trailing: Text('Rs.$totalPrice'.toString()),
              ),
              SizedBox(
                width: 250,
                child: cartProvider.getCartList.isEmpty
                    ? const Text("")
                    : MaterialButton(
                        color: Colors.yellow,
                        onPressed: () {},
                        child: const Text("Buy"),
                      ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
