import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/provider/product_provider.dart';
import 'package:ecommercenepal/provider/userdata_provider.dart';
import 'package:ecommercenepal/screen/all%20products/view_all.dart';
import 'package:ecommercenepal/screen/homepage/productdetail.dart';
import 'package:ecommercenepal/screen/homepage/singal_product.dart';
import 'package:ecommercenepal/screen/search/search.dart';
import 'package:ecommercenepal/widgets/grid_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:flutter_carousel_slider/carousel_slider_indicators.dart';
import 'package:provider/provider.dart';

import '../../provider/userdata_provider.dart';
import '../order_history/order_history.dart';
import '../review_cart/review_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  late ProductProvider productProvider;
  late UserDataProvider userDataProvider;
  late final size = MediaQuery.of(context).size;
  bool homecolor = false;
  bool cartcolor = false;
  bool contactcolor = false;
  bool aboutcolor = false;
  bool logoutcolor = false;
  bool viewordercolor = false;
  Widget _buildproductcategory() {
    return Container(
      height: size.height * 0.15,
      margin: const EdgeInsets.only(right: 16.0),
      child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('categories').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GridViewWidget(
                                      collection: snapshot.data!.docs[index]
                                          ["categoryName"],
                                      id: snapshot.data!.docs[index].id),
                                ));
                          },
                          child: CircleAvatar(
                            maxRadius: 40,
                            child: Image(
                                image: AssetImage(snapshot.data!.docs[index]
                                    ['categoryimage'])),
                          ),
                        ),
                        Text(
                          snapshot.data!.docs[index]["categoryName"],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          }),
    );
  }

  Widget _buildUserAccountsDrawerHeader() {
    return Column(
        children: userDataProvider.getUserDatalist.map((e) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          e.userName,
          style: const TextStyle(color: Colors.black),
        ),
        currentAccountPicture: const CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: AssetImage('assets/userimage.png')),
        decoration: const BoxDecoration(color: Color(0xfff2f2f2)),
        accountEmail:
            Text(e.userEmail, style: const TextStyle(color: Colors.black)),
      );
    }).toList());
  }

  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.fetchNewArchivesProductData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    userDataProvider = Provider.of(context);
    productProvider = Provider.of(context);
    userDataProvider.fetchUserData();
    return Scaffold(
      key: _key,
      drawer: Drawer(
          child: ListView(
        children: [
          _buildUserAccountsDrawerHeader(),
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
            selected: homecolor,
            leading: const Icon(
              Icons.shopping_bag,
              color: Colors.black,
            ),
            title: const Text(
              'View Order',
              style: TextStyle(letterSpacing: 1.0),
            ),
            onTap: () {
              setState(() {
                viewordercolor = true;

                homecolor = false;
                cartcolor = false;
                contactcolor = false;
                aboutcolor = false;
                logoutcolor = false;
              });
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OrderHistory(),
                  ));
            },
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
              FirebaseAuth.instance.signOut();
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
                _buildproductcategory(),
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewAllProduct(),
                              ));
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
                                  availablequantity:
                                      newArchivesProductData.availablequantity,
                                  productid: newArchivesProductData.productid,
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
    );
  }
}
