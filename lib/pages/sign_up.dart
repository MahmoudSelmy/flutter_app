import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/db/users.dart';

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
  UserServicies _userServicies = UserServicies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: buildStack(context),
      ),
    );
  }

  Stack buildStack(BuildContext context) {
    return Stack(
      children: <Widget>[
        buildBackgroung(),
        buildBackgroundImage(),
        buildOverlay(),
        buildInputForm(context),
        buildLoading()
      ],
    );
  }

  Image buildBackgroung() {
    return Image.asset(
        'images/main.jpeg',
        fit: BoxFit.cover,
        width:  MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
      );
  }

  Container buildBackgroundImage() {
    return Container(
        height:  MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Container(
          height: 300.0,
          width: 300.0,
          alignment: Alignment.topCenter,
          child:
          Image.asset('images/logo.png', width: 280.0, height: 280.0),
        ),
      );
  }

  Visibility buildLoading() {
    return Visibility(
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
      );
  }

  Container buildOverlay() {
    return Container(
        color: Colors.red.withOpacity((0.2)),
        width:  MediaQuery.of(context).size.width,
        height:  MediaQuery.of(context).size.height,
      );
  }

  Container buildInputForm(BuildContext context) {
    return Container(
        height:  MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        child: Container(
          alignment: Alignment.center,
          height: 300.0,
          width:  MediaQuery.of(context).size.width,
          child: buildForm(context),
        ),
      );
  }

  Form buildForm(BuildContext context) {
    return Form(
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
                  Icons.lock, 'Password', validatePassword, _password,
                  obsecure: true),
              buildInputEntry(
                  Icons.lock, 'Confirm Password', validateConfirmPassword,
                  _confirnpassword, obsecure: true),
              buildLogo('Sign Up', validateForm),
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

  Padding buildLogo(String text, Function action) {
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
      TextEditingController controller, {bool obsecure = false}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.white.withOpacity(0.5),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: TextFormField(
            obscureText: obsecure,
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
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
      Pattern pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
          RegExp regex = RegExp(pattern);
      if (regex.hasMatch(mail))
      {
        return true;
      }
    }
    return false;
  }

  bool validatePassword(String password) {
    return password.length > 6;
  }

  bool validateConfirmPassword(String password) {
    return password == _password.text;
  }

  radioValueChanged(e) {
    setState(() {
      groupValue = e;
      gender = e;
    });
  }

  Future validateForm() async
  {
    setState(() {
      loading = true;
    });
    FormState formState = _formKey.currentState;
    if (formState.validate())
    {
      // formState.reset();
      FirebaseUser user = await firebaseAuth.currentUser();
      if (user == null) {
        AuthResult result = await firebaseAuth.createUserWithEmailAndPassword(email: _email.text, password: _password.text)
            .catchError((err)=>{print(err.toString())});
        FirebaseUser newUser = result.user;
        if(newUser != null)
          {
            _userServicies.createUsers({
              'username':_name.text,
              'email' : _email.text,
              'userId':newUser.uid.toString(),
              'gender' : gender,
            });
            setState(() {
              loading = false;
            });
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
          }
      }
    }
  }
}
