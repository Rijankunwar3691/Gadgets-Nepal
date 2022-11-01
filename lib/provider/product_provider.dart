import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../model/product_model.dart';

class ProductProvider with ChangeNotifier {
  List<ProductModel> newArchivesProductList = [];
  late ProductModel productmodel;

  fetchNewArchivesProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("NewArchives").get();
    value.docs.forEach((element) {
      productmodel = ProductModel(
        availablequantity: element.get('availablequantity'),
          productname: element.get('productname'),
          productprice: element.get('productprice'),
          productimage: element.get('productimage'),
          productdescription: element.get('productdescription'),
          productid: element.get('productid'));
      newList.add(productmodel);
    });
    newArchivesProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getNewArchivesProductDatalist {
    return newArchivesProductList;
  }
}
