import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirnpassword = TextEditingController();

  SharedPreferences preferences;
  bool loading = false;

  String gender;
  String groupValue = "male";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/main.jpeg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              height: 300.0,
              width: 300.0,
              alignment: Alignment.topCenter,
              child:
              Image.asset('images/logo.png', width: 280.0, height: 280.0),
            ),
          ),
          Container(
            color: Colors.red.withOpacity((0.2)),
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              alignment: Alignment.center,
              height: 300.0,
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    buildInputEntry(
                        Icons.person, 'Full Name', validatePassword, _name),
                    buildGenderSelector(),
                    buildInputEntry(Icons.email, 'Email', validateMail, _email),
                    buildInputEntry(
                        Icons.lock, 'Password', validatePassword, _password),
                    buildInputEntry(
                        Icons.lock, 'Confirm Password', validatePassword,
                        _confirnpassword),
                    buildLogButton('Sign Up', () {}),
                    Divider(),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: RichText(
                        text: TextSpan(
                            style: TextStyle(color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16.0),
                            children: [
                              TextSpan(
                                  text: 'Do you have an account? click here to'
                              ),
                              TextSpan(
                                  text: 'log in!',
                                  style: TextStyle(color: Colors.red)
                              )
                            ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: loading ?? true,
            child: Center(
              child: Container(
                alignment: Alignment.center,
                color: Colors.white.withOpacity(0.9),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding buildGenderSelector() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.5),
        child: Container(
          height: 50.0,
          child: Row(
                          children: <Widget>[
                            Expanded(
                                child: ListTile(
                                    title: Text(
                                      'male',
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.end,),
                                    trailing: Radio(value: 'Male',
                                        groupValue: groupValue,
                                        activeColor: Colors.red,
                                        onChanged: (e) => radioValueChanged(e)))),
                            Expanded(
                                child: ListTile(
                                    title: Text(
                                      'Female',
                                      style: TextStyle(color: Colors.red),
                                      textAlign: TextAlign.end,),
                                    trailing: Radio(value: 'female',
                                        groupValue: groupValue,
                                        activeColor: Colors.red,
                                        onChanged: (e) => radioValueChanged(e)))),
                          ],
                        ),
        ),
      ),
    );
  }

  Padding buildLogButton(String text, Function action) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.red.withOpacity(0.8),
        elevation: 0.0,
        child: MaterialButton(
          onPressed: action,
          child: Text(text, textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.0),),
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
        ),
      ),
    );
  }

  Padding buildInputEntry(IconData icon, String hint, Function validator,
      TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.5),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: hint,
              icon: Icon(icon),
            ),
            validator: (value) {
              if (!validator(value)) {
                return 'Please enter a valid ' + hint;
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  bool validateMail(String mail) {
    if (mail.isNotEmpty) {
      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(mail)) {
        return true;
      }
    }
    return false;
  }

  bool validatePassword(String password) {
    return password.length > 6;
  }

  radioValueChanged(e) {
    setState(() {
      groupValue = e;
    });
  }
}
