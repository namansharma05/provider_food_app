import 'package:flutter/material.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:food_app/screens/checkout/address/add_new_address.dart';
import 'package:food_app/screens/checkout/payment/payment_summary.dart';
import 'package:provider/provider.dart';

// enum addresses {};
class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({super.key});

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  bool isLoading = true;
  int? _selectedAddress = 0;
  @override
  void initState() {
    // TODO: implement initState
    final addressProvider =
        Provider.of<AddressProvider>(context, listen: false);
    addressProvider.fetchAddressDetails().then((onValue) {
      isLoading = false;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    final addressData = addressProvider.addressData;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          "Delivery Details",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddNewAddress(),
            ),
          );
        },
        backgroundColor: Theme.of(context).colorScheme.primaryFixedDim,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: addressData.isEmpty
          ? null
          : Container(
              height: 48,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PaymentSummary(
                        selectedAddress: _selectedAddress!,
                      ),
                    ),
                  );
                },
                color: Theme.of(context).colorScheme.primaryFixedDim,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text("Payment Summary"),
              ),
            ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 26,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Deliver To",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : addressData.isEmpty
                    ? const Center(
                        child: Text(
                          "No Address found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: addressData.length,
                        itemBuilder: (context, index) {
                          return listTile(
                              context, addressData, index, addressProvider);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget listTile(context, addressData, index, addressProvider) {
    final currentAddress = addressData[index];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Radio(
                  value: index,
                  groupValue: _selectedAddress,
                  onChanged: (value) {
                    setState(() {
                      _selectedAddress = value;
                    });
                  }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${currentAddress.firstName} ${currentAddress.lastName}",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    // color: Colors.red,
                    width: 270,
                    child: Text(
                      "${currentAddress.houseNumber}, ${currentAddress.area}, ${currentAddress.city}, ${currentAddress.state}, Near ${currentAddress.landmark}, ${currentAddress.pincode}",
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Text(
                    "Mobile No. - ${currentAddress.mobileNumber}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                ],
              ),
              IconButton(
                onPressed: () {
                  addressProvider.deleteAddress(currentAddress);
                },
                icon: Icon(
                  Icons.delete_forever,
                  size: 35,
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
