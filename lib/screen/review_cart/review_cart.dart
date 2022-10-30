import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/widgets/single_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReviewCart extends StatelessWidget {
  const ReviewCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ListTile(
        title: const Text('Total Amount'),
        subtitle: const Text('5000', style: TextStyle(color: Colors.red)),
        trailing: SizedBox(
          width: 160,
          child: MaterialButton(
            color: Colors.yellow[600],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusDirectional.circular(30)),
            onPressed: () {},
            child: const Text('Submit'),
          ),
        ),
      ),
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: const Text(
            'Review Cart',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .collection('usercart')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return SingleItem(
                    productimage: snapshot.data!.docs[index]['productimage'],
                    productname: snapshot.data!.docs[index]['productname'],
                    productprice: snapshot.data!.docs[index]['productprice']);
              },
            );
          }
        },
      ),
    );
  }
}
