import 'package:flutter/material.dart';
import 'package:flutter_app/pages/sign_up.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async {
    // Async means that you will not be locked for its return.
    setState(() {
      loading = true;
    });
    // await is "hold on till this code returns"
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if (isLogedin) {
      // don't give the user the ability to back
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
    }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async {
    preferences = await SharedPreferences.getInstance();

    setState(() {
      loading = true;
    });

    GoogleSignInAccount googleUser = await googleSignIn.signIn();
    print('DARTOLOGY : Start');
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    print('DARTOLOGY : Start 1');

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    print('DARTOLOGY : Start 2');

    FirebaseUser firebaseUser =
        (await firebaseAuth.signInWithCredential(credential)).user;

    print('DARTOLOGY : Start 3');

    if (firebaseUser != null) {
      final QuerySnapshot result = await Firestore.instance
          .collection('users')
          .where('id', isEqualTo: firebaseUser.uid)
          .getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      if (documents.length == 0) {
        // TODO:  SignUp
        Firestore.instance
            .collection('user')
            .document(firebaseUser.uid)
            .setData({
          'id': firebaseUser.uid,
          'username': firebaseUser.displayName,
          'profilePicture': firebaseUser.photoUrl
        });

        await preferences.setString('id', firebaseUser.uid);
        await preferences.setString('username', firebaseUser.displayName);
        await preferences.setString('photoUrl', firebaseUser.photoUrl);
      } else {
        await preferences.setString('id', documents[0]['id']);
        await preferences.setString('username', documents[0]['username']);
        await preferences.setString('photoUrl', documents[0]['profilePicture']);
      }
      Fluttertoast.showToast(msg: 'Logged In.');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      setState(() {
        loading = false;
      });
    } else {
      Fluttertoast.showToast(msg: 'Login failed.');
    }
  }

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
                    buildInputEntry(Icons.email, 'Email', validateMail, _email),
                    buildInputEntry(Icons.lock, 'Password', validatePassword, _password),
                    buildLogButton('LogIn', (){}),
                    Divider(),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                      },
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 16.0),
                          children: [
                            TextSpan(
                              text: 'Don\'t have an account? click here to'
                            ),
                            TextSpan(
                              text: 'sign up!',
                              style: TextStyle(color: Colors.red)
                            )
                          ]
                        ),
                      ),
                    ),
                    buildLogButton('Google', handleSignIn),
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

  Padding buildLogButton(String text, Function action) {
    return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.red.withOpacity(0.8),
                      elevation: 0.0,
                      child: MaterialButton(
                        onPressed: action,
                        child: Text(text, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),),
                        minWidth: MediaQuery.of(context).size.width,
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
}
