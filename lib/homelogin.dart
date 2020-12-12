import 'package:api_app/News/news.dart';
import 'package:api_app/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _email = new TextEditingController();
  final TextEditingController _pwd = new TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  UserCredential userc;
  User user;

  Future<void> firebaseLogin(String em, String pw) async {
    try {
      userc = await auth.signInWithEmailAndPassword(email: em, password: pw);
      print("sucessful sign in");
    } catch (e) {
      print(e);
    }
    if (userc != null) {
      user = userc.user;
      print(user.email);
      print(user.displayName);
      Navigator.push(context, MaterialPageRoute(builder: (context) => News()));
    } else {
      print("Failed sign in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawerScrimColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "Login",
            style: TextStyle(fontSize: 25, letterSpacing: 1),
          ),
          centerTitle: true,
        ),
        backgroundColor: Colors.blue.shade100,
        body: ListView(
          padding: EdgeInsets.only(left: 70, right: 70),
          children: <Widget>[
            SizedBox(height: 100),
            CircleAvatar(
              backgroundColor: Colors.blue.shade100,
              radius: 54,
              child: Image.asset(
                "assets/login.png",
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              textAlign: TextAlign.center,
              autofocus: true,
              cursorHeight: 21,
              cursorWidth: 2,
              decoration: buildBorder("Email id", Icon(Icons.email_rounded)),
              controller: _email,
            ),
            SizedBox(height: 20),
            TextField(
              textAlign: TextAlign.center,
              cursorHeight: 21,
              cursorWidth: 2,
              obscureText: true,
              controller: _pwd,
              decoration: buildBorder(
                  "Password", Icon(Icons.enhanced_encryption_rounded)),
            ),
            SizedBox(height: 10),
            IconButton(
              color: Colors.lightBlue.shade800,
              icon: Icon(Icons.exit_to_app_rounded, size: 50),
              onPressed: () => firebaseLogin(
                  _email.text.toString().trim(), _pwd.text.toString().trim()),
            ),
            SizedBox(height: 40,),
            Center(
                child: Text(
              "New User?",
              style: TextStyle(
                letterSpacing: 1.5,
                color: Colors.black,
                fontSize: 17,
              ),
            )),
            SizedBox(height: 10,),
            GestureDetector(
              onTap: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp())),
              child: Text(" Sign Up",textAlign: TextAlign.center,
                style: TextStyle(color: Colors.purple,fontSize: 18,fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
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
