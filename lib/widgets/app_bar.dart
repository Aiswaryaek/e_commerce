// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';

AppBar appBar(
    BuildContext context,String text,VoidCallback callback
    ) {
  return AppBar(
    automaticallyImplyLeading: true, // hides default back button
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
    leading:  IconButton(
      icon: Icon(Icons.arrow_back_rounded, color: whiteColor,size: 21,),
      onPressed: () {callback();},
    ),
    titleSpacing: 0,
    centerTitle: true,
    title: Text(text, style: mainAppBarStyle),
  );
}