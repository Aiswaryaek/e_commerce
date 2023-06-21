// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_interpolation_to_compose_strings

import 'package:e_commerce/features/checkout/order_failure.dart';
import 'package:e_commerce/features/checkout/order_success.dart';
import 'package:e_commerce/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../models/cart_model.dart';
import '../../models/trending_products_model.dart';
import '../../styles/text_style.dart';
import '../../widgets/app_bar.dart';
import 'add_address.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends StatefulWidget {
  final List<Cart> cartList;
  dynamic optionItems;
  String firstname;
  String lastname;
  String mobile;
  String city;
  String zip;
  String locality;
  String address;

  CheckoutScreen(this.firstname, this.lastname, this.mobile, this.city,
      this.zip, this.locality, this.address,
      {Key? key, required this.cartList,required this.optionItems})
      : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  Razorpay? _razorpay;

  @override
  void initState() {
    super.initState();
    _razorpay = new Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  amount() {
    return (_getTotalAmount() * 100 );
  }

  openCheckout() async {
    var options = {
      'key': 'rzp_test_tIRt2p3xnzZbOc',
      'amount': amount(),
      // 'order_id': orderId,
      'currency': 'INR',
      'theme.color': '#5cac55',
      'name': 'E_commerce',
      'description': 'Payment',
      'external': {
        'wallets': ['paytm']
      }
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      debugPrint('$e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderSuccess()));
    widget.cartList.clear();
    Fluttertoast.showToast(msg: "Payment Successful", timeInSecForIosWeb: 4);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => OrderFailure()));
    Fluttertoast.showToast(msg: "Payment Failed", timeInSecForIosWeb: 4);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {}

  _getProductByField(id, field) {
    int index = widget.optionItems.indexWhere((element) => element.id == id);
    if (index != -1) {
      TrendingProducts product = widget.optionItems[index];
      switch (field) {
        case 'name':
          return product.name;
        case 'image':
          return product.image;
        case 'price':
          return product.price;
        case 'desc':
          return product.desc;
        case 'spec':
          return product.spec;
      }
    }
  }

  double _getTotalItemPrice(id, qty) {
    int index = widget.optionItems.indexWhere((element) => element.id == id);
    if (index != -1) {
      TrendingProducts product = widget.optionItems[index];
      return double.parse(product.price) * qty;
    }
    return 0;
  }

  _getTotalAmount(){
    dynamic totalAmount = 0;
    for(var item in widget.cartList){
      totalAmount += _getTotalItemPrice(item.id,item.qty);
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBarBackgroundColor,
            appBar: appBar(
                context, 'Checkout Screen', () => Navigator.pop(context)),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      child: widget.firstname != ''
                          ? Container(
                              padding: EdgeInsets.fromLTRB(0, 10, 10, 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: borderColor,
                                ),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        widget.firstname +
                                            ' ' +
                                            widget.lastname,
                                        style: addressText),
                                    SizedBox(height: 3),
                                    Text(
                                      widget.address,
                                      style: tabBarText,
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      widget.zip + ', ' + widget.locality,
                                      style: tabBarText,
                                    ),
                                    SizedBox(height: 1),
                                    Text(widget.city + ', ' + widget.mobile,
                                        style: tabBarText),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox(
                              width: double.infinity,
                              child: OutlinedButton(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      color: blackColor,
                                      size: 16,
                                    ),
                                    SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      'Add new address',
                                      style: trendingProductTextStyle,
                                    ),
                                  ],
                                ),
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: appBarBackgroundColor,
                                  side:
                                      BorderSide(color: borderColor, width: 3),
                                  shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7))),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => AddAddress(widget.cartList,widget.optionItems)));
                                },
                              ),
                            )),
                  SizedBox(height: 20),
                  Text(
                    'Price Details',
                    style: productDetailText,
                  ),
                  SizedBox(height: 20),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.cartList.length,
                    itemBuilder: (context, index) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _getProductByField(
                              widget.cartList[index].id,
                              'name') + ' (' + widget.cartList[index].qty.toString() + 'Items )',
                          style: descriptionText,
                        ),
                        Text(
                         '₹ '+ _getProductByField(
                              widget.cartList[index].id,
                              'price'),
                          style: calorieText,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 6),
                  Divider(
                    thickness: 3,
                    color: whiteColor,
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Amount', style: productDetailText),
                      Text(
                        '₹ ${_getTotalAmount()}',
                        style: calorieText,
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomNavigationBar: Container(
              padding: EdgeInsets.all(20),
              child: Container(
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
                width: double.infinity,
                height: 45,
                child: TextButton(
                  onPressed: () {
                    widget.firstname==''?noAddressAdded():openCheckout();
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(23)),
                    // backgroundColor: greenButtonColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child:
                        Center(child: Text('Make Payment', style: skipAppBar)),
                  ),
                ),
              ),
            )));
  }
  noAddressAdded(){
    final snackBar = SnackBar(duration: const Duration(seconds: 1),
      backgroundColor: greenButtonColor,
      content: SizedBox(
        height: 30,
        child: Center(
          child: Text(
            'No address Added',
            style: addToCart,
          ),
        )
      ),
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar);
  }
}
