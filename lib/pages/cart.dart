import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title: Text('Total : '),
                subtitle: Text('\$230'),
              ),
            ),
            Expanded(
              child: MaterialButton(
                onPressed: (){},
                child: Text('Check out', style: TextStyle(color: Colors.white),),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
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

  AppBar buildAppBar() {
    return new AppBar(
      elevation: 0.1,
      backgroundColor: Colors.red,
      title: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          },
          child: Text('Cart')),
      actions: <Widget>[
        buildIconButton(Icons.search, Colors.white),
        buildIconButton(Icons.shopping_cart, Colors.white)
      ],
    );
  }
}