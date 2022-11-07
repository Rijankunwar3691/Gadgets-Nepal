import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/screen/review_cart/review_cart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class ProductDetail extends StatefulWidget {
  final String productname;
  final String productimage;
  final int productprice;
  final String productdescription;
  final String productid;
  var availablequantity;

  ProductDetail({
    Key? key,
    required this.availablequantity,
    required this.productimage,
    required this.productname,
    required this.productprice,
    required this.productid,
    required this.productdescription,
  }) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController textEditingController = TextEditingController();
  speak(String discription1) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    await flutterTts.speak(widget.productdescription);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReviewCart()));
              },
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 8,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey[200],
                  child: Center(
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: Image(
                          image: NetworkImage(widget.productimage),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Text(
                widget.productname,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rs.${widget.productprice}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Description :',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  ),
                  IconButton(
                      onPressed: () {
                        speak(widget.productdescription);
                      },
                      icon: const Icon(Icons.record_voice_over_rounded))
                ],
              ),
              Card(
                elevation: 8,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Wrap(children: [
                    Text(
                      widget.productdescription,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: SizedBox(
                    width: 250,
                    child: MaterialButton(
                        color: Colors.yellow,
                        onPressed: () {
                          FirebaseFirestore.instance
                              .collection('cart')
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .collection('usercart')
                              .doc(widget.productid)
                              .set({
                            'productid': widget.productid,
                            'productimage': widget.productimage,
                            'productname': widget.productname,
                            'productprice': widget.productprice,
                            'productquantity': 1,
                            'productdescription': widget.productdescription,
                            'availablequantity': widget.availablequantity,
                          });
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                              'Added to cart.',
                              style: TextStyle(color: Colors.black),
                            ),
                            backgroundColor: Colors.cyanAccent,
                          ));
                        },
                        child: const Text('Add to Cart'))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
