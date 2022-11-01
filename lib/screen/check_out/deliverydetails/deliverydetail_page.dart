import 'package:ecommercenepal/screen/check_out/add_delivey_adress/add_delivery_address.dart';
import 'package:ecommercenepal/screen/check_out/deliverydetails/single_deliveri_item.dart';
import 'package:ecommercenepal/screen/check_out/payment_summary/payement_summery.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/delivery_address_model.dart';
import '../../../provider/check_out_provider.dart';

class DeliveryDetailPage extends StatefulWidget {
  DeliveryDetailPage({Key? key}) : super(key: key);

  @override
  State<DeliveryDetailPage> createState() => _DeliveryDetailPageState();
}

class _DeliveryDetailPageState extends State<DeliveryDetailPage> {
  DeliveryAddressModel? value;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider deliveryAddressProvider = Provider.of(context);
    deliveryAddressProvider.getDeliveryAddressData();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text(
          "Delivery Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.yellow,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => AddDeliveryAdress()));
        },
      ),
      bottomNavigationBar: Container(
        // width: 160,
        height: 48,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: MaterialButton(
          onPressed: () {
            deliveryAddressProvider.getDeliveryAddressList.isEmpty
                ? Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => AddDeliveryAdress()))
                : Navigator.push(context,
                    MaterialPageRoute(builder: (ctx) => const CheckOutPage()));
          },
          color: Colors.yellow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          child: deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? const Text("Add new Address")
              : const Text("Payement Summary "),
        ),
      ),
      body: ListView(
        children: [
          ListTile(
              title: const Text("Deliver To"),
              leading: Image.asset('assets/location.png')),
          const Divider(
            height: 2,
          ),
          deliveryAddressProvider.getDeliveryAddressList.isEmpty
              ? Center(
                  child: Container(
                    child: const Center(
                      child: Text("No Data"),
                    ),
                  ),
                )
              : Column(
                  children: deliveryAddressProvider.getDeliveryAddressList
                      .map<Widget>((e) {
                    setState(() {
                      value = e;
                    });
                    return SingleDeliveryItem(
                      address: " ${e.aera}, ${e.city}  ",
                      title: "${e.firstName} ${e.lastName}",
                      number: e.mobileNo,
                      addressType: e.addressType == "AddressTypes.Home"
                          ? "Home"
                          : e.addressType == "AddressTypes.Other"
                              ? "Other"
                              : "Work",
                    );
                  }).toList(),
                )
        ],
      ),
    );
  }
}
