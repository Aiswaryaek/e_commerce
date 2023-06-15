// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:e_commerce/features/home/home_page.dart';
import 'package:e_commerce/styles/colors.dart';
import 'package:flutter/material.dart';

import '../../styles/text_style.dart';

class OrderFailure extends StatefulWidget {
  const OrderFailure({Key? key}) : super(key: key);

  @override
  State<OrderFailure> createState() => _OrderFailureState();
}

class _OrderFailureState extends State<OrderFailure> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Oops! Payment Failed',
              style: productPriceText,
            ),
            SizedBox(
              height: 10,
            ),
            Image.asset(
              'assets/images/failure.jpg',
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Center(child: Text('Try again.', style: textStyle)),
          ],
        ),
      ),
    ));
  }
}
