// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_final_fields

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:e_commerce/features/cart/cart.dart';
import 'package:e_commerce/features/detail/product_detail.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../models/cart_model.dart';
import '../../models/trending_products_model.dart';
import '../../styles/colors.dart';
import '../../styles/text_style.dart';
import '../../widgets/main_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselController _controller = CarouselController();
  final optionItems = <TrendingProducts>[];
  List<Cart> _cart = [];
  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKdQJoSSOe1bdQFJdZ0BEpZ1mTMRzDStZc-d9uepr3TxzrN-Zk85T3BLr4XrD8c_Riq88&usqp=CAU',
    'https://images01.nicepagecdn.com/page/42/32/website-template-preview-42326.jpg',
    'https://cdn.yehaindia.com/wp-content/uploads/2020/11/1-1.jpg',
    'https://a57.foxnews.com/static.foxbusiness.com/foxbusiness.com/content/uploads/2020/02/931/523/Organic-Groceries-iStock.jpg?ve=1&tl=1',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTod6dQmhdI2bSl07DNBsh7ZEdEquJf6c29GNfaD2ohqEqLRv5Xt-yeVgMjQEO0_IpTDAQ&usqp=CAU',
    'https://media.istockphoto.com/id/871231060/photo/organic-food-signage-on-modern-supermarket-fresh-produce-vegetable-aisle.jpg?s=612x612&w=0&k=20&c=XbmsAmMzGGDyeA_iWUQFWCYLBFFtgz8NqKbLRmvOuPM=',
  ];

  void _addToCart(id) {
    dynamic index = _cart.indexWhere((item) => item.id == id);
    if (index != -1) {
      _cart[index].qty = (_cart[index].qty! + 1);
    } else {
      _cart.add(Cart(id: id, qty: 1));
    }
    setState(() {
      _cart = _cart;
    });
    setCartData(_cart);
  }

  setCartData(cart) async {
    List<String> cartList =
    cart.map((item) => jsonEncode(item.toMap())).toList();
    sharedPreferences?.setStringList("cart",
        cartList.cast<String>());
    getCartData();
  }

  SharedPreferences? sharedPreferences;
  dynamic list;

  getCartData() async {
    List<String>? listString = sharedPreferences?.getStringList('cart');
    if (listString != null) {
      setState(() {
        list =
            listString.map((item) => Cart.fromMap(json.decode(item))).toList();
      });
    }
  }
  loadSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance(); //Instantiating the object of SharedPreferences class.
  }

  @override
  void initState() {
    super.initState();
    loadSharedPreferences();
    getCartData();
    optionItems.add(TrendingProducts(
      1,
      'Peanut Butter',
      'https://m.media-amazon.com/images/I/51vhCj9DLdL.jpg',
      '120',
      'Peanut butter is loaded with so many good, health-promoting nutrients, including vitamin E, and vitamin B6.'
          'Research shows that people who regularly eat nuts and nut butter, including peanut butter, are less likely to develop heart disease',
      'It is OK to eat peanut butter every day, but in moderation. Do not eat more than 2 tablespoons, approximately 32 grams, a day. This protein-packed spread is made by blending roasted peanuts into a thick paste and contains various nutrients that promote good health. This makes the product perfect for dieters and joggers because it is nutrient-rich and can increase your energy.',
    ));
    optionItems.add(TrendingProducts(
        2,
        'Vegetable base',
        'https://www.gosupps.com/media/catalog/product/cache/25/image/1500x/040ec09b1e35df139433887a97daa66f/6/1/61iqE1jB_iL._SL1000_.jpg',
        '100',
        'A vegetable base is a concentrated vegetable stock. Start with vegetable stock, place it back onto the stove and continue to simmer until the liquid has evaporated by at least half. Vegetable Base is made by combining pureed carrots, celery, onions and tomato and aromatic seasonings.',
        'Vegetable stock is the liquid produced by simmering aromatic vegetables in water. Often made with a base of onions, celery, and carrots, vegetable stock can also incorporate leftover vegetable bits and pieces. Or try making an Asian vegetable stock with shiitake mushrooms, miso, and kombu. Vegetable broth is prepared to be used in flavoring side dishes such as rice or as a foundation for a soup. '));
    optionItems.add(TrendingProducts(
        3,
        'Soyabean Refined Oil',
        'https://rukminim1.flixcart.com/image/300/400/xif0q/edible-oil/x/h/e/1-zero-cholestrol-pouch-1-soyabean-oil-nutri-1992-original-imaggghzejjz8zzf.jpeg?q=90',
        '220',
        'Give your health the power of soyabean with Fortune soya Health Oil. Certified as india'
            's No.1 cooking oil, the safe and pure soyabeans oil has nutri-lock action which keeps you healthy every day.',
        'Consuming highly refined soybean oil in large quantities (like what you'
            'll find in many processed and fried foods) is not healthy. Using cold-pressed or unrefined soybean oil occasionally will not harm your health, but you'
            'll want to balance it out with other cooking oils like avocado oil and olive oil.'));
    optionItems.add(TrendingProducts(
        4,
        'Raw Honey',
        'https://m.media-amazon.com/images/I/81ntSlEBf2L.jpg',
        '310',
        'its use as a natural sweetener, honey is used as an anti-inflammatory, antioxidant and antibacterial agent. People commonly use honey orally to treat coughs and topically to treat burns and promote wound healing. It can also contain added sweeteners.',
        'All About Raw Honey: How Is It Different Than Regular Honey? Raw honey, strained from the honeycomb, has a number of health benefits. Regular honey goes through processing that may destroy some of honey'
            's healthiest compounds, like bee pollen and antioxidants.'));
    optionItems.add(TrendingProducts(
        5,
        'Vega Choclate',
        'https://cdn11.bigcommerce.com/s-ilgxsy4t82/products/149240/images/361854/vega-one-organic-chocolate-10-pack-rendering001-1024x1024__87074.1671708660.386.513.jpg?c=1',
        '200',
        'Most dark chocolate is inherently vegan. Superior quality dark chocolate only has a handful of ingredients: cocoa, (usually listed as cocoa mass and cocoa butter), sugar, lecithin, and sometimes vanilla.',
        'Chocolate is made using cacao beans which are found on cacao trees, meaning chocolate in its '
            'raw form'
            'is vegan friendly as it'
            's a plant-based food.'));
    optionItems.add(TrendingProducts(
        6,
        'Olive Oil',
        'https://images-na.ssl-images-amazon.com/images/I/61YtJCd8kkL._AC_UL600_SR600,600_.jpg',
        '299',
        'It'
            's best to choose Extra Virgin Olive Oil for our health and possibly for our hair. EVOO is highest in quality, natural antioxidants, vitamin E and phytosterols that give the oil its health benefits 4.',
        'Oleic acid is the primary monounsaturated fat found in olive oil and is a natural cleansing agent (surfactant). When used in Indian cooking, extra virgin olive oil can help to enhance the flavours of your dishes. '));
    optionItems.add(TrendingProducts(
        7,
        'Palm Sugar',
        'https://www.vhv.rs/dpng/d/606-6060727_organic-coconut-palm-sugar-1kg-organic-food-hd.png',
        '365',
        'Palm sugar is a healthier alternative to regular sugar because it is unrefined and has a lower glycemic index. It also contains vitamins and minerals that are absent in refined sugars.',
        'Palm sugar may act as an antioxidant and protect from DNA damage and cancer. It may also be beneficial in the case of diabetic ulcers. Further, it may lower blood pressure, enhance digestion and reduce fatigue. It can also be used as a natural sweetener.'));
    optionItems.add(TrendingProducts(
        8,
        'Probiotic Yogurt',
        'https://previews.123rf.com/images/72soul/72soul1203/72soul120300073/12861401-illustration-depicting-a-single-organic-probiotic-yogurt-container-arranged-over-white.jpg',
        '99',
        'With up to 61 different strains of microbes, it can be an excellent source of probiotics. People use specific clusters of microbes called kefir grains to ferment the milk.',
        'A yogurt with probiotic is simply one that contains an adequate quantity of certain living bacteria strains such as Streptococcus thermophilus and Lactobacillus bulgaricus. While both Curd and Yogurt contain probiotic bacteria, the quantity of bacteria in Yogurt is higher as compared to Curd.'));
    optionItems.add(TrendingProducts(
        9,
        'Oat Meal',
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-XCAeYLxped5fdKFKEo5JScAqDGDRFlLLQd0fP_qqltrIiRR-KTgzTdT_NV9PuINg9qc&usqp=CAU',
        '159',
        'Oats contain a type of soluble fiber, called beta glucan, which lowers blood glucose and cholesterol levels, thus reducing risk of heart disease and diabetes.',
        'it is good to eat oatmeal every day considering its nutritional profile and health benefits, including weight control and heart-healthy effect. As a breakfast food and mid-meal snack, oatmeal is potentially a better option than the majority of foods available in the market.'));
    optionItems.add(TrendingProducts(
        10,
        'Amla Powder',
        'https://veganmall.in/wp-content/uploads/2022/03/1-17.png',
        '109',
        'To sum up, amla powder is best known for its invaluable properties: preventing premature aging of the body, boosting immunity, improving blood circulation, lowering cholesterol, and strengthening the cardiovascular and nervous systems.',
        'Regular intake of amla not only leads to a healthy and glowing skin but also improves eye sight, boosts the immune system, and regulates blood sugar and lipids. Eat as murabba, pickles or candies; but consume it daily.'));
    optionItems.add(TrendingProducts(
        11,
        'Raw Cacao Butter',
        'https://www.doorsteporganics.com.au/image/optimised/large/Raw-Cacao-Butter-Buttons-Absolute-Organic-250g.jpg',
        '249',
        'Cacao butter is very healthy for the human body if consumed in moderation. It'
            's considered a heart-healthy fat as it'
            's high in monounsaturated and polyunsaturated fats.',
        'Cacao butter, also known as cocoa butter, is a type of fat that comes from cacao beans. To harness cacao butter, the beans are harvested from the cacao pods, and then cleaned and roasted.'));
    optionItems.add(TrendingProducts(
        12,
        'Oats Granola',
        'https://cdn.onegreen.in/wp-content/uploads/2020/09/05092820/OATS-GRANOLA-Pack-of-1.jpg',
        '399',
        'It'
            's a toasted mixture of rolled oats, nuts, and a sweetener like sugar or honey, though it can also include other grains, puffed rice, dried fruit, seeds, spices, and nut butters.',
        'Both oatmeal and granola make for a healthy, nutritious breakfast, but the winner for us is granola—the added nuts, seeds, and dried fruits give you a source of fiber and healthy fats that oatmeal can'
            't quite compete with.'));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: appBarBackgroundColor,
      appBar: mainAppBar(
          'HomePage',
          () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) =>
                        CartPage(cartList: _cart, optionItems: optionItems)),
              ),
          _cart.length),
      body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 12),
        Padding(
          padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarouselSlider(
                options: CarouselOptions(
                  height: 150.0,
                  viewportFraction: 1,
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 4),
                  autoPlayAnimationDuration: Duration(milliseconds: 800),
                  enlargeCenterPage: false,
                ),
                carouselController: _controller,
                items: imgList
                    .map((item) => Container(
                          child: Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  item.toString(),
                                  fit: BoxFit.cover,
                                  width: 1000,
                                )),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: 20),
              Text('Trending Products', style: homePageTextStyle),
              SizedBox(height: 18),
              GridView.builder(
                itemCount: optionItems.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisExtent: 168,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProductDetail(
                            optionItems[index].image,
                            optionItems[index].name,
                            optionItems[index].price,
                            optionItems[index].desc,
                            optionItems[index].spec),
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Flexible(
                        child: Container(
                          // height: 200,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            border: Border.all(color: borderColor, width: 0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(12),
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 7),
                              Image.network(
                                optionItems[index].image,
                                height: 75, width: 82,
                                // fit: BoxFit.fill
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(optionItems[index].name,
                                      overflow: TextOverflow.ellipsis,
                                      style: productListText,
                                      textAlign: TextAlign.center),
                                ),
                              ),
                              Text('₹ ${optionItems[index].price}',
                                  style: productListText),
                              SizedBox(height: 8),
                              _isItemExistInCart(optionItems[index].id) == true
                                  ? Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 7, right: 7),
                                            width: double.infinity,
                                            height: 23.0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (_) => CartPage(
                                                            cartList: _cart,
                                                            optionItems:
                                                                optionItems)));
                                              },
                                              child: Text('Go to Cart',
                                                  style:
                                                      addedProductListButton),
                                              style: OutlinedButton.styleFrom(
                                                backgroundColor:
                                                    greenButtonColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                side: BorderSide(
                                                    width: 0.7,
                                                    color: greenButtonColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        )
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 7, right: 7),
                                            width: double.infinity,
                                            height: 23.0,
                                            child: OutlinedButton(
                                              onPressed: () async {
                                                _addToCart(
                                                    optionItems[index].id);
                                                final snackBar = SnackBar(
                                                  duration: const Duration(
                                                      seconds: 1),
                                                  backgroundColor:
                                                      greenButtonColor,
                                                  content: SizedBox(
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(
                                                              '1 Item in cart',
                                                              style: addToCart,
                                                            ),
                                                            Text(
                                                              '₹ ' +
                                                                  optionItems[
                                                                          index]
                                                                      .price,
                                                              style:
                                                                  addCartPrice,
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            InkWell(
                                                              child: Text(
                                                                  'View Cart',
                                                                  style:
                                                                      addCartView),
                                                              onTap: () {
                                                                Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder: (_) => CartPage(
                                                                            cartList:
                                                                                _cart,
                                                                            optionItems:
                                                                                optionItems)));
                                                              },
                                                            ),
                                                            SizedBox(width: 5),
                                                            // icon-1
                                                            Icon(
                                                              Icons
                                                                  .arrow_forward_ios,
                                                              size: 11,
                                                              color: whiteColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              },
                                              child: Text('Add to Cart',
                                                  style: productListButton),
                                              style: OutlinedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                side: BorderSide(
                                                    width: 0.7,
                                                    color: greenButtonColor),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 18,
                                        )
                                      ],
                                    )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 17),
              Image.asset('assets/images/offer_image.png'),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset('assets/images/icon-fresh.png', height: 44),
                        SizedBox(height: 5),
                        Text('100%', style: homeIconTextStyle),
                        Text('Natural', style: homeIconTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/icon-healthy.png',
                            height: 44),
                        SizedBox(height: 5),
                        Text('Healthy', style: homeIconTextStyle),
                        Text('Cooking', style: homeIconTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/icon-natural.png',
                            height: 44),
                        SizedBox(height: 5),
                        Text('Always', style: homeIconTextStyle),
                        Text('Fresh', style: homeIconTextStyle),
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset('assets/images/icon-quality.png',
                            height: 44),
                        SizedBox(height: 5),
                        Text('Best', style: homeIconTextStyle),
                        Text('Quality', style: homeIconTextStyle),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ])),
    ));
  }

  _isItemExistInCart(id) {
    dynamic index = _cart.indexWhere((item) => item.id == id);
    return index >= 0 ? true : false;
  }
}
