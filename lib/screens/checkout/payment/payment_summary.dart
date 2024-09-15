import 'package:flutter/material.dart';
import 'package:food_app/providers/cart_provider.dart';
import 'package:food_app/screens/checkout/payment/google_pay.dart';
import 'package:food_app/widgets/delivery_address.dart';
import 'package:provider/provider.dart';

class PaymentSummary extends StatefulWidget {
  final int selectedAddress;
  const PaymentSummary({super.key, required this.selectedAddress});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}

class _PaymentSummaryState extends State<PaymentSummary> {
  final double _shippingCharges = 0;
  final double _discount = 10;
  int _selectedPaymentMode = 0;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final double total =
        cartProvider.fetchTotalPrice() + _shippingCharges - _discount;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          "Payment Summary",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 20,
        ),
        // color: Colors.red,
        height: 90,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Total Amount",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "\$$total",
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
              width: 180,
              child: MaterialButton(
                onPressed: () {
                  _selectedPaymentMode == 1
                      ? Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => GooglePay(),
                          ),
                        )
                      : null;
                },
                color: Theme.of(context).colorScheme.primaryFixedDim,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  "Place Order",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
              child: DeliveryAddress(selectedAddress: widget.selectedAddress),
            ),
            ExpansionTile(
              shape: const RoundedRectangleBorder(side: BorderSide.none),
              tilePadding: const EdgeInsets.symmetric(horizontal: 20),
              title: Text(
                "ordered Items (${cartProvider.cartItems.length})",
                style: const TextStyle(fontSize: 18),
              ),
              children: [
                ListView.builder(
                  itemCount: cartProvider.cartItems.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return listTile(
                        context, cartProvider.cartItems, index, cartProvider);
                  },
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Sub Total",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${cartProvider.fetchTotalPrice()}",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Shipping Charges",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "\$$_shippingCharges",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Discount",
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    "\$$_discount",
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: const Text(
                    "Payment Options",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
                ListTile(
                  leading: Radio(
                      value: 0,
                      groupValue: _selectedPaymentMode,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMode = value!;
                        });
                      }),
                  title: const Text(
                    "Cash On Delivery",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.currency_rupee_sharp),
                ),
                ListTile(
                  leading: Radio(
                      value: 1,
                      groupValue: _selectedPaymentMode,
                      onChanged: (value) {
                        setState(() {
                          _selectedPaymentMode = value!;
                        });
                      }),
                  title: const Text(
                    "UPI",
                    style: TextStyle(fontSize: 18),
                  ),
                  trailing: const Icon(Icons.payment),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget listTile(context, cartItems, index, cartProvider) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    cartItems[index].cartItemImage,
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${cartItems[index].cartItemName}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text("${cartItems[index].cartItemQuantity}"),
              ],
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text("${cartItems[index].cartItemWeight}"),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "\$${cartItems[index].cartItemPrice}",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
