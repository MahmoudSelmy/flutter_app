import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter_app/components/horizontal_list_view.dart';
import 'package:flutter_app/components/products.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: buildDrawer(),
      body: buildBody(),
    );
  }

  ListView buildBody() {
    Widget imageCarousel = buildImageCarousel();
    return ListView(
      children: <Widget>[
        imageCarousel,
        Padding(padding: const EdgeInsets.all(8.0),
        child: Text('Categories'),),
        // Horizontal List View
        HorizontalList(),
        Padding(padding: const EdgeInsets.all(20.0),
          child: Text('Recent Products'),),
        Container(
          height: 320.0,
          child: Products(),
        )
      ],

    );
  }

  Widget buildImageCarousel() {
    Widget imageCarousel = Container(
      height: 200.0,
      child: Carousel(
        // Match Parent Size
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/m1.jpeg'),
          AssetImage('images/m2.jpg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        dotColor: Colors.red,
        indicatorBgPadding: 2.0,
      ),
    );
    return imageCarousel;
  }

  Drawer buildDrawer() {
    return new Drawer(
      child: buildDrawerContent(),
    );
  }

  ListView buildDrawerContent() {
    return new ListView(
      children: <Widget>[
        // Header
        buildUserAccountsDrawerHeader(),
        // Body
        buildInkWell('Home Page', Icons.home),
        buildInkWell('My Account', Icons.person),
        buildInkWell('My Orders', Icons.shopping_basket),
        buildInkWell('Shopping Cart', Icons.shopping_cart),
        buildInkWell('Favorites', Icons.favorite),
        Divider(),
        buildInkWell('Settings', Icons.settings, color:Colors.blue),
        buildInkWell('Help', Icons.help, color:Colors.green),
      ],
    );
  }

  InkWell buildInkWell(String title, IconData iconData, {Color color = Colors.red}) {
    return InkWell(
          onTap: (){},
          child: ListTile(
            title: Text(title),
            leading: Icon(iconData, color: color,),
          ),
        );
  }

  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return new UserAccountsDrawerHeader(
          accountName: Text('Mahmoud Selmy'),
          accountEmail: Text('mahmoudselmy06@gmail.com'),
          currentAccountPicture: GestureDetector(
              child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,)
              )
          ),
          decoration: new BoxDecoration(
            color: Colors.red
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
