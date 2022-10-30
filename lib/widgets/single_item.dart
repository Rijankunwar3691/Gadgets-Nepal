import 'package:flutter/material.dart';

class SingleItem extends StatelessWidget {
  SingleItem(
      {Key? key,
      required this.productimage,
      required this.productname,
      required this.productprice});

  final String productname;
  final String productimage;
  final int productprice;

  var quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Expanded(
                child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Image.network(productimage),
                    ))),
            Expanded(
                child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text(
                        productname,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs.$productprice',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ],
              ),
            )),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 100,
                child: Column(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black54,
                          size: 20,
                        )),
                    Row(children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.remove)),
                      ),
                      Text(quantity.toString()),
                      Expanded(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.add)),
                      )
                    ])
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
