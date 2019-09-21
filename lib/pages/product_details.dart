import 'package:flutter/material.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/components/products.dart';

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
              buildExpandedButton('Size', Icons.arrow_drop_down, onClose: () {
                Navigator.of(context).pop(context);
              }),
              buildExpandedButton('Color', Icons.arrow_drop_down,
                  onClose: () {}),
              buildExpandedButton('Qty', Icons.arrow_drop_down, onClose: () {}),
            ],
          ),
          Row(
            children: <Widget>[
              buildBuyButton('Buy Now'),
              IconButton(
                icon: Icon(
                  Icons.add_shopping_cart,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                onPressed: () {},
              ),
            ],
          ),
          Divider(),
          ListTile(
              title: Text('Product Details'),
              subtitle: Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")),
          Divider(),
          buildSpecsRow('Product name', 'Blazer'),
          buildSpecsRow('Product brand', 'X'),
          buildSpecsRow('Product condition', 'NEW'),
          Divider(),
          Padding(
            padding: EdgeInsets.all(8.0),
              child: Text('Similar products'),
          ),
          Container(height: 360.0, child: SimilarProducts())
        ],
      ),
    );
  }

  Row buildSpecsRow(String spec, String value) {
    return Row(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
          child: Text(spec, style: TextStyle(color: Colors.grey)),
        ),
        Padding(
          padding: EdgeInsets.all(5.0),
          child: Text(value),
        )
      ],
    );
  }

  Expanded buildExpandedButton(String text, IconData icon, {Function onClose}) {
    return Expanded(
      child: MaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(text),
                    content: Text('Select the ' + text),
                    actions: <Widget>[
                      MaterialButton(
                        onPressed: onClose,
                        child: Text('Close'),
                      )
                    ],
                  ));
        },
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
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
      ),
    );
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
          child: Text(widget.name)),
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

class SimilarProducts extends StatefulWidget {
  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  @override
  Widget build(BuildContext context) {
    return Products().createState().build(context);
  }
}
