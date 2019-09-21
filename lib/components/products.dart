import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/product_details.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  var productList = [
    {
      "name": "Blazer",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
    },
    {
      "name": "Red dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 100,
      "price": 50,
    },
    {
      "name": "Hills A",
      "picture": "images/products/hills1.jpeg",
      "old_price": 10,
      "price": 5,
    },
    {
      "name": "Hills B",
      "picture": "images/products/hills2.jpeg",
      "old_price": 20,
      "price": 5,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: productList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return SingleProduct(
            name: productList[index]['name'],
            picture: productList[index]['picture'],
            oldPrice: productList[index]['old_price'],
            price: productList[index]['price'],
          );
        });
  }
}

class SingleProduct extends StatelessWidget {
  final String name;
  final String picture;
  final int oldPrice;
  final int price;

  const SingleProduct(
      {Key key, this.name, this.picture, this.oldPrice, this.price})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
        tag: name,
        child: Material(
          child: InkWell(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDetails(name: name, picture: picture,oldPrice: oldPrice,price: price,))),
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(name),),
                    // Expanded(child: Text('\$$oldPrice', style: TextStyle(decoration: TextDecoration.lineThrough),)),
                    Expanded(child: Text('\$$price', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16.0),textAlign: TextAlign.right,),),
                  ],
                ),
              ),
              child: Image.asset(
                picture,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
