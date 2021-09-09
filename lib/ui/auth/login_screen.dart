import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/models/user/user_request.dart';
import 'package:flutter_firebase/core/services/firebase_service.dart';
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
                bool result = await _service.signIn(
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
        ),
      ),
    );
  }
}
