import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:location/location.dart';

import '../model/delivery_address_model.dart';

class CheckoutProvider with ChangeNotifier {
  bool isloadding = false;

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();

  TextEditingController street = TextEditingController();

  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  LocationData? setLoaction;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('first name is empty.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (lastName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('lastName is empty..', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (mobileNo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('mobileNo is empty.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (alternateMobileNo.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('alternateMobileNo is empty.',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (city.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('city is empty.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (aera.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('aera is empty.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (setLoaction?.longitude == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('setLoaction is empty.',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else {
      isloadding = true;
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("AddDeliverAddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "city": city.text,
        "aera": aera.text,
        "addressType": myType.toString(),
        "longitude": setLoaction!.longitude,
        "latitude": setLoaction!.latitude,
      }).then((value) async {
        isloadding = false;
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Address Added.', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.cyanAccent,
        ));
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }

  List<DeliveryAddressModel> deliveryAdressList = [];
  getDeliveryAddressData() async {
    List<DeliveryAddressModel> newList = [];

    DeliveryAddressModel deliveryAddressModel;
    DocumentSnapshot _db = await FirebaseFirestore.instance
        .collection("AddDeliverAddress")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
    if (_db.exists) {
      deliveryAddressModel = DeliveryAddressModel(
        firstName: _db.get("firstname"),
        lastName: _db.get("lastname"),
        addressType: _db.get("addressType"),
        aera: _db.get("aera"),
        alternateMobileNo: _db.get("alternateMobileNo"),
        city: _db.get("city"),
        mobileNo: _db.get("mobileNo"),
      );
      newList.add(deliveryAddressModel);
      notifyListeners();
    }

    deliveryAdressList = newList;
    notifyListeners();
  }

  List<DeliveryAddressModel> get getDeliveryAddressList {
    return deliveryAdressList;
  }
}
