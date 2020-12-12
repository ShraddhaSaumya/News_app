import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'News/news.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _pwd = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userc;
  User user;

  void signup(String _email, String _pwd) async {
    try {
      userc = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.toString(), password: _pwd.toString());
      user = userc.user;
      print(user.email);
      print(user.displayName);
      Navigator.push(context, MaterialPageRoute(builder: (context) => News()));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome On Board"),
        centerTitle: true,
      ),
      backgroundColor: Colors.blue.shade100,
      body: ListView(
        padding: EdgeInsets.only(left: 70, right: 70),
        children: <Widget>[
          SizedBox(height: 120),
          CircleAvatar(
            backgroundColor: Colors.blue.shade100,
            radius: 60,
            child: Image.asset(
              "assets/login.png",
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 60),
          TextField(
            autofocus: true,
            cursorHeight: 21,
            cursorWidth: 2,
            decoration: buildBorder("User Name", Icon(Icons.email_rounded)),
            controller: _email,
          ),
          SizedBox(height: 20),
          TextField(
            cursorHeight: 21,
            cursorWidth: 2,
            controller: _pwd,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: buildBorder(
                "Password", Icon(Icons.enhanced_encryption_rounded)),
          ),
          SizedBox(height: 10),
          FlatButton(
            color: Colors.white,
            onPressed: () => signup(
                _email.text.toString().trim(), _pwd.text.toString().trim()),
            child: Text(
              "Sign Up",
              style: TextStyle(color: Colors.black),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration buildBorder(String h, Icon i) {
    return InputDecoration(
        contentPadding: EdgeInsets.only(left: 25),
        hintText: h,
        suffixIcon: i,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(100)));
  }
}
