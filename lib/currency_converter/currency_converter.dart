import 'package:flutter/material.dart';

class CurrecyConverter extends StatefulWidget {
  const CurrecyConverter({Key? key}) : super(key: key);

  @override
  State<CurrecyConverter> createState() => _CurrecyConverterState();
}

class _CurrecyConverterState extends State<CurrecyConverter> {
  var valueschoose = "Nepelese Rupees";
  var valueschoose1;
  @override
  Widget build(BuildContext context) {
    final _amount = TextEditingController();
    final _tot = TextEditingController();
    double cal;
    double result;

    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        // elevation: 0.0,
        backgroundColor: Colors.grey[200],
        title: const Text(
          'Currency Converter',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              // const Text("Currency Converter",
              //     style: TextStyle(fontSize: 30, color: Colors.black)),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _amount,
                decoration: InputDecoration(
                    labelText: "Amount",
                    labelStyle:
                        TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                "Nepelese Rupees",
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(
                height: 21,
              ),
              const Text(
                "To",
                style: TextStyle(fontSize: 16),
              ),
              DropdownButton<String>(
                  value: this.valueschoose1,
                  items: <String>['usd', 'Indian Rupees', 'euro']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) => setState(
                        () => this.valueschoose1 = value,
                      )),
              const SizedBox(
                height: 15,
              ),
              TextField(
                controller: _tot,
                decoration: InputDecoration(
                    labelText: "Total",
                    labelStyle:
                        TextStyle(fontSize: 15, color: Colors.grey.shade400),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  if (valueschoose == "Nepelese Rupees" &&
                      valueschoose1 == 'Indian Rupees') {
                    cal = int.parse(_amount.text) * 1.6;
                    result = cal;
                    _tot.text = result.toString();
                  } else if (valueschoose == "Nepelese Rupees" &&
                      valueschoose1 == 'usd') {
                    cal = int.parse(_amount.text) * 0.01;
                    result = cal;
                    _tot.text = result.toString();
                  } else if (valueschoose == "Nepelese Rupees" &&
                      valueschoose1 == 'euro') {
                    cal = int.parse(_amount.text) * 0.008;
                    result = cal;
                    _tot.text = result.toString();
                  }
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height / 14,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(5)),
                  child: const Text(
                    "Convert",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
