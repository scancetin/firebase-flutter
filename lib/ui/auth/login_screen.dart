import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/models/user/user_request.dart';
import 'package:flutter_firebase/core/services/firebase_service.dart';
import 'package:flutter_firebase/core/services/google_sign_in.dart';
import 'package:flutter_firebase/ui/home/firebase_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  FirebaseService _service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildSignInWithEmailAndPassword(context),
            SizedBox(height: 10),
            buildGoogleSignIn(context),
            SizedBox(height: 10),
            buildGoogleSignOut(context),
          ],
        ),
      ),
    );
  }

  buildGoogleSignIn(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        var data = await GoogleSignInHelper.getInstance.googleSignIn();
        if (data != null) {
          var userData = await GoogleSignInHelper.getInstance.signInWithGoogle();
          print("userData $userData");
        }
      },
      child: Icon(Icons.android, size: 40, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.greenAccent,
        side: BorderSide(color: Colors.green, width: 3),
      ),
    );
  }

  buildGoogleSignOut(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await GoogleSignInHelper.getInstance.googleSignOut();
      },
      child: Icon(Icons.exit_to_app, size: 40, color: Colors.white),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: EdgeInsets.all(10),
        primary: Colors.redAccent,
        side: BorderSide(color: Colors.red, width: 3),
      ),
    );
  }

  Column buildSignInWithEmailAndPassword(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _usernameController,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Username"),
        ),
        SizedBox(height: 5),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(border: OutlineInputBorder(), labelText: "Password"),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            bool result = await _service.emailSignIn(
              UserRequest(
                email: _usernameController.text,
                password: _passwordController.text,
                returnSecureToken: true,
              ),
            );

            if (result) {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => FirebaseScreen()));
            } else {
              Fluttertoast.showToast(msg: "ERROR");
            }
          },
          child: Icon(Icons.add, size: 40, color: Colors.redAccent),
          style: ElevatedButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(10),
            primary: Colors.transparent,
            side: BorderSide(color: Colors.redAccent, width: 3),
          ),
        ),
      ],
    );
  }
}
