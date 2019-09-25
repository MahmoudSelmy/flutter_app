import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/sign_up.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primaryColor: Colors.red.shade900
    ),
    home: SignUp(),
  ));
}
