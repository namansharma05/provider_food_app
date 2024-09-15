import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/models/address_model.dart';

class AddressProvider with ChangeNotifier {
  Future<void> addNewAddress(
      String? firstName,
      String? lastName,
      int? mobileNumber,
      int? alternateMobileNumber,
      String? houseNumber,
      String? area,
      String? city,
      String? state,
      String? landmark,
      int? pincode) async {
    final collectionRef = FirebaseFirestore.instance
        .collection("delivery_address")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_addresses');

    String docId = collectionRef.doc().id;
    await collectionRef.doc(docId).set({
      "firstName": firstName,
      "lastName": lastName,
      "mobileNumber": mobileNumber,
      "alternateMobileNumber": alternateMobileNumber,
      "houseNumber": houseNumber,
      "area": area,
      "city": city,
      "state": state,
      "landmark": landmark,
      "pincode": pincode,
      "addressId": docId,
    });

    notifyListeners();
  }

  List<AddressModel> _addressData = [];

  List<AddressModel> get addressData => _addressData;

  Future<void> fetchAddressDetails() async {
    _addressData.removeRange(0, _addressData.length);
    final addresses = await FirebaseFirestore.instance
        .collection('delivery_address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_addresses')
        .get();
    addresses.docs.forEach((address) {
      AddressModel addressModel = AddressModel(
        firstName: address.get("firstName"),
        lastName: address.get("lastName"),
        mobileNumber: address.get("mobileNumber"),
        alternateMobileNumber: address.get("alternateMobileNumber"),
        houseNumber: address.get("houseNumber"),
        area: address.get("area"),
        city: address.get("city"),
        state: address.get("state"),
        landmark: address.get("landmark"),
        pincode: address.get("pincode"),
        addressId: address.get("addressId"),
      );
      _addressData.add(addressModel);
    });
    notifyListeners();
  }

  Future<void> deleteAddress(AddressModel currentAddress) async {
    // print(currentAddress.addressId);
    await FirebaseFirestore.instance
        .collection('delivery_address')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_addresses')
        .doc(currentAddress.addressId)
        .delete();
    _addressData.remove(currentAddress);

    notifyListeners();
  }
}
