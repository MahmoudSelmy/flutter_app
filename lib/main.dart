import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900
    ),
    home: Login(),
  ));
}
