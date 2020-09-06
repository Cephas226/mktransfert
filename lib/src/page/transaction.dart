import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mktransfert/src/page/payment.dart';
import 'navigation.dart';

const request = "https://api.hgbrasil.com/finance?format=json&key=80f27c39";
class TransactionPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/auth3.dart";

  @override
  _TransactionState createState() => _TransactionState();
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class _TransactionState extends State<TransactionPage> {
  final dolarController = TextEditingController();
  final realController = TextEditingController();
  final euroController = TextEditingController();


  //here we have decleared the variables, that store rates from API
  double dollar_buy;
  double euro_buy;

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dollar_buy).toStringAsFixed(2);
    euroController.text = (real / euro_buy).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dollar_buy).toStringAsFixed(2);
    euroController.text =
        (dolar * this.dollar_buy / euro_buy).toStringAsFixed(2);
  }


  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro_buy).toStringAsFixed(2);
    dolarController.text =
        (euro * this.euro_buy / dollar_buy).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Converter"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getData(),
          //snapshot of the context/getData
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.blue, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ));
              default:
                if (snapshot.hasError) {
                  return Center(
                      child: Text(
                        "Error :(",
                        style: TextStyle(color: Colors.blue, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ));
                } else {
                  dollar_buy =
                  //here we pull the us and eu rate
                  snapshot.data["results"]["currencies"]["USD"]["buy"];
                  euro_buy =
                  snapshot.data["results"]["currencies"]["EUR"]["buy"];
                  return SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.monetization_on,
                              size: 150.0, color: Colors.blue),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildTextField(
                                "Reals", "R\$", realController, _realChanged),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildTextField(
                                "Dollars", "US\$", dolarController, _dolarChanged),
                          ),
                          Divider(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildTextField(
                                "Euros", "€", euroController, _euroChanged),
                          ),
                          const SizedBox(height: 90.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RaisedButton(
                                elevation: 0,
                                padding: const EdgeInsets.only(left: 170,right: 170),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: Text("Continue"),
                                color: Colors.indigo,
                                textColor: Colors.white,
                                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentPage()),);},
                              ),
                            ],
                          )
                        ],
                      ));
                }
            }

          }),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.blue),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.blue, fontSize: 25.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true),
  );
}
