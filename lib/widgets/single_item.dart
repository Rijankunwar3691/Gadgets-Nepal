import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SingleItem extends StatefulWidget {
  SingleItem(
      {Key? key,
      required this.productquantity,
      required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productid})
      : super(key: key);

  final String productname;
  final String productid;

  final String productimage;
  final int productprice;
  int productquantity;
  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int quantity = 1;
  void quantityFunction() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('usercart')
        .doc(widget.productid)
        .update({"productquantity": quantity});
  }

  void deleteProductFunction() {
    FirebaseFirestore.instance
        .collection('cart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('usercart')
        .doc(widget.productid)
        .delete();
  }

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
                      child: Image.network(widget.productimage),
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
                        widget.productname,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Rs.${widget.productprice * widget.productquantity}',
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
                        onPressed: () {
                          deleteProductFunction();
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.black54,
                          size: 20,
                        )),
                    Row(children: [
                      IncrementDecrement(
                          icon: Icons.add,
                          ontap: () {
                            setState(() {
                              quantity++;
                              quantityFunction();
                            });
                          }),
                      Text(widget.productquantity.toString()),
                      IncrementDecrement(
                          icon: Icons.remove,
                          ontap: () {
                            if (quantity > 1) {
                              setState(() {
                                quantity--;
                                quantityFunction();
                              });
                            }
                          })
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

class IncrementDecrement extends StatelessWidget {
  const IncrementDecrement({Key? key, required this.icon, required this.ontap})
      : super(key: key);
  final IconData icon;
  final VoidCallback ontap;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: MaterialButton(
      onPressed: ontap,
      child: Icon(icon),
    ));
  }
}
