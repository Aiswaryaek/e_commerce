// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../../styles/text_style.dart';
import '../../widgets/app_bar.dart';

class ProductDetail extends StatefulWidget {
  String image;
  String name;
  String price;
  String desc;
  String spec;
   ProductDetail(this.image,this.name,this.price,this.desc,this.spec,{Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appBarBackgroundColor,
      appBar: appBar(context, 'Product Detail', () => Navigator.pop(context)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IntrinsicHeight(
              child: Container(
                height: 260,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: whiteColor,
                  border: Border.all(color: borderColor, width: 0.5),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.network(
                      widget.image,
                      height: 200,
                      width: 200,
                      // fit: BoxFit.fill,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15, 10, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 9),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Text(widget.name,
                              style: productDetailText)),
                      Text('In Stock', style: filterText),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹  ${widget.price} Only/-', style: productPriceText),
                    ],
                  ),
                  SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 15),
                    child: Divider(
                      thickness: 3,
                      color: whiteColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text('About', style: aboutPriceText),
                  SizedBox(height: 5),
                  Text(
                      widget.desc,
                      overflow: TextOverflow.fade,
                      style: descriptionText),
                ],
              ),
            ),
            ExpansionTile(iconColor: blackColor,
              title: Text(
                "More Info",
                style: categoryText,
              ),
              childrenPadding: EdgeInsets.only(left: 15,right: 15,bottom: 18),
              children: [
                Text(
                  widget.spec, overflow: TextOverflow.fade,
                  style: descriptionText,
                )

                //more child menu
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
