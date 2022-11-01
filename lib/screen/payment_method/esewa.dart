import 'package:flutter/material.dart';
import 'package:esewa_pnp/esewa.dart';
import 'package:esewa_pnp/esewa_pnp.dart';

class Esewa extends StatefulWidget {
  @override
  State<Esewa> createState() => _EsewaState();
}

class _EsewaState extends State<Esewa> {
  ESewaPnp? _esewaPnp;
  final ESewaConfiguration _configuration = ESewaConfiguration(
    clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    environment: ESewaConfiguration.ENVIRONMENT_TEST,
  );
  @override
  void initState() {
    super.initState();
    _esewaPnp = ESewaPnp(configuration: _configuration);
  }

  double _amount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        centerTitle: true,
        title: const Text(
          "ESewa ",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amount = double.parse(value);
                });
              },
              decoration: const InputDecoration(
                labelText: "Enter amount",
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ESewaPaymentButton(
              _esewaPnp!,
              amount: _amount,
              callBackURL: "https://example.com",
              productId: "abc123",
              productName: "Flutter SDK Example",
              onSuccess: (result) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(result.message.toString())));
              },
              onFailure: (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(e.message.toString())));
              },
            ),
          ],
        ),
      ),
    );
  }
}
