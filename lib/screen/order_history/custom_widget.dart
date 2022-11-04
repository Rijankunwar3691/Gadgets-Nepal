import 'package:flutter/material.dart';

class CustomWidget extends StatefulWidget {
  final String productname;
  final String productid;

  final String productimage;
  final String productstatus;

  final int productprice;
  final int productquantity;
  var purchasedatetime;
  CustomWidget(
      {Key? key,
      required this.productstatus,
      required this.purchasedatetime,
      required this.productid,
      required this.productimage,
      required this.productname,
      required this.productprice,
      required this.productquantity})
      : super(key: key);

  @override
  State<CustomWidget> createState() => _CustomWidgetState();
}

class _CustomWidgetState extends State<CustomWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'status : ${widget.productstatus}',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.productname,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Rs.${widget.productprice * widget.productquantity}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontSize: 14),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(widget.purchasedatetime.toString(),
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                widget.productquantity.toString(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
