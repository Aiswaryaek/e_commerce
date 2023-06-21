// ignore_for_file: prefer_const_constructors, must_be_immutable, sort_child_properties_last, prefer_is_empty

import 'dart:convert';

import 'package:e_commerce/styles/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/cart_model.dart';
import '../../models/trending_products_model.dart';
import '../../styles/text_style.dart';
import '../../widgets/app_bar.dart';
import '../checkout/checkout_screen.dart';

class CartPage extends StatefulWidget {
  late final List<Cart> cartList;
  dynamic optionItems;

  CartPage({Key? key, required this.cartList, required this.optionItems})
      : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
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

  void _addQuantity(id) {
    final index = widget.cartList.indexWhere((element) => element.id == id);
    setState(() {
      widget.cartList[index].qty = (widget.cartList[index].qty! + 1);
    });
  }

  void _removeQuantity(id) {
    final index = widget.cartList.indexWhere((element) => element.id == id);
    final currentQuantity = widget.cartList[index].qty;
    if (currentQuantity! <= 1) {
      currentQuantity == 1;
    } else {
      setState(() {
        widget.cartList[index].qty = currentQuantity - 1;
      });
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

  _getTotalAmount() {
    double totalAmount = 0;
    for (var item in widget.cartList) {
      totalAmount += _getTotalItemPrice(item.id, item.qty);
    }
    return totalAmount;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: appBarBackgroundColor,
            appBar:
                appBar(context, 'Shopping Cart', () => Navigator.pop(context)),
            body: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: widget.cartList.length == 0
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height / 1.3,
                      child: Center(
                        child: Text(
                          'Your cart is empty 🥲',
                          style: descriptionText,
                        ),
                      ),
                    )
                  : Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(3, 3, 3, 3),
                        child: Column(
                          children: [
                            ListView.separated(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget.cartList.length,
                              separatorBuilder: (context, _) => Divider(
                                thickness: 0,
                                color: hintColor,
                              ),
                              itemBuilder: (context, index) => ListTile(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 1.0, horizontal: 0.0),
                                leading: Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Image.network(
                                      'https://qph.cf2.quoracdn.net/main-qimg-5667b229acf7393e62465dcd05c237f4.webp',
                                      height: 15,
                                      width: 15,
                                      fit: BoxFit.contain),
                                ),
                                title: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Transform.translate(
                                      offset: Offset(-26, -6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              _getProductByField(
                                                  widget.cartList[index].id,
                                                  'name'),
                                              style: calorieText,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          SizedBox(width: 1),
                                          Container(
                                            width: 96,
                                            height: 29,
                                            decoration: BoxDecoration(
                                              color: greenButtonColor,
                                              shape: BoxShape.rectangle,
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              border: Border.all(
                                                color: greenButtonColor,
                                                width: 1,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Center(
                                                  child: InkWell(
                                                    child: Icon(Icons.remove,
                                                        color: whiteColor,
                                                        size: 16),
                                                    onTap: () {
                                                      _removeQuantity(widget
                                                          .cartList[index].id);
                                                    },
                                                  ),
                                                ),
                                                Text(
                                                  '${widget.cartList[index].qty}',
                                                  style: addCartView,
                                                ),
                                                Center(
                                                  child: InkWell(
                                                    child: Icon(Icons.add,
                                                        color: whiteColor,
                                                        size: 16),
                                                    onTap: () {
                                                      _addQuantity(widget
                                                          .cartList[index].id);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10),
                                          Text(
                                              '₹ '
                                              '${_getTotalItemPrice(widget.cartList[index].id, widget.cartList[index].qty)}',
                                              style: calorieText)
                                        ],
                                      )),
                                ),
                                subtitle: Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Transform.translate(
                                      offset: Offset(-22, -6),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '₹ '
                                            '${_getProductByField(widget.cartList[index].id, 'price')} Only/-',
                                            style: inrText,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              onRemoveItem(index);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              size: 20,
                                              color: logoutColor,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            ),
                            Divider(
                              thickness: 0,
                              color: hintColor,
                            ),
                            SizedBox(height: 10),
                            Padding(
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total Amount',
                                    style: totalText,
                                  ),
                                  Text(
                                    '₹ ${_getTotalAmount()}',
                                    style: totalInrText,
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
            ),
            bottomNavigationBar: widget.cartList.length == 0
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF447B45),
                            Color(0xFFA1C945),
                          ],
                        ),
                      ),
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => CheckoutScreen(
                                    cartList: widget.cartList,
                                    optionItems: widget.optionItems,
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '',
                                    '')),
                          );
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(23)),
                          // backgroundColor: greenButtonColor,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Center(
                              child: Text('Checkout', style: skipAppBar)),
                        ),
                      ),
                    ),
                  )));
  }

  onRemoveItem(index) {
    showCupertinoDialog(
        context: context,
        builder: (BuildContext ctx) {
          return CupertinoAlertDialog(
            title: Text(
              'Confirm',
              style: dialogConfirmTextStyle,
            ),
            content: Text(
              'Do you want to remove this item?',
              style: splashSubtitleTextStyle,
            ),
            actions: [
              // The "Yes" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'No',
                  style: cancelTextStyle,
                ),
                isDefaultAction: true,
                isDestructiveAction: true,
              ),
              // The "No" button
              CupertinoDialogAction(
                onPressed: () {
                  setState(() {
                    widget.cartList.indexWhere(
                        (element) => element.id == widget.optionItems[index]);
                    widget.cartList.removeAt(index);
                    Navigator.of(context).pop();
                  });
                },
                child: Text(
                  'Yes',
                  style: logoutTextStyle,
                ),
                isDefaultAction: false,
                isDestructiveAction: false,
              )
            ],
          );
        });
  }
}
