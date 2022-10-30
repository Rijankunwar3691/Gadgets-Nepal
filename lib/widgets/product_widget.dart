import 'package:flutter/material.dart';

import '../screen/homepage/productdetail.dart';

class ProductWidget extends StatelessWidget {
  final String productname;
  final String productimage;
  final int productprice;
  final String productdescription;
  final String productid;

  const ProductWidget({
    Key? key,
    required this.productimage,
    required this.productname,
    required this.productprice,
    required this.productdescription,
    required this.productid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                productid: productid,
                productdescription: productdescription,
                productimage: productimage,
                productname: productname,
                productprice: productprice,
              ),
            ));
      },
      child: Card(
        elevation: 8.0,
        child: Column(
          children: [
            Flexible(
              flex: 4,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                      image: NetworkImage(productimage),
                      fit: BoxFit.fitHeight)),
            ),
            Flexible(
              child: Text(
                productname,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5.0,
            ),
            Flexible(
              child: Text(
                'Rs.$productprice',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
