import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String picture;
  final int oldPrice;
  final int price;

  const ProductDetails({Key key, this.name, this.picture, this.oldPrice, this.price}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: ListView(
        children: <Widget>[
          Container(
            height: 300.0,
            child: GridTile(
              child: Container(
                color: Colors.white,
                child: Image.asset(widget.picture),
              ),
            ),
          )
        ],
      ),
    );
  }
  AppBar buildAppBar() {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Colors.red,
      title: Text('Fashapp'),
      actions: <Widget>[
        buildIconButton(Icons.search, Colors.white),
        buildIconButton(Icons.shopping_cart, Colors.white)
      ],
    );
  }
  IconButton buildIconButton(IconData icon, Color color) {
    return new IconButton(
        icon: new Icon(icon, color: color,),
        onPressed: () {});
  }
}
