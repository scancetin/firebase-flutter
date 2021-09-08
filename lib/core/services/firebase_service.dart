import 'dart:convert';
import 'dart:io';

import 'package:flutter_firebase/core/models/user.dart';
import 'package:http/http.dart' as http;

class FirebaseService {
  static const String FIREBASE_URL = "https://fir-sample-api-5f7ac-default-rtdb.europe-west1.firebasedatabase.app/.json";

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
