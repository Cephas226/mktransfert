import 'package:flutter/material.dart';

class EcommerceOnePage extends StatelessWidget {

  Widget _buildListView(_, index) {
    if (index == 3) return _buildPopular();
  }

  Widget _buildPopular() {
    return Container(
      height: 180,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                _buildPopularItem(),
                SizedBox(
                  width: 10.0,
                ),
                _buildPopularItem(),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                _buildPopularItem(),
                SizedBox(
                  width: 10.0,
                ),
                _buildPopularItem(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildPopularItem() {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border(
                left: BorderSide(
                    color: Colors.red.shade200,
                    style: BorderStyle.solid,
                    width: 5))),
        child: ListTile(
          onTap: () {},
          title: Text("Vehicles"),
          subtitle: Text('120 people want this'),
          trailing: Container(
              width: 50,
             ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Flutter UIs'),
        elevation: 0,
      ),
      body: SafeArea(
          child: ListView.builder(
            itemBuilder: _buildListView,
            itemCount: 10,
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), title: Text('Messages')),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), title: Text('Cart')),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Account')),
        ],
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.red,
      ),
    );
  }
}
