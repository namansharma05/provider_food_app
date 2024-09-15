import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData(User currentUser, String userName, String userEmail,
      String userImage) async {
    await FirebaseFirestore.instance
        .collection("users_data")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      "userName": userName,
      "userEmail": userEmail,
      "userImage": userImage,
      "userId": currentUser.uid,
    });
    notifyListeners();
  }

  UserModel _currentUser = UserModel();

  Future<void> fetchUserData() async {
    final user = await FirebaseFirestore.instance
        .collection("users_data")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    _currentUser = UserModel(
      userEmail: user["userEmail"],
      userId: user["userId"],
      userImage: user["userImage"],
      userName: user["userName"],
    );
    notifyListeners();
    // print(user.data());
  }

  UserModel get currentUser => _currentUser;
}
