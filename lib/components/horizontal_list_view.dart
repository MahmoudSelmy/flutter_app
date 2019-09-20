import 'package:flutter/material.dart';

// state of this horizontal list state does not change it is a static widget
class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          new Icon(Icons.help),
          new Icon(Icons.help),
          new Icon(Icons.help),
        ],
      ),
    );
  }
}
class Category extends StatelessWidget
{
  final String imageLocation;
  final String imageCaption;

  Category({Key key, this.imageLocation, this.imageCaption}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: (){},
        child: ListTile(
          title: Image.asset(imageLocation),
          subtitle: Text(imageCaption),
        ),
      ),
    );
  }
}
