import 'dart:ffi';

import 'package:ecommercenepal/provider/product_provider.dart';
import 'package:ecommercenepal/screen/homepage/productdetail.dart';
import 'package:ecommercenepal/screen/homepage/singal_product.dart';
import 'package:ecommercenepal/screen/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:provider/provider.dart';
import '../authentication/login.dart';
import '../review_cart/review_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late ProductProvider productProvider;
  late final size = MediaQuery.of(context).size;
  bool homecolor = false;
  bool cartcolor = false;
  bool contactcolor = false;
  bool aboutcolor = false;
  bool logoutcolor = false;

  Widget _buildproductcategory(String image, String text) {
    return Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: InkWell(
        onTap: () {},
        child: Column(
          children: [
            CircleAvatar(
              maxRadius: 40,
              child: Image(image: AssetImage(image)),
            ),
            Text(
              text,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchNewArchivesProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);

    return SafeArea(
        child: Scaffold(
      key: _key,
      drawer: Drawer(
          child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text('Rijan Kunwar'),
            accountEmail: Text('Rijan_Kunwar@gmail.com'),
            currentAccountPicture: CircleAvatar(
              maxRadius: 45,
              backgroundImage: AssetImage('assets/rijan.jpg'),
            ),
          ),
          ListTile(
            selected: homecolor,
            leading: const Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: const Text(
              'Home',
              style: TextStyle(letterSpacing: 1.0),
            ),
            onTap: () {
              setState(() {
                homecolor = true;
                cartcolor = false;
                contactcolor = false;
                aboutcolor = false;
                logoutcolor = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
            },
          ),
          ListTile(
            selected: cartcolor,
            onTap: () {
              setState(() {
                homecolor = false;
                cartcolor = true;
                contactcolor = false;
                aboutcolor = false;
                logoutcolor = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ReviewCart(), //naviagte to homepage after validation
                  ));
            },
            leading: const Icon(Icons.shopping_cart),
            title: const Text(
              'Cart',
              style: TextStyle(letterSpacing: 1.0),
            ),
          ),
          ListTile(
            selected: contactcolor,
            onTap: () {
              setState(() {
                homecolor = false;
                cartcolor = false;
                contactcolor = true;
                aboutcolor = false;
                logoutcolor = false;
              });
            },
            leading: const Icon(Icons.phone),
            title: const Text(
              'Contact us',
              style: TextStyle(letterSpacing: 1.0),
            ),
          ),
          ListTile(
            selected: aboutcolor,
            onTap: () {
              setState(() {
                homecolor = false;
                cartcolor = false;
                contactcolor = false;
                aboutcolor = true;
                logoutcolor = false;
              });
            },
            leading: const Icon(Icons.info),
            title: const Text(
              'About',
              style: TextStyle(letterSpacing: 1.0),
            ),
          ),
          ListTile(
            selected: logoutcolor,
            leading: const Icon(Icons.logout),
            title: const Text(
              'Log out',
              style: TextStyle(letterSpacing: 1.0),
            ),
            onTap: () {
              setState(() {
                homecolor = false;
                cartcolor = false;
                contactcolor = false;
                aboutcolor = false;
                logoutcolor = true;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ));
            },
          ),
        ],
      )),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            _key.currentState!.openDrawer();
          },
          icon: const Icon(Icons.menu),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const Search(), //naviagte to homepage after validation
                  ));
            },
            icon: const Icon(
              Icons.search,
              color: Colors.black,
            ),
          ),
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ReviewCart(), //naviagte to homepage after validation
                    ));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
        centerTitle: true,
      ),
      body: Container(
          height: size.height,
          width: size.width,
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  child: CarouselSlider(
                    enableAutoSlider: true,
                    unlimitedMode: true,
                    autoSliderDelay: const Duration(seconds: 5),
                    slideIndicator: CircularSlideIndicator(
                        indicatorBackgroundColor: Colors.white,
                        currentIndicatorColor: Colors.blue,
                        indicatorBorderColor: Colors.grey),
                    children: [
                      Image.asset(
                        'assets/Best-HP-laptops.jpg',
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        'assets/fantechheadphone.jpg',
                        fit: BoxFit.contain,
                      ),
                      Image.asset(
                        'assets/iphone 13.png',
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Flexible(
                        child: Text(
                          'Categories',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        child: Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.15,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _buildproductcategory('assets/icon/laptop.png', 'Laptop'),
                      _buildproductcategory('assets/icon/mobile.png', 'Mobile'),
                      _buildproductcategory('assets/icon/watch.png', 'Watches'),
                      _buildproductcategory(
                          'assets/icon/listening.png', 'Earphones'),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.1,
                  width: size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Flexible(
                        child: Text(
                          'New Archives',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => const ArchivesProduct(),
                          //     ));
                        },
                        child: const Text(
                          'See All',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width,
                  height: size.height * 0.3,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: productProvider.getNewArchivesProductDatalist
                        .map((newArchivesProductData) {
                      return SingalProduct(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productimage:
                                      newArchivesProductData.productimage,
                                  productname:
                                      newArchivesProductData.productname,
                                  productprice:
                                      newArchivesProductData.productprice,
                                  productdescription:
                                      newArchivesProductData.productdescription,
                                ),
                              )),
                          productimage: newArchivesProductData.productimage,
                          productname: newArchivesProductData.productname,
                          productprice: newArchivesProductData.productprice);
                    }).toList(),

                    // children: [

                    // ],
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
