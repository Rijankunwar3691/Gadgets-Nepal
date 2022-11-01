import 'package:ecommercenepal/provider/check_out_provider.dart';
import 'package:ecommercenepal/screen/check_out/google_map/google_map.dart';
import 'package:ecommercenepal/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeliveryAdress extends StatefulWidget {
  @override
  State<AddDeliveryAdress> createState() => _AddDeliveryAdressState();
}

enum AddressTypes {
  Home,
  Work,
  Other,
}

class _AddDeliveryAdressState extends State<AddDeliveryAdress> {
  AddressTypes? myType = AddressTypes.Home;
  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Add Delivery Address",
          style: TextStyle(fontSize: 18, color: Colors.black),
        ),
      ),
      bottomNavigationBar: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 48,
          child: checkoutProvider.isloadding == false
              ? MaterialButton(
                  onPressed: () {
                    checkoutProvider.validator(context, myType);
                  },
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  child: const Text(
                    "Add Address",
                    style: TextStyle(),
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            CustomTextField(
                labText: 'First Name', controller: checkoutProvider.firstName),
            CustomTextField(
              labText: "Last name",
              controller: checkoutProvider.lastName,
            ),
            CustomTextField(
                labText: "Mobile no.", controller: checkoutProvider.mobileNo),
            CustomTextField(
              labText: "Alternate Mobile no,",
              controller: checkoutProvider.alternateMobileNo,
            ),
            CustomTextField(
              labText: "City",
              controller: checkoutProvider.city,
            ),
            // ignore: prefer_const_constructors
            CustomTextField(
              labText: "Area",
              controller: checkoutProvider.aera,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (ctx) => const CustomGoogleMap()),
                );
              },
              child: Container(
                width: double.infinity,
                height: 50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [checkoutProvider.setLoaction == null? const Text("Set Loaction"):
                    const Text("Done!"),]
                ),
              ),
            ),
            const Divider(
              color: Colors.black,
            ),
            const ListTile(
              title: Text("Address Type*"),
            ),
            RadioListTile<AddressTypes>(
              value: AddressTypes.Home,
              groupValue: myType,
              title: const Text("Home"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: const Icon(
                Icons.home,
                color: Colors.black,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Work,
              groupValue: myType,
              title: const Text("Work"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: const Icon(
                Icons.work,
                color: Colors.black,
              ),
            ),
            RadioListTile(
              value: AddressTypes.Other,
              groupValue: myType,
              title: const Text("Other"),
              onChanged: (AddressTypes? value) {
                setState(() {
                  myType = value;
                });
              },
              secondary: const Icon(
                Icons.devices_other,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
