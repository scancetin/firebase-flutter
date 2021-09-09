import 'dart:convert';
import 'dart:io';
import 'package:flutter_firebase/core/models/user.dart';
import 'package:flutter_firebase/core/models/user/user_request.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL = "https://fir-sample-api-5f7ac-default-rtdb.europe-west1.firebasedatabase.app/.json";
  static const String API_KEY = "AIzaSyBq9_tShr5iV7J9Acb_6haTCwvgOx5ex3Q";
  static const String FIREBASE_AUTH_URL = "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBq9_tShr5iV7J9Acb_6haTCwvgOx5ex3Q";

  Future<bool> signIn(UserRequest request) async {
    var jsonModel = json.encode(request.toJson());
    final response = await http.post(Uri.parse(FIREBASE_AUTH_URL), body: jsonModel);
    // print(response.body);
    switch (response.statusCode) {
      case HttpStatus.ok:
        return true;
      default:
        return false;
    }
  }

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse(FIREBASE_URL));

    switch (response.statusCode) {
      case HttpStatus.ok:
        Iterable jsonModel = json.decode(response.body);
        List<User> userList = List<User>.from(jsonModel.map((model) => User.fromJson(model)));
        return userList;
      default:
        return Future.error(response.statusCode);
    }
  }
}
