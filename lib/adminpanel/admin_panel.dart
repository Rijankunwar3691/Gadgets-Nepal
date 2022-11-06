import 'package:ecommercenepal/provider/adminpanel_provider.dart';
import 'package:ecommercenepal/provider/order_provider.dart';
import 'package:ecommercenepal/provider/product_provider.dart';
import 'package:ecommercenepal/provider/userdata_provider.dart';
import 'package:ecommercenepal/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Page { dashboard, manage }

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  State<AdminPanel> createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  var items = [
    'Select',
    'Laptop',
    'Mobile',
    'Watches',
    'Earphones',
  ];
  String dropdownvalue = 'Select';
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;

  @override
  Widget build(BuildContext context) {
    AddproductsProvider addproductsProvider = Provider.of(context);
    ProductProvider productProvider = Provider.of(context);
    productProvider.fetchNewArchivesProductData();
    UserDataProvider userDataProvider = Provider.of(context);
    userDataProvider.fetchallUserData();
    OrderProvider orderProvider = Provider.of(context);
    orderProvider.getallOrderData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Row(
          children: <Widget>[
            Expanded(
                child: TextButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.dashboard);
                    },
                    icon: Icon(
                      Icons.dashboard,
                      color:
                          _selectedPage == Page.dashboard ? active : notActive,
                    ),
                    label: const Text('Dashboard'))),
            Expanded(
                child: TextButton.icon(
                    onPressed: () {
                      setState(() => _selectedPage = Page.manage);
                    },
                    icon: Icon(
                      Icons.sort,
                      color: _selectedPage == Page.manage ? active : notActive,
                    ),
                    label: const Text('Manage'))),
          ],
        ),
        elevation: 0.0,
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          height: double.infinity,
          width: double.infinity,
          child: _selectedPage == Page.dashboard
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              child: Card(
                                elevation: 8.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Products',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      productProvider
                                          .newArchivesProductList.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              child: Card(
                                elevation: 8.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: const [
                                    Text(
                                      'Sold',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      '10',
                                      style: TextStyle(
                                          fontSize: 30, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              child: Card(
                                elevation: 8.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Users',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      userDataProvider.getallUserDatalist.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              height: 200,
                              child: Card(
                                elevation: 8.0,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    const Text(
                                      'Orders',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      orderProvider.getallOrderList.length
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 30, color: Colors.red),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        height: 150,
                        //width: 300,
                        child: Center(
                            child: addproductsProvider.imageUrl.isEmpty
                                ? TextButton.icon(
                                    onPressed: () {
                                      addproductsProvider.productcategory =
                                          dropdownvalue;
                                      addproductsProvider.uploadImage();
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Colors.white),
                                    label: const Text(
                                      "Add Image",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : GridTile(
                                    footer: Container(
                                      color: Colors.white70,
                                      child: ListTile(
                                        title: IconButton(
                                            onPressed: () {
                                              addproductsProvider
                                                      .productcategory =
                                                  dropdownvalue;
                                              addproductsProvider.uploadImage();
                                            },
                                            icon:
                                                const Icon(Icons.add_a_photo)),
                                      ),
                                    ),
                                    child: Image(
                                      image: NetworkImage(
                                          addproductsProvider.imageUrl),
                                    ),
                                  )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          controller: addproductsProvider.productName,
                          labText: 'Product Name'),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          controller: addproductsProvider.productPrice,
                          labText: "Product Price"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          controller: addproductsProvider.productDescription,
                          labText: "Product Description"),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                          controller: addproductsProvider.availablequantity,
                          labText: "Available Quantity"),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          const Text(
                            'Category',
                            style: TextStyle(fontSize: 16),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          DropdownButton(
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                            onPressed: () {
                              addproductsProvider.productcategory =
                                  dropdownvalue;
                              addproductsProvider.validator(context);
                            },
                            child: const Text('Add Product')),
                      )
                    ],
                  ),
                )),
    );
  }
}
