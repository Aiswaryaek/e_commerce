import 'package:flutter/material.dart';

import '../styles/colors.dart';
import '../styles/text_style.dart';
Widget textFiled(StateSetter setState,String _hintText,TextEditingController _controller,String _errorText){
  return TextField(
    style: textStyle,
    controller: _controller,
  cursorColor: hintColor,
    onChanged: (_) => setState((){}),
    decoration: InputDecoration(
      contentPadding: EdgeInsets.only(left: 15,top: 2,bottom: 2),
        fillColor: whiteColor,
      filled: true,
      hintText: _hintText,
      hintStyle: hintTextStyle,
errorText: _controller.text == '' ? _errorText : '',
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: whiteColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
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
  );
}