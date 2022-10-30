import 'package:ecommercenepal/screen/review_cart/review_cart.dart';
import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final String productname;
  final String productimage;
  final int productprice;
  final String productdescription;
  

  const ProductDetail(
      {Key? key,
      required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productdescription})
      : super(key: key);

  Widget _buildColor(Color color) {
    return Flexible(
      child: Container(
        height: 60,
        width: 60,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                          image: NetworkImage(productimage),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ),
              Text(
                productname,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Rs.$productprice',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Description :',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              Card(
                elevation: 8,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.all(10),
                  child: Wrap(children: [
                    Text(
                      productdescription,
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ]),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Colors :',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
                width: MediaQuery.of(context).size.width * 0.65,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildColor(Colors.black),
                    _buildColor(Colors.blue),
                    _buildColor(Colors.cyan),
                    _buildColor(Colors.grey)
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 60,
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {},
                      child: const Text('Add to Cart')))
            ],
          ),
        ),
      ),
    );
  }
}
