import 'package:flutter/material.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/checkout/delivery/delivery_details.dart';
import 'package:food_app/screens/home/side_drawer.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    cartProvider.fetchCartItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'Cart',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      drawer: const SideDrawer(),
      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Your cart is empty",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return listTile(context, cartItems, index);
                    },
                  ),
                ),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    border: const Border(
                      top: BorderSide(width: 0.5),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            '\$ ${cartProvider.fetchTotalPrice().toString()}',
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => DeliveryDetails(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryFixedDim,
                          ),
                          child: const Text(
                            'Checkout',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget listTile(context, cartItems, index) {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItem = cartItems[index];
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(
        left: 10,
        top: 10,
        right: 10,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryFixed,
          border: Border.all(width: 0.5),
          borderRadius: BorderRadius.circular(15)),
      // height: 200,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                // tile image
                Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    image: DecorationImage(
                      image: NetworkImage(
                        cartItem.cartItemImage,
                      ),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                // tile title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        cartItem.cartItemName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        cartItem.cartItemPrice.toString(),
                        style: const TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // tile trailing
          SizedBox(
            width: 107,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    cartProvider.deleteCartItems(cartItem);
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          cartProvider.decrementItemQuantity(
                            cartItem.cartItemId,
                            cartItem.cartItemQuantity,
                          );
                          cartProvider.updateCartItems(cartItem);
                        },
                        icon: const Icon(Icons.remove),
                      ),
                      Text(
                        '${cartItem.cartItemQuantity}',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          cartProvider.incrementItemQuantity(
                            cartItem.cartItemId,
                            cartItem.cartItemQuantity,
                          );
                          cartProvider.updateCartItems(cartItem);
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
