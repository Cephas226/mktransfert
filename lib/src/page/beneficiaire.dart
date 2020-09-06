import 'package:flutter/material.dart';
import 'package:mktransfert/core/presentation/res/assets.dart';
import 'package:mktransfert/core/presentation/widget/rounded_bordered_container.dart';
import 'package:mktransfert/src/page/chooseBeneficiaire.dart';

import 'package:mktransfert/src/page/transaction.dart';

class BeneficiairePage extends StatefulWidget {
  static final String path = "lib/src/pages/settings/settings1.dart";
  @override
  _BeneficiairePageState createState() => _BeneficiairePageState();
}

class _BeneficiairePageState extends State<BeneficiairePage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        // brightness: _getBrightness(),
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
          title: Row(
              children: [
               Container(
                 child:GestureDetector(
                     onTap: () {  Navigator.push(context, MaterialPageRoute(
                         builder: (context) => ChooseBeneficiairePage()));},
                     child: Text("Ajouter",style: TextStyle(
                         fontWeight: FontWeight.bold, color: Colors.white))
                 ),
                  margin: const EdgeInsets.only(left: 300.0),
               )
              ]
          ),
          automaticallyImplyLeading: false,
        ),
        body: Column(

          children: <Widget>[
            const SizedBox(height: 20.0),
            Material(
              elevation: 30.0,
              borderRadius: BorderRadius.all(Radius.circular(30)),
              child: TextField(
                controller:
                TextEditingController(text: 'Recherche un bénéficiaire...'),
                cursorColor: Theme.of(context).primaryColor,
                style: TextStyle(color: Colors.black, fontSize: 18),
                decoration: InputDecoration(
                    suffixIcon: Material(
                      elevation: 2.0,
                      borderRadius:
                      BorderRadius.all(Radius.circular(30)),
                      child: Icon(Icons.search),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 25, vertical: 13)),
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, int index) {
                  return cartItems(index);
                },
              ),
            ),
           /* SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Bénéficiaires",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller:
                      TextEditingController(text: 'Recherche...'),
                      cursorColor: Theme.of(context).primaryColor,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                      decoration: InputDecoration(
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                            BorderRadius.all(Radius.circular(30)),
                            child: Icon(Icons.search),
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 25, vertical: 13)),
                    ),
                  ),

                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
  Widget cartItems(int index) {
    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(images[1]),
                  fit: BoxFit.cover,
                )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child:GestureDetector(
                            onTap: () {  Navigator.push(context, MaterialPageRoute(
                                builder: (context) => TransactionPage()));},
                            child: Text( "Nom:Cephas ZOUBGA",  style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),)
                        ),
                      ),
                      Container(
                        width: 50,
                        child: IconButton(
                          onPressed: () {
                            print("Button Pressed");
                          },
                          color: Colors.red,
                          icon: Icon(Icons.delete),
                          iconSize: 20,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Email: "),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '\cephaszoubga@gmail.com',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text("Adresse"),
                      SizedBox(
                        width: 5,
                      ),
                      Text('\Casablanca',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.black,
                          ))
                    ],
                  ),
/*                  Row(
                    children: <Widget>[
                      Text(
                        "Ships Free",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('2'),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {},
                            splashColor: Colors.lightBlue,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),*/
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
