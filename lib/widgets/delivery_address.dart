import 'package:flutter/material.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:provider/provider.dart';

class DeliveryAddress extends StatelessWidget {
  final int selectedAddress;
  const DeliveryAddress({super.key, required this.selectedAddress});

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final currentAddress = addressProvider.addressData[selectedAddress];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${currentAddress.firstName} ${currentAddress.lastName}",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          "${currentAddress.houseNumber}, ${currentAddress.area}, ${currentAddress.city}, ${currentAddress.state}, Near ${currentAddress.landmark}, ${currentAddress.pincode}",
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    );
  }
}
