import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../widgets/product_widget.dart';
import '../homepage/hompage.dart';
import '../review_cart/review_cart.dart';
import '../search/search.dart';

class ViewAllProduct extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const ViewAllProduct();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: IconButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                )),
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
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
      ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("NewArchives").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return ProductWidget(
                  productimage: snapshot.data!.docs[index]["productimage"],
                  productname: snapshot.data!.docs[index]["productname"],
                  productprice: snapshot.data!.docs[index]["productprice"],
                  productdescription: snapshot.data!.docs[index]
                      ["productdescription"],
                );
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
