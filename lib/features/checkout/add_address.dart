// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:e_commerce/features/cart/cart.dart';
import 'package:e_commerce/features/checkout/checkout_screen.dart';
import 'package:e_commerce/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';
import '../../styles/text_style.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/number_text_field.dart';
import '../../widgets/text_filed.dart';

class AddAddress extends StatefulWidget {
  final List<Cart> cartList;
  dynamic optionItems;
   AddAddress(this.cartList,this.optionItems,{Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final zipController = TextEditingController();
  final localityController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();

  String nameErrorMessage = "";

  bool validateFirstName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        nameErrorMessage = "Name can't be empty";
      });
      return false;
    } else {
      setState(() {
        nameErrorMessage = "";
      });
      return true;
    }
  }

  String lastErrorMessage = "";

  bool validateLastName(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        lastErrorMessage = "Last can't be empty";
      });
      return false;
    } else {
      setState(() {
        lastErrorMessage = "";
      });
      return true;
    }
  }

  String mobileErrorMessage = "";

  bool validateMobile(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        mobileErrorMessage = "Mobile can't be empty";
      });
      return false;
    } else {
      setState(() {
        mobileErrorMessage = "";
      });
      return true;
    }
  }

  String zipErrorMessage = "";

  bool validateZip(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        zipErrorMessage = "Pin code can't be empty";
      });
      return false;
    } else {
      setState(() {
        zipErrorMessage = "";
      });
      return true;
    }
  }

  String localityErrorMessage = "";

  bool validateLocality(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        localityErrorMessage = "Locality can't be empty";
      });
      return false;
    } else {
      setState(() {
        localityErrorMessage = "";
      });
      return true;
    }
  }

  String addressErrorMessage = "";

  bool validateAddress(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        addressErrorMessage = "Address can't be empty";
      });
      return false;
    } else {
      setState(() {
        addressErrorMessage = "";
      });
      return true;
    }
  }

  String cityErrorMessage = "";

  bool validateCity(String value) {
    if (!(value.isNotEmpty)) {
      setState(() {
        cityErrorMessage = "City can't be empty";
      });
      return false;
    } else {
      setState(() {
        cityErrorMessage = "";
      });
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBarBackgroundColor,
            appBar:
                appBar(context, 'Add Address', () => Navigator.pop(context)),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textFiled(setState, 'First name*', firstNameController,
                      nameErrorMessage),
                  textFiled(setState, 'Last name*', lastNameController,
                      lastErrorMessage),
                  numberTextFiled(setState, 'Contact Number*', phoneController,
                      mobileErrorMessage),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        height: 65,
                        child: TextField(
                          style: textStyle,
                          cursorColor: hintColor,
                          onChanged: (_) => setState(() {}),
                          controller: zipController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.only(left: 15, top: 2, bottom: 2),
                            fillColor: whiteColor,
                            filled: true,
                            hintText: 'Postal Code*',
                            hintStyle: hintTextStyle,
                            errorText:
                                zipController.text == '' ? zipErrorMessage : '',
                            // zipErrorMessage,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: whiteColor),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: whiteColor),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 9),
                      Expanded(
                        child: SizedBox(
                          width: 160,
                          height: 65,
                          child: TextField(
                            style: textStyle,
                            cursorColor: hintColor,
                            onChanged: (_) => setState(() {}),
                            controller: localityController,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: 2, bottom: 2),
                              fillColor: whiteColor,
                              filled: true,
                              hintText: 'Locality*',
                              hintStyle: hintTextStyle,
                              errorText: localityController.text == ''
                                  ? localityErrorMessage
                                  : '',
                              // localityErrorMessage,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(color: whiteColor),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  TextFormField(
                    style: textStyle,
                    maxLines: 10,
                    minLines: 4,
                    cursorColor: hintColor,
                    onChanged: (_) => setState(() {}),
                    controller: addressController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      fillColor: whiteColor,
                      filled: true,
                      hintText: "Address",
                      hintStyle: hintTextStyle,
                      errorText: addressController.text == ''
                          ? addressErrorMessage
                          : '',
                      // addressErrorMessage,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: whiteColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: whiteColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: whiteColor),
                      ),
                    ),
                  ),
                  textFiled(setState, 'City/District/Town*', cityController,
                      cityErrorMessage),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(20),
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: const [
                      Color(0xFF447B45),
                      Color(0xFFA1C945),
                    ],
                  ),
                ),
                child: TextButton(
                  onPressed: () {
                    onButtonClick();
                  },
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Center(
                        child: Text('Save Address', style: btnTextStyle)),
                  ),
                ),
              ),
            )));
  }
  late List<Cart> cartList;
  void onButtonClick() async {
    final isValidName = validateFirstName(firstNameController.text);
    final isValidLastName = validateLastName(lastNameController.text);
    final validateMobile = validateLastName(phoneController.text);
    final isValidCity = validateCity(cityController.text);
    final isValidZip = validateZip(zipController.text);
    final isValidLocality = validateLocality(localityController.text);
    final isValidAddress = validateAddress(addressController.text);
    if (isValidName &&
        isValidLastName &&
        validateMobile &&
        isValidCity &&
        isValidZip &&
        isValidLocality &&
        isValidAddress) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => CheckoutScreen(cartList:widget.cartList,optionItems: widget.optionItems,
                firstNameController.text,
                lastNameController.text,
                phoneController.text,
                cityController.text,
                zipController.text,
                localityController.text,
                addressController.text)),
      );
    }
  }
}
