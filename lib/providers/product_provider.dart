import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/models/product_model.dart';

class ProductProvider with ChangeNotifier {
  ProductModel _currentProduct = ProductModel();

  ProductModel get currentProduct => _currentProduct;

  void setCurrentProduct(ProductModel item) {
    _currentProduct = ProductModel(
      productName: item.productName,
      productImage: item.productImage,
      productPrice: item.productPrice,
      productWeight: item.productWeight,
      productDescription: item.productDescription,
      productId: item.productId,
    );
    notifyListeners();
  }

  List<ProductModel> _herbsSeasonings = [];

  List<ProductModel> get herbsSeasonings => _herbsSeasonings;

  void fetchHerbsProductData() async {
    QuerySnapshot value =
        await FirebaseFirestore.instance.collection("herbs_seasonings").get();

    value.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productName: element.get("productName"),
        productImage: element.get("productImage"),
        productPrice: element.get("productPrice"),
        productWeight: element.get("productWeight"),
        productDescription: element.get("productDescription"),
        productId: element.get("productId"),
      );
      // print(element.data());
      _herbsSeasonings.add(productModel);
    });
    notifyListeners();
  }

  List<ProductModel> _freshFruits = [];

  List<ProductModel> get freshFruits => _freshFruits;

  void fetchFreshFruitsData() async {
    QuerySnapshot response =
        await FirebaseFirestore.instance.collection("fresh_fruits").get();

    response.docs.forEach((element) {
      ProductModel productModel = ProductModel(
        productName: element.get("productName"),
        productImage: element.get("productImage"),
        productPrice: element.get("productPrice"),
        productWeight: element.get("productWeight"),
        productDescription: element.get("productDescription"),
        productId: element.get("productId"),
      );
      _freshFruits.add(productModel);
    });
    notifyListeners();
  }
}
