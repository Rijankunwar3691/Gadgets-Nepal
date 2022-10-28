import 'package:flutter/material.dart';

class SingalProduct extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const SingalProduct(
      {required this.onTap,
      required this.productimage,
      required this.productname,
      required this.productprice});
  final String productname;
  final String productimage;
  final int productprice;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          elevation: 8.0,
          child: SizedBox(
            height: 200,
            width: 180,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    height: 150,
                    width: 160,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(productimage),
                            fit: BoxFit.fitHeight)),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    productname,
                    style: const TextStyle(
                        letterSpacing: 1.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Flexible(
                  child: Text(
                    'Rs.$productprice',
                    style: const TextStyle(
                        letterSpacing: 1.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
