import 'package:flutter/material.dart';
import 'payment_configuration.dart';
import 'package:pay/pay.dart';

class GooglePay extends StatefulWidget {
  const GooglePay({super.key});

  @override
  State<GooglePay> createState() => _GooglePayState();
}

class _GooglePayState extends State<GooglePay> {
  var googlePayButton = GooglePayButton(
    paymentConfiguration: PaymentConfiguration.fromJsonString(defaultGooglePay),
    paymentItems: const [
      PaymentItem(
          label: 'Total',
          amount: '199',
          status: PaymentItemStatus.final_price,
          type: PaymentItemType.total),
    ],
    width: double.infinity,
    type: GooglePayButtonType.pay,
    margin: const EdgeInsets.symmetric(
      horizontal: 20,
    ),
    onPaymentResult: (result) => debugPrint('Payment Result $result'),
    loadingIndicator: const Center(
      child: CircularProgressIndicator(),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: googlePayButton,
        ),
      ),
    );
  }
}
