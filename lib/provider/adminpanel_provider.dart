import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class AddproductsProvider with ChangeNotifier {
  TextEditingController productName = TextEditingController();

  TextEditingController productPrice = TextEditingController();

  TextEditingController productDescription = TextEditingController();

  TextEditingController availablequantity = TextEditingController();
  late String productcategory;
  String imageUrl = '';

  void validator(context) async {
    if (productName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Name is empty.',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (productPrice.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('productPrice is empty..',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (productDescription.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('productDescription is empty.',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (productDescription.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('productDescription is empty.',
            style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (productcategory == 'Select') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            Text('Select Category.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Add Image.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));
    } else if (productcategory == 'Laptop') {
      await FirebaseFirestore.instance
          .collection("NewArchives")
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      await FirebaseFirestore.instance
          .collection("categories")
          .doc('k8vru4SCVjFQyvJgOquQ')
          .collection('Laptop')
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productcategory': productcategory,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Added.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));

      notifyListeners();
      productName.clear();
      productPrice.clear();
      productDescription.clear();
      availablequantity.clear();
      notifyListeners();
    } else if (productcategory == 'Mobile') {
      await FirebaseFirestore.instance
          .collection("NewArchives")
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      await FirebaseFirestore.instance
          .collection("categories")
          .doc('vRUrv4FEDTtRYprXx6pc')
          .collection('Mobile')
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productcategory': productcategory,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Added.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));

      notifyListeners();
      productName.clear();
      productPrice.clear();
      productDescription.clear();
      availablequantity.clear();
      notifyListeners();
    } else if (productcategory == 'Watches') {
      await FirebaseFirestore.instance
          .collection("NewArchives")
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      await FirebaseFirestore.instance
          .collection("categories")
          .doc('mDTQZwa87j8OOr0ENYgf')
          .collection('Watches')
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productcategory': productcategory,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Product Added.', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.cyanAccent,
      ));

      notifyListeners();
      productName.clear();
      productPrice.clear();
      productDescription.clear();
      availablequantity.clear();
      notifyListeners();
    } else {
      await FirebaseFirestore.instance
          .collection("NewArchives")
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      });
      await FirebaseFirestore.instance
          .collection("categories")
          .doc('s9AY76pPCuGpwo2X4SVJ')
          .collection('Earphone')
          .doc(const Uuid().v1())
          .set({
        'productid': const Uuid().v1(),
        'productname': productName.text,
        'productcategory': productcategory,
        'productprice': int.parse(productPrice.text),
        'productdescription': productDescription.text,
        'availablequantity': int.parse(availablequantity.text),
        'productimage': imageUrl,
      }).then((value) async {
        notifyListeners();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content:
              Text('Product Added.', style: TextStyle(color: Colors.black)),
          backgroundColor: Colors.cyanAccent,
        ));

        notifyListeners();
        productName.clear();
        productPrice.clear();
        productDescription.clear();
        availablequantity.clear();
      });

      notifyListeners();
    }
  }

  void uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    print('${file?.path}');

    if (file == null) {
      print('null');
    }
    //Import dart:core
    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    /*Step 2: Upload to Firebase storage*/
    //Install firebase_storage
    //Import the library

    //Get a reference to storage root
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');

    //Create a reference for the image to be stored
    Reference referenceImageToUpload = referenceDirImages.child(Uuid().v1());

    //Handle errors/success
    try {
      //Store the file
      await referenceImageToUpload.putFile(File(file!.path));
      //Success: get the download URL
      imageUrl = await referenceImageToUpload.getDownloadURL();
    } catch (error) {
      //Some error occurred
    }
  }
}
