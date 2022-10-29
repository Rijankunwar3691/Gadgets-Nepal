// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommercenepal/screen/homepage/hompage.dart';
import 'package:ecommercenepal/screen/homepage/productdetail.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            leading: IconButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    )),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            backgroundColor: Colors.grey[200],
            centerTitle: true,
            title: Card(
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Search for items in the store',
                ),
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
              ),
            )),
        body: StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection('NewArchives').snapshots(),
          builder: (context, snapshots) {
            return (snapshots.connectionState == ConnectionState.waiting)
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: snapshots.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshots.data!.docs[index].data()
                          as Map<String, dynamic>;

                      if (name.isEmpty) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productimage: snapshots.data!.docs[index]
                                      ["productimage"],
                                  productname: snapshots.data!.docs[index]
                                      ["productname"],
                                  productprice: snapshots.data!.docs[index]
                                      ["productprice"],
                                  productdescription: snapshots
                                      .data!.docs[index]["productdescription"],
                                ),
                              )),
                          child: ListTile(
                            title: Text(
                              data['productname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['productprice'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['productimage']),
                            ),
                          ),
                        );
                      }
                      if (data['productname']
                          .toString()
                          .toLowerCase()
                          .startsWith(name.toLowerCase())) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                  productimage: snapshots.data!.docs[index]
                                      ["productimage"],
                                  productname: snapshots.data!.docs[index]
                                      ["productname"],
                                  productprice: snapshots.data!.docs[index]
                                      ["productprice"],
                                  productdescription: snapshots
                                      .data!.docs[index]["productdescription"],
                                ),
                              )),
                          child: ListTile(
                            title: Text(
                              data['productname'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              data['productprice'].toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold),
                            ),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['productimage']),
                            ),
                          ),
                        );
                      }
                      return Container();
                    });
          },
        ));
  }
}
