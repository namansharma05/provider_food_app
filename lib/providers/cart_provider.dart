import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:food_app/models/cart_model.dart';
import 'package:food_app/models/product_model.dart';

class CartProvider with ChangeNotifier {
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  void addCartItems(ProductModel item) async {
    await FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_cart_items')
        .doc(item.productId)
        .set({
      "cartItemName": item.productName,
      "cartItemImage": item.productImage,
      "cartItemPrice": item.productPrice,
      "cartItemDescription": item.productDescription,
      "cartItemWeight": item.productWeight,
      "cartItemQuantity": 1,
      "cartItemId": item.productId,
    });
    notifyListeners();
  }

  void deleteCartItems(CartModel item) async {
    await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("your_cart_items")
        .doc(item.cartItemId)
        .delete();
    _cartItems.remove(item);
    notifyListeners();
  }

  void fetchCartItems() async {
    _cartItems.removeRange(0, _cartItems.length);
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_cart_items')
        .get();

    value.docs.forEach((element) {
      CartModel cartModel = CartModel(
        cartItemName: element.get("cartItemName"),
        cartItemImage: element.get("cartItemImage"),
        cartItemPrice: element.get("cartItemPrice"),
        cartItemDescription: element.get("cartItemDescription"),
        cartItemWeight: element.get("cartItemWeight"),
        cartItemQuantity: element.get("cartItemQuantity"),
        cartItemId: element.get("cartItemId"),
      );
      _cartItems.add(cartModel);
    });
    notifyListeners();
  }

  Future<void> incrementItemQuantity(
      String cartItemId, int currentQuantity) async {
    try {
      await FirebaseFirestore.instance
          .collection('cart')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('your_cart_items')
          .doc(cartItemId)
          .update({
        'cartItemQuantity': currentQuantity + 1,
      });
      notifyListeners();
    } catch (e) {
      print('Error incrementing quantity: $e');
    }
  }

  // Decrement item quantity in Firebase
  Future<void> decrementItemQuantity(
      String cartItemId, int currentQuantity) async {
    if (currentQuantity > 1) {
      try {
        await FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('your_cart_items')
            .doc(cartItemId)
            .update({
          'cartItemQuantity': currentQuantity - 1,
        });
        notifyListeners();
      } catch (e) {
        print('Error decrementing quantity: $e');
      }
    }
  }

  void updateCartItems(CartModel item) async {
    final value = await FirebaseFirestore.instance
        .collection("cart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('your_cart_items')
        .doc(item.cartItemId)
        .get();

    _cartItems.forEach((element) {
      if (element.cartItemId == item.cartItemId) {
        element.cartItemQuantity = value.get("cartItemQuantity");
      }
    });
    notifyListeners();
  }

  fetchTotalPrice() {
    double price = 0.0;
    _cartItems.forEach((item) {
      price += item.cartItemPrice! * item.cartItemQuantity!.toInt();
    });
    return price;
  }
}
