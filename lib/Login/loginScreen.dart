import 'package:api_call/Login/SignUpScreen.dart';
import 'package:api_call/News/NewsFeed.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailTxt = new TextEditingController();
  TextEditingController _pwdTxt = new TextEditingController();

  var fapp = FirebaseAuth.instance;
  UserCredential userCred;
  User fuser;

  Future<void> fireBaseLogIn(String email, String pwd) async {
    try {
      userCred =
          await fapp.signInWithEmailAndPassword(email: email, password: pwd);
    } catch (e) {
      print(e);
    }
    if (userCred != null) {
      fuser = userCred.user;
      print(fuser);
      _toast("Login Successful");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsFeed()));
    } else {
      _toast("Login Failed");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.only(left: 80, right: 80),
        children: <Widget>[
          SizedBox(
            height: 50,
          ),
          Image.asset(
            "assets/icon.png",
            scale: 2.5,
          ),
          TextField(
            controller: _emailTxt,
            decoration: _borderDec("E-mail", Icon(Icons.email)),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: _pwdTxt,
            obscureText: true,
            decoration: _borderDec("Password", Icon(Icons.lock)),
          ),
          SizedBox(
            height: 30,
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: 40,
            ),
            onPressed: () => fireBaseLogIn(_emailTxt.text.toString().trim(),
                _pwdTxt.text.toString().trim()),
          ),
          SizedBox(
            height: 40,
          ),
          Center(
            child: Text("New User?"),
          ),
          Center(
            child: GestureDetector(
              onTap: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignUpScreen())),
              child: Text(
                "Create a new account.",
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          )
        ],
      ),
    );
  }
}

_borderDec(String hint, Icon _icon) {
  return InputDecoration(
      //prefixIcon: Icon(Icons.email),
      suffixIcon: _icon,
      contentPadding: EdgeInsets.only(top: 2, bottom: 2, left: 25),
      hintText: hint,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(70)));
}

_toast(String text) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey.shade900,
      textColor: Colors.white,
      fontSize: 16.0);
}
