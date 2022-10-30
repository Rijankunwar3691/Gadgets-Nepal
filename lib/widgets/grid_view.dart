import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../screen/homepage/hompage.dart';
import '../screen/homepage/productdetail.dart';
import '../screen/review_cart/review_cart.dart';
import '../screen/search/search.dart';

class GridViewWidget extends StatelessWidget {
  final String collection;
  final String id;

  // ignore: use_key_in_widget_constructors
  const GridViewWidget({required this.collection, required this.id});
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
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('categories')
            .doc(id)
            .collection(collection)
            .get(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                var productprice = snapshot.data!.docs[index]['productprice'];
                return Card(
                  elevation: 8.0,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 4,
                        child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Image(
                                image: NetworkImage(
                                    snapshot.data!.docs[index]['productimage']),
                                fit: BoxFit.fitHeight)),
                      ),
                      Flexible(
                        child: Text(
                          snapshot.data!.docs[index]['productname'],
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
                          "Rs.$productprice".toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
