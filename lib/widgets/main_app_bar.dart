// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

AppBar mainAppBar(String text, VoidCallback callback,int cartLength) {
  return AppBar(
    automaticallyImplyLeading: true,
    // hides default back button
    flexibleSpace: Container(
        decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF447B45),
          Color(0xFFA1C945),
        ],
      ),
    )),
    elevation: 0,
    backgroundColor: appBarBackgroundColor,
    title: Text(text, style: skipAppBar),
    centerTitle: true,
    actions: [
      Padding(
        padding: EdgeInsets.only(right: 16,top: 15),
        child: InkWell(
          child: cartLength == 0?Icon(
            Icons.shopping_cart,
            size: 24,
            color: whiteColor,
          ):Stack(
            children: [
              Icon(
                Icons.shopping_cart,
                size: 24,
                color: whiteColor,
              ),
              Positioned(
                top: 1,
                right: -2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    cartLength.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),onTap: (){
          callback();
        },
        )
      ),
    ],
  );
}
