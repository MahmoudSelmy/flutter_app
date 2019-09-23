import 'package:flutter/material.dart';
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
  SharedPreferences preferences;
  bool loading = false;
  bool isLogedin = false;

  @override
  void initState()
  {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }

  void isSignedIn() async
  {
    // Async means that you will not be locked for its return.
    setState(() {
      loading = true;
    });
    // await is "hold on till this code returns"
    preferences = await SharedPreferences.getInstance();
    isLogedin = await googleSignIn.isSignedIn();
    if(isLogedin)
      {
        // don't give the user the ability to back
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
      }
    setState(() {
      loading = false;
    });
  }

  Future handleSignIn() async
  {
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

    FirebaseUser firebaseUser = (await firebaseAuth.signInWithCredential(credential)).user;

    print('DARTOLOGY : Start 3');

    if( firebaseUser != null)
      {
        final QuerySnapshot result = await Firestore.instance.collection('users').where('id', isEqualTo: firebaseUser.uid).getDocuments();
        final List<DocumentSnapshot> documents = result.documents;
        if(documents.length == 0)
          {
            // TODO:  SignUp
            Firestore.instance.collection('user').document(firebaseUser.uid)
                .setData({'id': firebaseUser.uid, 'username' : firebaseUser.displayName, 'profilePicture':firebaseUser.photoUrl});

            await preferences.setString('id', firebaseUser.uid);
            await preferences.setString('username', firebaseUser.displayName);
            await preferences.setString('photoUrl', firebaseUser.photoUrl);
          }
        else
          {
            await preferences.setString('id', documents[0]['id']);
            await preferences.setString('username', documents[0]['username']);
            await preferences.setString('photoUrl', documents[0]['profilePicture']);
          }
        Fluttertoast.showToast(msg: 'Logged In.');
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
        setState(() {
          loading = false;
        });
      }
    else
      {
        Fluttertoast.showToast(msg: 'Login failed.');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Login', style: TextStyle(color: Colors.red.shade900),),
        elevation: 0.1,
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: FlatButton(
              color: Colors.red.shade900,
              onPressed: (){
                handleSignIn();
              },
              child: Text('Sign in / Sign Up with google'),
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
}
