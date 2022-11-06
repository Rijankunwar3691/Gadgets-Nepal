import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../model/usermodel.dart';

class UserDataProvider with ChangeNotifier {
  List<UserModel> userDataList = [];
  List<UserModel> allUserData = [];
  late UserModel usermodel;

  Future<void> fetchUserData() async {
    List<UserModel> newList = [];
    User? currentuser = FirebaseAuth.instance.currentUser;
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("UserData").get();
    value.docs.forEach((element) {
      if (currentuser?.uid == element.get('UserId')) {
        usermodel = UserModel(
          userName: element.get('UserName'),
          userEmail: element.get('UserEmail'),
        );
        newList.add(usermodel);
      }
    });
    userDataList = newList;
    notifyListeners();
  }

  List<UserModel> get getUserDatalist {
    return userDataList;
  }

  Future<void> fetchallUserData() async {
    List<UserModel> newallList = [];
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("UserData").get();
    value.docs.forEach((element) {
      usermodel = UserModel(
        userName: element.get('UserName'),
        userEmail: element.get('UserEmail'),
      );
      newallList.add(usermodel);
    });
    allUserData = newallList;
    notifyListeners();
  }

  List<UserModel> get getallUserDatalist {
    return allUserData;
  }
}
