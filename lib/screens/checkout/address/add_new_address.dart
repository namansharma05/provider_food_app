import 'package:flutter/material.dart';
import 'package:food_app/providers/address_provider.dart';
import 'package:food_app/widgets/custom_textfield.dart';
import 'package:provider/provider.dart';

class AddNewAddress extends StatelessWidget {
  AddNewAddress({super.key});

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _alternateMobileNumberController =
      TextEditingController();
  final TextEditingController _houseNumberController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _landmarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final addressProvider = Provider.of<AddressProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          "Add new Address",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary, fontSize: 17),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      bottomNavigationBar: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 20,
        ),
        child: MaterialButton(
          onPressed: () {
            addressProvider.addNewAddress(
              _firstNameController.text,
              _lastNameController.text,
              int.parse(_mobileNumberController.text),
              int.parse(_alternateMobileNumberController.text),
              _houseNumberController.text,
              _areaController.text,
              _cityController.text,
              _stateController.text,
              _landmarkController.text,
              int.parse(_pincodeController.text),
            );
            addressProvider.fetchAddressDetails();
            Navigator.of(context).pop();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          color: Theme.of(context).colorScheme.primaryFixedDim,
          child: const Text("Add Address"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 10,
        ),
        child: ListView(
          children: [
            CustomTextfield(
              controller: _firstNameController,
              labText: "First Name",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _lastNameController,
              labText: "Last Name",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _mobileNumberController,
              labText: "Mobile Number",
              keyboardType: TextInputType.number,
            ),
            CustomTextfield(
              controller: _alternateMobileNumberController,
              labText: "Alternate Mobile Number",
              keyboardType: TextInputType.number,
            ),
            CustomTextfield(
              controller: _houseNumberController,
              labText: "House Number",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _areaController,
              labText: "Area",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _cityController,
              labText: "City",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _stateController,
              labText: "State",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _landmarkController,
              labText: "Landmark",
              keyboardType: TextInputType.text,
            ),
            CustomTextfield(
              controller: _pincodeController,
              labText: "Pincode",
              keyboardType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}
