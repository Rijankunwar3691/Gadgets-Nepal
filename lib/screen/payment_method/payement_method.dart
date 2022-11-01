import 'package:ecommercenepal/screen/payment_method/esewa.dart';
import 'package:flutter/material.dart';

class PayementPage extends StatefulWidget {
  final double totalamount;

  const PayementPage({Key? key, required this.totalamount}) : super(key: key);

  @override
  State<PayementPage> createState() => _PayementPageState();
}

class _PayementPageState extends State<PayementPage> {
  @override
  Widget build(BuildContext context) {
    var totalprice = widget.totalamount;

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
            onTap: () {},
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.credit_card),
              title: Text('Credit/Debit Card'),
              trailing: Text('>'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.abc),
              title: Text('Google Pay'),
              trailing: Text('>'),
            ),
          ),
          InkWell(
            onTap: () {},
            child: const ListTile(
              tileColor: Colors.white,
              leading: Icon(Icons.money),
              title: Text('Cash On Delivery'),
              trailing: Text('>'),
            ),
          ),
        ]),
      ),
    );
  }
}
