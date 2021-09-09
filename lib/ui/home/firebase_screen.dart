import 'package:flutter/material.dart';
import 'package:flutter_firebase/core/models/user.dart';
import 'package:flutter_firebase/core/services/firebase_service.dart';

class FirebaseScreen extends StatefulWidget {
  const FirebaseScreen({Key? key}) : super(key: key);

  @override
  _FirebaseScreenState createState() => _FirebaseScreenState();
}

class _FirebaseScreenState extends State<FirebaseScreen> {
  late FirebaseService service;

  @override
  void initState() {
    super.initState();
    service = FirebaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: service.getUsers(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              if (snapshot.hasData) {
                return _listUser(snapshot.data);
              } else {
                return _getNotFoundWidget;
              }
            default:
              return _getWaitingWidget;
          }
        },
      ),
    );
  }

  Widget _listUser(userList) {
    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Text("${userList[index].userId}"),
          title: Text(userList[index].title),
          trailing: Text("${userList[index].id}"),
        );
      },
    );
  }

  Widget get _getNotFoundWidget => Center(child: Text("Text not found"));

  Widget get _getWaitingWidget => Center(child: CircularProgressIndicator());
}
