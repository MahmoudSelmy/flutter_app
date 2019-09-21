import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final String name;
  final String picture;
  final int oldPrice;
  final int price;

  const ProductDetails(
      {Key key, this.name, this.picture, this.oldPrice, this.price})
      : super(key: key);

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
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  title: Row(
                    children: <Widget>[
                      Expanded(
                          child: Text(
                        '\$${widget.oldPrice}',
                        style: TextStyle(
                            color: Colors.grey,
                            decoration: TextDecoration.lineThrough),
                      )),
                      Expanded(
                          child: Text(
                        '\$${widget.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              buildExpandedButton('Size', Icons.arrow_drop_down),
              buildExpandedButton('Color', Icons.arrow_drop_down),
              buildExpandedButton('Qty', Icons.arrow_drop_down),
            ],
          ),
          Row(
            children: <Widget>[
              buildBuyButton('Buy Now'),
              IconButton(
                icon: Icon(Icons.add_shopping_cart, color: Colors.red,),
                onPressed: (){},
              ),
              IconButton(
                icon: Icon(Icons.favorite, color: Colors.red,),
                onPressed: (){},
              ),
            ],
          )
        ],
      ),
    );
  }

  Expanded buildExpandedButton(String text, IconData icon) {
    return Expanded(
              child: MaterialButton(
                onPressed: () {},
                color: Colors.white,
                textColor: Colors.grey,
                elevation: 0.2,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(text),
                    ),
                    Expanded(
                      child: Icon(icon),
                    ),
                  ],
                ),
              ),
            );
  }
  Expanded buildBuyButton(String text) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {},
        color: Colors.red,
        textColor: Colors.white,
        elevation: 0.2,
        child: Text(text, textAlign: TextAlign.center,),
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
        icon: new Icon(
          icon,
          color: color,
        ),
        onPressed: () {});
  }
}
