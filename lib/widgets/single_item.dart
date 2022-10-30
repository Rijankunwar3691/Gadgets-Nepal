import 'package:flutter/material.dart';

class SingleItem extends StatefulWidget {
  

  const SingleItem({Key? key,}) : super(key: key);

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int quantity = 1;

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
                      child: Image.network(
                          "https://static-01.daraz.com.np/p/c162eb76c19ee5d430741d95e2daaeb2.jpg"),
                    ))),
            Expanded(
                child: SizedBox(
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: const [
                      Text(
                        'Product Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs.20000',
                        style: TextStyle(
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
                                  onPressed: () {
                                    setState(() {
                                      if (quantity != 0) {
                                        quantity = quantity - 1;
                                      }
                                    });
                                  },
                                  icon: const Icon(Icons.remove)),
                            ),
                            Text(quantity.toString()),
                            Expanded(
                              child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      quantity = quantity + 1;
                                    });
                                  },
                                  icon: const Icon(Icons.add)),
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
