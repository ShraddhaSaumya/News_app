import 'package:api_call/News/NewsFeed.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _emailTxt = new TextEditingController();
  TextEditingController _pwdTxt = new TextEditingController();
  TextEditingController _nameTxt = new TextEditingController();
  TextEditingController _phnTxt = new TextEditingController();

  var fapp = FirebaseAuth.instance;
  UserCredential userCred;
  User fuser;

  Future<void> fireBaseLogIn(
      String email, String pwd, String name, String phn) async {
    try {
      userCred = await fapp.createUserWithEmailAndPassword(
          email: email, password: pwd);
    } catch (e) {
      print(e);
    }
    if (userCred != null) {
      fuser = userCred.user;
      fuser.updateProfile(displayName: name);
      _toast("Signed Up");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsFeed()));
    } else {
      _toast("Signup Failed");
    }
    print(email);
    print(pwd);
    print(phn);
    print(name);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
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
            controller: _nameTxt,
            decoration: _borderDec("Name", Icon(Icons.person_outline)),
          ),
          SizedBox(
            height: 30,
          ),
          TextField(
            controller: _phnTxt,
            decoration: _borderDec("Phone", Icon(Icons.phone)),
          ),
          SizedBox(
            height: 30,
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
            height: 40,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 70, left: 70),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              child: Icon(Icons.arrow_forward),
              color: Colors.blue,
              onPressed: () => fireBaseLogIn(
                  _emailTxt.text.toString().trim(),
                  _pwdTxt.text.toString().trim(),
                  _nameTxt.text.toString().trim(),
                  _phnTxt.text.toString().trim()),
            ),
          ),
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
