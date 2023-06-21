import 'dart:async';

import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_style.dart';
import '../home/home_page.dart';

class OrderSuccess extends StatefulWidget {
  const OrderSuccess({Key? key}) : super(key: key);

  @override
  State<OrderSuccess> createState() => _OrderSuccessState();
}

class _OrderSuccessState extends State<OrderSuccess> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: whiteColor,
      body:  Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text( 'Thanks for your Order',style: productPriceText,),
            SizedBox(height: 10,),
            Image.asset('assets/images/success.jpg',height: 120,),
            SizedBox(height: 10,),
            Center(child: Text('Your Order Confirmed', style: textStyle)),
          ],
        ),
      ),
    ));
  }
}
