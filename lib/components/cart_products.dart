import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  var products =
  [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "price": 85,
      "size":"M",
      "color":"Red",
      "quantity":1
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "price": 50,
      "size":"M",
      "color":"Red",
      "quantity":1
    }
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index){
          return CartProduct(
              name: products[index]['name'],
              picture: products[index]['picture'],
              price: products[index]['price'],
              size: products[index]['size'],
              color: products[index]['color'],
              quantity: products[index]['quantity']);
        });
  }
}

class CartProduct extends StatelessWidget {
  final String name;
  final String picture;
  final int price;
  final String size;
  final String color;
  final int quantity;

  const CartProduct({Key key, this.name, this.picture, this.price, this.size, this.color, this.quantity}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return Card(
      child: Row(
      children: <Widget>[
        Expanded(
          child: ListTile(
            leading: Image.asset(picture, width: 80.0, height: 80.0,),
            title: Text(name, style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),),
            subtitle: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: Text('Size :'),
                    ),
                    Expanded(
                      child: Text(size, textAlign: TextAlign.left, style: TextStyle(color: Colors.red),),
                    ),
                    Expanded(
                      child: Text('Color :'),
                    ),
                    Expanded(
                      child: Text(color, textAlign: TextAlign.left, style: TextStyle(color: Colors.red),),
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Text('\$$price', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 20.0,), textAlign: TextAlign.left,),
                  ),
                )
              ],
            ),
          ),
        ),
        buildQuantityContoller()
      ],
      ),
    );
  }

  Container buildQuantityContoller() {
    return Container(
        height: 80.0,
        width: 30.0,
        color: Colors.amberAccent,
        child: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: <Widget>[
              IconButton(icon: Icon(Icons.arrow_drop_up, ),iconSize: 35.0, onPressed: (){},),
              Text('$quantity', style: TextStyle(color: Colors.red, fontSize: 30.0, fontWeight: FontWeight.bold),),
              IconButton(icon: Icon(Icons.arrow_drop_down, ),iconSize: 35.0, onPressed: (){},),
            ],
          ),
        ),
      );
  }
}
